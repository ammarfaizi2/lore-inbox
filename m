Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267319AbUIAQbQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267319AbUIAQbQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 12:31:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267671AbUIAQay
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 12:30:54 -0400
Received: from psems1.agilysys.com ([199.33.129.48]:12049 "HELO
	psems1.pios.com") by vger.kernel.org with SMTP id S267662AbUIAQ1h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 12:27:37 -0400
Subject: Re: Kernel or Grub bug.
From: "Wise, Jeremey" <jeremey.wise@agilysys.com>
To: "David B. Stevens" <dsteven3@maine.rr.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200409011135.36537.dsteven3@maine.rr.com>
References: <1094008341.4704.32.camel@wizej.agilysys.com>
	 <200408312358.08153.dsteven3@maine.rr.com>
	 <1094041227.4635.7.camel@wizej.agilysys.com>
	 <200409011135.36537.dsteven3@maine.rr.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 01 Sep 2004 12:26:25 -0400
Message-Id: <1094055985.4635.44.camel@wizej.agilysys.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.93 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-01 at 11:35 -0400, David B. Stevens wrote:
> Jeremey,
> 
> Your default kernel (the 104 SuSE one) has EXT2 specified as included in the 
> kernel.  The kernel you are trying to install has Reiser included in the 
> kernel.
My system is all reiserfs though the Fedora core box I also did testing
on was EXT3. 
wizej:/home/wisej/packages # mount
/dev/hda3 on / type reiserfs (rw,acl,user_xattr)
proc on /proc type proc (rw)
tmpfs on /dev/shm type tmpfs (rw)
devpts on /dev/pts type devpts (rw,mode=0620,gid=5)
/dev/hda1 on /boot type reiserfs (rw,acl,user_xattr)
/dev/hdc on /media/cdrecorder type subfs (ro,nosuid,nodev,fs=cdfss,
procuid,iocharset=utf8)
usbfs on /proc/bus/usb type usbfs (rw)

> 
> Here is my bet on your problem, the root device is an EXT2 partition and since 
> the EXT2 routines are not loaded the kernel goes belly up.
> 
> Please change  CONFIG_EXT2_FS=m to CONFIG_EXT2_FS=Y via the kernel config 
> system and re build the 2.6.8.1 kernel.
> 
> Also check your /etc/fstab here is mine: 
> 
Here is mine in return:>)
/dev/hda3            /                    reiserfs   acl,user_xattr
1 1
/dev/hda1            /boot                reiserfs   acl,user_xattr
1 2
/dev/hda2            swap                 swap       pri=42
0 0
devpts               /dev/pts             devpts     mode=0620,gid=5
0 0
proc                 /proc                proc       defaults
0 0
usbfs                /proc/bus/usb        usbfs      noauto
0 0
sysfs                /sys                 sysfs      noauto
0 0
/dev/cdrecorder      /media/cdrecorder    subfs      fs=cdfss,ro,
procuid,nosuid,
nodev,exec,iocharset=utf8 0 0

> 
> Cheers,
>   Dave
Thanks for the suggestion. I appreciate any direction provided. I am
sure it is something stupid and so I started recompile of kernel to have
reiser, ext2, ext3 all modular (though I have tried that before).


-- 
Thanks,

Jeremey Wise
jeremey.wise@agilysys.com

All opinions or information expressed here are personal in nature and do
not reflect the official position of Agilysys Inc.
