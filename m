Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261434AbSIZSbq>; Thu, 26 Sep 2002 14:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261435AbSIZSbq>; Thu, 26 Sep 2002 14:31:46 -0400
Received: from avocet.mail.pas.earthlink.net ([207.217.120.50]:14039 "EHLO
	avocet.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S261434AbSIZSbo>; Thu, 26 Sep 2002 14:31:44 -0400
Message-ID: <3D93C4CC.7070505@goingware.com>
Date: Thu, 26 Sep 2002 22:39:08 -0400
From: "Michael D. Crawford" <crawford@goingware.com>
Organization: GoingWare Inc. - Expert Software Development and Consulting
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:1.0.0) Gecko/20020622 Debian/1.0.0-0.woody.1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: cramfs: wrong magic when loading ramdisk from floppy
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to load a cramfs filesystem as a ramdisk from a floppy.  After I am 
prompted to insert the floppy with the ramdisk image, and the kernel 
acknowledges that it found a compressed image, I get the message:

cramfs: wrong magic

and then the kernel panics.

What I am trying to do is to use a regular PC to estimate the amount of RAM and 
flash ROM an embedded project will require, so I'm loading a cramfs image from 
floppy that will be similar to the cramfs image that will be loaded into flash. 
  I'm also booting a kernel with only enough options selected to boot and use 
the console, ramdisk, cramfs and floppy disk.  It's otherwise a stock 2.4.19 kernel.

I added a line to fs/cramfs/inode.c to print out the magic that it's seeing, and 
it is 0xf6f6f6f6, which is not correct.

I'm using syslinux on a FAT floppy for my bootloader.  The contents of 
syslinux.cfg are:

DEFAULT linux root=/dev/fd0 init=/bin/sh load_ramdisk=1 prompt_ramdisk=1

Thanks for any help you can give me.

Mike

-- 
Michael D. Crawford
GoingWare Inc. - Expert Software Development and Consulting
http://www.goingware.com/
crawford@goingware.com

      Tilting at Windmills for a Better Tomorrow.

