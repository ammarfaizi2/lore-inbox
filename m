Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262240AbTKNJkl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 04:40:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262251AbTKNJkl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 04:40:41 -0500
Received: from main.gmane.org ([80.91.224.249]:44747 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262240AbTKNJkj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 04:40:39 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Patrick Beard" <patrick@scotcomms.co.uk>
Subject: 2.6.0-test9 VFAT problem
Date: Fri, 14 Nov 2003 09:39:23 -0000
Message-ID: <bp27qb$tj2$1@sea.gmane.org>
X-Complaints-To: usenet@sea.gmane.org
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

First, I'm still very much a newbie to Linux - but I try my best.

I'm having trouble with my smartmedia. Whenever (occasionally it will
mount - but very rare) I try to mount it I get the following;

mount: wrong fs type, bad option, bad superblock on /dev/sda,
or too many mounted file systems

dmesg shows;

FAT: Bogus number of reserved sectors
VFS: Can't find a valid FAT filesystem on dev sda

These are Olympus sm cards, my camera is a Olympus 300-zoom. I use both the
camera (usb connection) and a belkin usb smartmedia reader.
These cards camera and reader all worked well using Kernel 2.4.18.

My distrib is Debian (testing) and the 2.6 source is the 'Debianized' source
within testing. I noticed that Andries Brouwer has created a patch to relax
the FAT checking within /fs/fat/inode.c. I have applied that diff and
recompiled but if anything it now appears worse. That is to say I still get
the original error when trying to mount the camera, but this time the belkin
reader returns 'no media found'. I will try to confirm this by recompiling
with the original inode.c.

My fstab entry is;
/dev/sda    /mnt/smedia    vfat    rw,user,noauto    0,0

As I said at the start the media does mount occasionally so I would presume
I haven't missed something.

Can anyone help?

--
Patrick



