Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261375AbULEUGj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbULEUGj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 15:06:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261379AbULEUGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 15:06:38 -0500
Received: from out009pub.verizon.net ([206.46.170.131]:23292 "EHLO
	out009.verizon.net") by vger.kernel.org with ESMTP id S261375AbULEUGc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 15:06:32 -0500
Message-ID: <41B36A5D.50901@verizon.net>
Date: Sun, 05 Dec 2004 15:06:53 -0500
From: Jim Nelson <james4765@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Anandraj <anandrajm@fastmail.fm>
CC: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
Subject: Re: Booting 2.6.10-rc3
References: <1102256916.29858.210104494@webmail.messagingengine.com>
In-Reply-To: <1102256916.29858.210104494@webmail.messagingengine.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out009.verizon.net from [209.158.220.243] at Sun, 5 Dec 2004 14:06:31 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anandraj wrote:
> hi,
> My linux box with 2.6.9 kernel patched with 2.6.10-rc3 patch doesnot
> come up.
> It shows the following while booting-
> 
> root(hd0,4)
> Filesystem type is ext2fs , partition type 0x83
> kernel /vmlinuz-2.6.10-rc3 ro root=LABLE=/ rhgb quiet

try root=LABEL=/.

If that does not work, try passing the root fs as something like:

root=/dev/hda3

or wherever your root filesystem is.

>     [Linux-bzImage, setup=0x1400,size=0x187b53]
> initrd /initrd-2.6.10-rc3.img
>     [Linux-initrd @ 0x1fcb1000,0x2eb22 bytes]
> 
> Uncompressing Linux... Ok, booting kernel
> audit(1102189352.204:0):initialized
> Red Hat nash version 3.5.22 starting 
> mount: error 6 mounting ext3
> pivotroot: pivo_root(/sysroot,/sysroot/initrd) failed : 2
> umount /initrd/proc failed: 2
> Kenel panic - not syncing: No init found. Try Passing init=option to
> kernel.
> 
> 
> I am using Fedora 2 distro!
> The default kernel 2.6.5-1.358 that comes along with the distro works !
> 
> I had looked into various forums for "mount: error 6 mounting ext3",
> none of the aswers given by them worked,
> the answers like , making your ext3 module inbuilt ,also does not work !
> 
> Mine is a simple desktop PC with Pentium 4 512MB RAM, it does not deal
> with any SCSI stuff!
> Can somebody help me on this !! ??
> 

If you did not build an initrd, you do not need reference to an initrd in the 
grub.conf file.

> TIA,
> Anand
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

