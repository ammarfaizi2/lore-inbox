Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287764AbSBGMp5>; Thu, 7 Feb 2002 07:45:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287710AbSBGMps>; Thu, 7 Feb 2002 07:45:48 -0500
Received: from oker.escape.de ([194.120.234.254]:16176 "EHLO oker.escape.de")
	by vger.kernel.org with ESMTP id <S287793AbSBGMpb>;
	Thu, 7 Feb 2002 07:45:31 -0500
Date: Thu, 7 Feb 2002 13:20:53 +0100 (CET)
From: Matthias Kilian <kili@outback.escape.de>
To: <linux-kernel@vger.kernel.org>
cc: <kili@outback.escape.de>
Subject: Re: Problems with iso9660 as initrd
In-Reply-To: <a3seft$h50$1@cesium.transmeta.com>
Message-ID: <Pine.LNX.4.30.0202071316501.21862-100000@outback.escape.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 Feb 2002, H. Peter Anvin wrote:

> > I am building a floppy using a compressed iso9660 filesystem as an
> > initrd image.
[...]
> You definitely are... I don't think anyone else has ever tried running
> a zisofs off a ramdisk before!

On for an initrd, it will never work, since initrd checks for minix, ext2
and romfs only (see drivers/block/rd.c, identify_ramdisk_image()).

BTW: what's with the new initrd scheme (using loading a cpio image into a
tmpfs)? I'm still waiting for this to go into the official kernels
(currently I use my own patch doing the same thing for tar images).

Kili

-- 
Windows is so bootyful...



