Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262775AbUJ1EyW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262775AbUJ1EyW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 00:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262777AbUJ1EyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 00:54:22 -0400
Received: from mx13.sac.fedex.com ([199.81.197.53]:61445 "EHLO
	mx13.sac.fedex.com") by vger.kernel.org with ESMTP id S262775AbUJ1EyQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 00:54:16 -0400
Date: Thu, 28 Oct 2004 12:52:20 +0800 (SGT)
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
X-X-Sender: jchua@silk.corp.fedex.com
To: Andrew Morton <akpm@osdl.org>
cc: Mathieu Segaud <matt@minas-morgul.org>, axboe@suse.de,
       jfannin1@columbus.rr.com, agk@redhat.com, christophe@saout.de,
       Linux Kernel <linux-kernel@vger.kernel.org>, bzolnier@gmail.com
Subject: Re: 2.6.9-mm1: LVM stopped working (dio-handle-eof.patch)
In-Reply-To: <20041027132422.760d5f5e.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0410281245240.31882@silk.corp.fedex.com>
References: <87oeitdogw.fsf@barad-dur.crans.org> <1098731002.14877.3.camel@leto.cs.pocnet.net>
 <20041026123651.GA2987@zion.rivenstone.net> <20041026135955.GA9937@agk.surrey.redhat.com>
 <20041026213703.GA6174@rivenstone.net> <20041026151559.041088f1.akpm@osdl.org>
 <87hdogvku7.fsf@barad-dur.crans.org> <20041026222650.596eddd8.akpm@osdl.org>
 <20041027054741.GB15910@suse.de> <20041027064146.GG15910@suse.de>
 <877jpcgolt.fsf@barad-dur.crans.org> <20041027132422.760d5f5e.akpm@osdl.org>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 10/28/2004
 12:54:09 PM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 10/28/2004
 12:54:12 PM,
	Serialize complete at 10/28/2004 12:54:12 PM
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 27 Oct 2004, Andrew Morton wrote:
> Could someone pleeeeze send out a simple recipe for repeating this problem?

I'm using 2.6.10-rc1 and got the following error ...

# vgscan
   Reading all physical volumes.  This may take a while...
   Found volume group "vg01" using metadata type lvm2

# vgchange -a y
   0 logical volume(s) in volume group "vg01" now active

# lvcreate -L 100M -n lv01 vg01
   device-mapper ioctl cmd 0 failed: Inappropriate ioctl for device
   striped: Required device-mapper target(s) not detected in your kernel
   lvcreate: Create a logical volume


Can't create logical volume (lvcreate) using 2.6.10-rc1.

No problem with 2.6.9 and 2.4.28-rc1.

Lvm tools is LVM2.2.00.25.

Here's my partial .config (same as 2.6.9 which is working with lvm).

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
CONFIG_BLK_DEV_MD=m
# CONFIG_MD_LINEAR is not set
# CONFIG_MD_RAID0 is not set
# CONFIG_MD_RAID1 is not set
# CONFIG_MD_RAID10 is not set
# CONFIG_MD_RAID5 is not set
# CONFIG_MD_RAID6 is not set
# CONFIG_MD_MULTIPATH is not set
CONFIG_BLK_DEV_DM=y
# CONFIG_DM_CRYPT is not set
# CONFIG_DM_SNAPSHOT is not set
# CONFIG_DM_MIRROR is not set
# CONFIG_DM_ZERO is not set


Thanks,
Jeff.

