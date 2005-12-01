Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932232AbVLANom@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbVLANom (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 08:44:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932234AbVLANol
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 08:44:41 -0500
Received: from mail0.lsil.com ([147.145.40.20]:39842 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S932232AbVLANok (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 08:44:40 -0500
Message-ID: <0E3FA95632D6D047BA649F95DAB60E5703662C64@exa-atlanta>
From: "Ju, Seokmann" <Seokmann.Ju@engenio.com>
To: "'Vladimir Dergachev'" <volodya@mindspring.com>,
       linux-kernel@vger.kernel.org
Subject: RE: Megaraid problems
Date: Thu, 1 Dec 2005 08:41:38 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2658.27)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday, November 30, 2005 11:35 PM, Vladimir Dergachev wrote:
>     Problem: card recognizes the disks fine, initialization goes ok.
> I can create partition with no problem. However when copying 
> files I get
> filesystem corruption (holds both with ext3 and XFS). For 
> ext3 I see the 
> following message:
Can you please try with following changes to seeif it works?
- configure the controller with 1 400GB RAID0 instead of 4 400GB RAID5
- 4GB (or less) memory

Also, please provide following information.
- F/W on the MegaRAID controller version

Thank you,

Seokmann

> -----Original Message-----
> From: Vladimir Dergachev [mailto:volodya@mindspring.com] 
> Sent: Wednesday, November 30, 2005 11:35 PM
> To: linux-kernel@vger.kernel.org
> Subject: Megaraid problems
> 
> 
> Hi all :)
> 
>     I am wondering whether someone can shed some light on issues I am 
> having with LSI Megaraid cards ? The problem described below is with
> SATA card, but I am also having difficulties with LSI HBA 
> Scsi adaptor, 
> ableit I have not yet eliminated all the obvious things to try.
> 
>     Please CC your replies as I am not on the list..
> 
>     My setup: dual Opteron 252 with 8 GB RAM, Tyan Thunder 
> K8W. SUSE 9.3 -
> I tried both the native SUSE kernel and 2.6.14.3 from 
> kernel.org, 4 400GB 
> Western Digital drivers in RAID5 configuration connected to 
> LSI MegaRAID 
> SATA 150-6
> 
>     The are also 3 250 GB drives connected to on-board 
> SIL3114 where Linux 
> is installed.
> 
>     Problem: card recognizes the disks fine, initialization goes ok.
> I can create partition with no problem. However when copying 
> files I get
> filesystem corruption (holds both with ext3 and XFS). For 
> ext3 I see the 
> following message:
> 
> EXT3-fs error (device sdd1): ext3_new_block: Allocating block 
> in system zone - 
> block = 100663296
> Aborting journal on device sdd1.
> EXT3-fs error (device sdd1) in ext3_prepare_write: Journal has aborted
> ext3_abort called.
> EXT3-fs error (device sdd1): ext3_journal_start_sb: Detected 
> aborted journal
> Remounting filesystem read-only
> 
>     The hardware is otherwise stable - this box also has 3 
> disks in software 
> RAID5 connected to SIL3114 and a similar box has 3ware card 
> with 8 drives, 
> which function fine.
> 
>     I would appreciate any suggestions on what to try/tweak/patch.
> 
>                  thank you very much !
> 
>                        Vladimir Dergachev
> 
> PS One more thing - none of LSI binary configuration tools 
> work - they report 
> they cannot find the adaptor even though /dev/megadev0 is 
> pointing to correct 
> adaptor (I tried both 253 and 254 for major numbers and 0,1,2,3,4 for 
> minor numbers). I was not successful in finding an 
> open-source management 
> tool..
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
