Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130356AbRAJJ7R>; Wed, 10 Jan 2001 04:59:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131964AbRAJJ7H>; Wed, 10 Jan 2001 04:59:07 -0500
Received: from oker.escape.de ([194.120.234.254]:23573 "EHLO oker.escape.de")
	by vger.kernel.org with ESMTP id <S130356AbRAJJ6x>;
	Wed, 10 Jan 2001 04:58:53 -0500
Date: Wed, 10 Jan 2001 10:45:53 +0100 (CET)
From: Matthias Kilian <kili@outback.escape.de>
To: <linux-kernel@vger.kernel.org>
Subject: cramfs on initrd
Message-ID: <Pine.LNX.4.30.0101101035040.8826-100000@outback.escape.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On http://www.escape.de/users/outback/linux/patch-2.4.0-mk1 you find a
small patch that allows to use a cramfs image as initrd. Notes:

Use ramdisk_blocksize=4096 as Linus suggested a few days ago.

The patch modifies mkcramfs to write the fs size into the superblock. So
you have to make a new image with mkcramfs; old images won't work. This
fs size now is used in identify_ramdisk_image() in rd.c

Also note that cramfs.h has been renamed and moved to
include/linux/cramfs_fs.h (needs cleanup).

Have fun,
	Kili


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
