Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130232AbQK1DOO>; Mon, 27 Nov 2000 22:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130367AbQK1DOF>; Mon, 27 Nov 2000 22:14:05 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:41476 "EHLO
        wire.cadcamlab.org") by vger.kernel.org with ESMTP
        id <S130232AbQK1DNs>; Mon, 27 Nov 2000 22:13:48 -0500
Date: Mon, 27 Nov 2000 20:43:31 -0600
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: syslinux and 2.4.0 initrd size problems
Message-ID: <20001127204331.I8881@wire.cadcamlab.org>
In-Reply-To: <20001126211642.A2763@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001126211642.A2763@vger.timpanogas.org>; from jmerkey@vger.timpanogas.org on Sun, Nov 26, 2000 at 09:16:42PM -0700
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Jeff V. Merkey]
> I am having trouble getting a 2.4 vmlinuz (bzImage) and initrd image
> onto a 1.44 floppy with all the new stuff.

Check out what Debian did for 2.2 ("potato").  Kernel and syslinux are
on a FAT floppy, and a second floppy holds a raw ext2 image, gzipped.
SYSLINUX.CFG begins like so:

  DEFAULT linux
  APPEND vga=normal noinitrd load_ramdisk=1 prompt_ramdisk=1 ramdisk_size=16384 root=/dev/fd0 disksize=1.44
  TIMEOUT 0
  DISPLAY debian.txt
  PROMPT 1

Just before mounting the root filesystem, the kernel says "insert
floppy and press <enter>" or some such.

You can download the images at

  http://http.us.debian.org/debian/dists/potato/main/disks-i386/current/images-1.44/

See 'rescue.bin' (syslinux+kernel) and 'root.bin' (initrd.gz).

> I there something more current that does or will allow me to
> load the inittrd off a CD-ROM device (with vmlinuz and syslinux
> on the floppy).   I know how to do this with GRUB (Grand 
> Unified Boot Loader), but I want to use syslinux if possible. 

If you can count on having a BIOS that knows how to boot a CD-ROM (i.e.
the BIOS is new enough to be Y2K compliant) you can put a 2.88MB floppy
image on the CD for the BIOS to find.  Should be big enough for the
next year or two.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
