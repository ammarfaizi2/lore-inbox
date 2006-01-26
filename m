Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751398AbWAZVsg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398AbWAZVsg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 16:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbWAZVsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 16:48:36 -0500
Received: from vms048pub.verizon.net ([206.46.252.48]:60380 "EHLO
	vms048pub.verizon.net") by vger.kernel.org with ESMTP
	id S1751398AbWAZVsf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 16:48:35 -0500
Date: Thu, 26 Jan 2006 16:48:33 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest) (was:
 Rationale for RLIMIT_MEMLOCK?)
In-reply-to: <Pine.LNX.4.58.0601261332000.2917@shell2.speakeasy.net>
To: linux-kernel@vger.kernel.org
Reply-to: gene.heskett@verizon.net
Message-id: <200601261648.33764.gene.heskett@verizon.net>
Organization: Absolutely none - usually detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <20060123165415.GA32178@merlin.emma.line.org>
 <Pine.LNX.4.61.0601262204370.27891@yvahk01.tjqt.qr>
 <Pine.LNX.4.58.0601261332000.2917@shell2.speakeasy.net>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 26 January 2006 16:33, Vadim Lobanov wrote:
>On Thu, 26 Jan 2006, Jan Engelhardt wrote:
>> (removing Jens and Lee, as previous posts made that quite clear)
>>
>> >> I'm getting a grin:
>> >>
>> >> 15:46 takeshi:../drivers/ide > find . -type f -print0 | xargs -0
>> >> grep SG_IO (no results)
>> >>
>> >> Looks like it's already non-redundant :)
>> >
>> >everything in drivers/block/scsi_ioctl.c  is duplicate code and I
>> > am sure I would find more if I take some time....
>>
>> In what linux kernel version have you found that file?
>
>In taking a look at http://sosdg.org/~coywolf/lxr/ ...
>That file exists in versions 2.6.10 through 2.6.14. It's gone from
>2.6.15 and onward, however.
>No comment as to the validity of its contents to the argument at hand.
No, its apparently been moved (works for IBM maybe?)

#>locate scsi_ioctl.c
/usr/gene/src/linux-2.4.29/drivers/scsi/scsi_ioctl.c
/usr/gene/src/linux-2.4.21-pre7/drivers/scsi/scsi_ioctl.c
/usr/gene/src/linux-2.4.18-4/drivers/scsi/scsi_ioctl.c
/usr/gene/src/linux-2.4.19/drivers/scsi/scsi_ioctl.c
/usr/gene/src/linux-2.4.21-rc1-ck6/drivers/scsi/scsi_ioctl.c
/usr/gene/src/linux-2.4.21-pre5/drivers/scsi/scsi_ioctl.c
/usr/src/2.6.15-rc2-git6.bak/drivers/scsi/scsi_ioctl.c
/usr/src/2.6.15-rc2-git6.bak/block/scsi_ioctl.c
/usr/src/2.6.14.3-bak/drivers/block/scsi_ioctl.c
/usr/src/2.6.14.3-bak/drivers/scsi/scsi_ioctl.c
/usr/src/linux-2.6.15-rc2-git6/drivers/scsi/scsi_ioctl.c
/usr/src/linux-2.6.15-rc2-git6/block/scsi_ioctl.c
/usr/src/linux-2.6.15/block/scsi_ioctl.c
/usr/src/linux-2.6.15/drivers/scsi/scsi_ioctl.c
/usr/src/linux-2.6.15-rc3/drivers/scsi/scsi_ioctl.c
/usr/src/linux-2.6.15-rc3/block/scsi_ioctl.c
/usr/src/linux-2.6.14.2-pktwrt/drivers/block/scsi_ioctl.c
/usr/src/linux-2.6.14.2-pktwrt/drivers/scsi/scsi_ioctl.c
/usr/src/linux-2.6.14.1/drivers/block/scsi_ioctl.c
/usr/src/linux-2.6.14.1/drivers/scsi/scsi_ioctl.c
/usr/src/linux-2.6.14.3/drivers/block/scsi_ioctl.c
/usr/src/linux-2.6.14.3/drivers/scsi/scsi_ioctl.c
/usr/src/linux-2.6.15-rc4/drivers/scsi/scsi_ioctl.c
/usr/src/linux-2.6.15-rc4/block/scsi_ioctl.c
/usr/src/linux-2.6.15-rc5/drivers/scsi/scsi_ioctl.c
/usr/src/linux-2.6.15-rc5/block/scsi_ioctl.c
/usr/src/kernel/git-core-0.99.7/linux/drivers/block/scsi_ioctl.c
/usr/src/kernel/git-core-0.99.7/linux/drivers/scsi/scsi_ioctl.c
/usr/src/kernel/linux/drivers/block/scsi_ioctl.c
/usr/src/kernel/linux/drivers/scsi/scsi_ioctl.c
/usr/src/linux-2.6.15-rc6/drivers/scsi/scsi_ioctl.c
/usr/src/linux-2.6.15-rc6/block/scsi_ioctl.c
/usr/src/linux-2.6.15-rc7/block/scsi_ioctl.c
/usr/src/linux-2.6.15-rc7/drivers/scsi/scsi_ioctl.c
/usr/src/linux-2.6.15.1/block/scsi_ioctl.c
/usr/src/linux-2.6.15.1/drivers/scsi/scsi_ioctl.c
/usr/src/linux-2.6.15.1/linux-2.6.15/block/scsi_ioctl.c
/usr/src/linux-2.6.15.1/linux-2.6.15/drivers/scsi/scsi_ioctl.c
/usr/src/linux-2.6.16-rc1/block/scsi_ioctl.c
/usr/src/linux-2.6.16-rc1/drivers/scsi/scsi_ioctl.c <----------
/usr/src/linux-2.4.23-pre8/drivers/scsi/scsi_ioctl.c
/usr/src/linux-2.4.23-pre8/linux-2.4.22/drivers/scsi/scsi_ioctl.c

And obviously its time for me to go on a housekeeping binge :)

-- 
Cheers, Gene
People having trouble with vz bouncing email to me should add the word
'online' between the 'verizon', and the dot which bypasses vz's
stupid bounce rules.  I do use spamassassin too. :-)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
