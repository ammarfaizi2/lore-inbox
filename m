Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751394AbVH2TEG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394AbVH2TEG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 15:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbVH2TEG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 15:04:06 -0400
Received: from mail0.lsil.com ([147.145.40.20]:44456 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S1751394AbVH2TEE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 15:04:04 -0400
Message-ID: <0E3FA95632D6D047BA649F95DAB60E5703662AF7@exa-atlanta>
From: "Ju, Seokmann" <sju@lsil.com>
To: "'Phil Dier'" <phil@icglink.com>, linux-kernel@vger.kernel.org
Cc: Scott Holdren <scott@icglink.com>, ziggy <ziggy@icglink.com>,
       Jack Massari <jack@icglink.com>
Subject: RE: Slow I/O with megaraid and u160 scsi jbod
Date: Mon, 29 Aug 2005 15:03:43 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2658.27)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> formatted the disks in question with a single JFS partition and they
> still exhibit this behaviour when used by themselves. I have verified
> that this behaviour is not present up until at least 2.6.12.3. Let me
> know what info I can collect that would be helpful.. Thanks.
Can you please specify following?
- driver version on 2.6.12.3
- F/W version on the controller you are using.

Thank you.

> -----Original Message-----
> From: Phil Dier [mailto:phil@icglink.com] 
> Sent: Monday, August 29, 2005 2:14 PM
> To: linux-kernel@vger.kernel.org
> Cc: Scott Holdren; ziggy; Jack Massari
> Subject: Slow I/O with megaraid and u160 scsi jbod
> 
> Hi,
> 
> I've had luck with this patch[1] (it at least eliminated the oopses
> I was getting), but now I'm having a different sort of problem with
> my setup[2] (the 2.6.13 release exhibits this behaviour as well). I
> have 2 u160 scsi jbods connected to this machine[3]. One is connected
> to an Adaptec card, and the other is connected to the Fusion MPT card
> (megaraid). All of the disks connected to the Adaptec card work fine,
> but when doing I/O on disks 2 and 3 on the megaraid card, it stalls
> considerably. When trying to sync a RAID1 device using the 4 148GB
> disks, the sync speed never goes above 2KB/s. When they finally get
> synched, IO stalls constantly. Watching with iostat confirms 
> this. I've
> formatted the disks in question with a single JFS partition and they
> still exhibit this behaviour when used by themselves. I have verified
> that this behaviour is not present up until at least 2.6.12.3. Let me
> know what info I can collect that would be helpful.. Thanks.
> 
> 
> 
> [1] http://www.ussg.iu.edu/hypermail/linux/kernel/0508.1/1952.html
> [2] http://www.icglink.com/debug-2.6.13-rc6.html
> [3] Diagram:
> 
> +---------+
> | Adaptec |
> +---------+
>      |
> +-------+-------+-------+-------+-------+
> | id: 0 | id: 1 | id: 2 | id: 3 | id: 4 |
> | 73GB  | 73GB  | 148GB | 148GB | 73GB  |
> +-------+-------+-------+-------+-------+
> 
> +----------+
> | megaraid |
> +----------+
>      |
> +-------+-------+-------+-------+-------+
> | id: 0 | id: 1 | id: 2 | id: 3 | id: 4 |
> | 73GB  | 73GB  | 148GB | 148GB | 73GB  |
> +-------+-------+-------+-------+-------+
> 
> -- 
> 
> Phil Dier (ICGLink.com -- 615 370-1530 x733)
> 
> /* vim:set noai nocindent ts=8 sw=8: */
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
