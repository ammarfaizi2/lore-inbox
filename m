Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264538AbUGBNfZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264538AbUGBNfZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 09:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264541AbUGBNfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 09:35:25 -0400
Received: from smtp16.wxs.nl ([195.121.6.39]:51900 "EHLO smtp16.wxs.nl")
	by vger.kernel.org with ESMTP id S264538AbUGBNfI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 09:35:08 -0400
Date: Fri, 02 Jul 2004 15:49:04 +0200 (CEST)
From: Ferry van Steen <freaky@bananateam.nl>
Subject: Re: USB Memory Stick issues (After using it in Wyse Terminal
 (WindowsCE.NET))
To: linux-kernel@vger.kernel.org
Cc: aebr@win.tue.nl
Message-id: <Pine.LNX.4.33.0407021541270.30945-100000@www.bananateam.nl>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey there,

the patch Andries Brouwer gave me seems to work. That is, I can mount the
USB stick like:

mount /dev/sda /mnt/usbstick -t vfat

the specification of the filesystem is mandatory, mount will not auto
recognize the filesystem. Unfortunately I can not yet say if it's fully
compatible with the Wyse Terminal and/or windows 2000 as I'm having a few
days off and won't be back at work where I can test it until wednesday.
The files that were put on it by the Wyse are perfectly viewable however
and I'm able to write as well.

fdisk -l /dev/sda will still not see any partitions however, dispite that
it looks to me like there's one on it, judging by the hexdump of the
device:

> 00000000  eb fe 90 00 00 00 00 00  00 00 00 00 02 08 01 00
|................|
> 00000010  01 00 01 00 00 f0 fa 00  00 00 00 00 00 00 00 00
|................|
> 00000020  00 d0 07 00 00 00 29 1e  00 df 07 50 41 52 54 30
|......)....PART0|
> 00000030  30 20 20 20 20 20 46 41  54 31 36 20 20 20 00 00  |0     FAT16
..|
> 00000040  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
|................|

Windows appears to recognize it as a partition as well, but it remains to
be seen how trustworthy disk management is of course. Especially since it
doesn't allow me to create nor remove partitions on this device and any
other usb sticks I've tried.

Is this going to be included in the kernel, or will there be a more
elegant solution? In any case, I'm willing to help test it of course.

Thanks for the help.

Kind regards,

Ferry van Steen

