Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751601AbWCBQ5b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751601AbWCBQ5b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 11:57:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751996AbWCBQ5b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 11:57:31 -0500
Received: from mcr-smtp-002.bulldogdsl.com ([212.158.248.8]:6416 "EHLO
	mcr-smtp-002.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S1751601AbWCBQ5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 11:57:30 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Neil Brown <neilb@suse.de>
Subject: Re: RAID5 initial rebuild slow, 2.6.16-rc4
Date: Thu, 2 Mar 2006 16:57:22 +0000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <200603021648.21465.s0348365@sms.ed.ac.uk>
In-Reply-To: <200603021648.21465.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603021657.22345.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 March 2006 16:48, Alistair John Strachan wrote:
> Hi Neil,
>
> I recently purchased two SATA2 Western Digital WD2500KS (250GB) HDs to add
> to a pair of Maxtor DiamondMax 10's (200GB). I planned to initialise two
> 100GB RAID5 arrays spanning all four drives (the remaining 2x50GB on the
> new HDs is currently used for booting).
>
> All the drives are connected to the same controller. I'm running mdadm
> 2.3.1, which is the latest version I believe. I created the array with the
> following command:
>
> mdadm --create /dev/md1 --auto=yes --chunk=64 --level=5
> --raid-devices=4 /dev/sda3 /dev/sdb3 /dev/sdc2 /dev/sdd2

Okay, adding --force after --auto didn't fix it, but when I ran mkfs.xfs 
without waiting, the restore speed jumped to 20MB/s. Expected behaviour?

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
