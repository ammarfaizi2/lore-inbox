Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273012AbRIISie>; Sun, 9 Sep 2001 14:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273013AbRIISiP>; Sun, 9 Sep 2001 14:38:15 -0400
Received: from smtp1.xs4all.nl ([194.109.127.131]:24333 "EHLO smtp1.xs4all.nl")
	by vger.kernel.org with ESMTP id <S273012AbRIISiJ>;
	Sun, 9 Sep 2001 14:38:09 -0400
Date: Sun, 9 Sep 2001 20:38:09 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: <roman@serv>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Patch: typo in fs/super.c
Message-ID: <Pine.LNX.4.33.0109092033070.3840-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

There is a small typo in fs/super.c which makes the mount hash quite
ineffective.

bye, Roman

diff -u -r1.1.1.15 super.c
--- fs/super.c	11 Aug 2001 14:14:59 -0000	1.1.1.15
+++ fs/super.c	9 Sep 2001 18:36:48 -0000
@@ -288,8 +288,8 @@
 {
 	unsigned long tmp = ((unsigned long) mnt / L1_CACHE_BYTES);
 	tmp += ((unsigned long) dentry / L1_CACHE_BYTES);
-	tmp = tmp + (tmp >> hash_mask);
-	return tmp & hash_bits;
+	tmp = tmp + (tmp >> hash_bits);
+	return tmp & hash_mask;
 }

 struct vfsmount *alloc_vfsmnt(void)

