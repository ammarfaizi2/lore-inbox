Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264040AbSIVKuo>; Sun, 22 Sep 2002 06:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264042AbSIVKun>; Sun, 22 Sep 2002 06:50:43 -0400
Received: from einstein.kowalk.Informatik.Uni-Oldenburg.de ([134.106.55.1]:13700
	"EHLO walker.pmhahn.de") by vger.kernel.org with ESMTP
	id <S264040AbSIVKun>; Sun, 22 Sep 2002 06:50:43 -0400
Date: Sun, 22 Sep 2002 12:53:23 +0200
From: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [BUG,PATCH] 2.5.38 floppy
Message-ID: <20020922105322.GA30085@titan.lahn.de>
Mail-Followup-To: Philipp Matthias Hahn <pmhahn@titan.lahn.de>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.33.0209212130360.2433-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0209212130360.2433-100000@penguin.transmeta.com>
User-Agent: Mutt/1.4i
Organization: UUCP-Freunde Lahn e.V.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Moin LKML!

On Sat, Sep 21, 2002 at 09:34:18PM -0700, Linus Torvalds wrote:
> Alexander Viro <viro@math.psu.edu>:
>   o gendisk for pcd, cdu31a, cm206, mcd, mcdx, sbpcd, jsflash, mtdblock_ro,
>     pf, swim3, loop, aztcd, gscd, optcd, sjcd, sonycd, stram, rd, nbd, xpram,
>     acorn floppy, swim_iop

make[2]: Entering directory `/usr/src/linux-2.5.38/drivers/block'
gcc  ...  -DKBUILD_BASENAME=floppy   -c -o floppy.o floppy.c
floppy.c: In function `cleanup_module':
floppy.c:4565: `drive' undeclared (first use in this function)
floppy.c:4573: warning: statement with no effect


--- drivers/block/floppy.c~	2002-09-22 11:16:52.000000000 +0200
+++ drivers/block/floppy.c	2002-09-22 12:51:22.000000000 +0200
@@ -4556,7 +4556,7 @@
 
 void cleanup_module(void)
 {
-	int i;
+	int drive;
 		
 	unregister_sys_device(&device_floppy);
 	devfs_unregister (devfs_handle);

BYtE
Philipp
-- 
  / /  (_)__  __ ____  __ Philipp Hahn
 / /__/ / _ \/ // /\ \/ /
/____/_/_//_/\_,_/ /_/\_\ pmhahn@titan.lahn.de
