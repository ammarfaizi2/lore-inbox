Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316678AbSGVKqG>; Mon, 22 Jul 2002 06:46:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316682AbSGVKqG>; Mon, 22 Jul 2002 06:46:06 -0400
Received: from [195.63.194.11] ([195.63.194.11]:17416 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316678AbSGVKqF>; Mon, 22 Jul 2002 06:46:05 -0400
Message-ID: <3D3BE1DD.3040803@evision.ag>
Date: Mon, 22 Jul 2002 12:43:41 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020625
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.27 devfs
References: <Pine.LNX.4.44.0207201218390.1230-100000@home.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------020908090708020803010901"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020908090708020803010901
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Kill two inlines which are notwhere used and which don't make sense
in the case someone is not compiling devfs at all.

--------------020908090708020803010901
Content-Type: text/plain;
 name="devfs-2.5.27.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="devfs-2.5.27.diff"

diff -urN linux-2.5.27/include/linux/devfs_fs_kernel.h linux/include/linux/devfs_fs_kernel.h
--- linux-2.5.27/include/linux/devfs_fs_kernel.h	2002-07-20 21:11:30.000000000 +0200
+++ linux/include/linux/devfs_fs_kernel.h	2002-07-21 22:14:16.000000000 +0200
@@ -286,16 +286,6 @@
     return;
 }
 
-static inline kdev_t devfs_alloc_devnum (char type)
-{
-    return NODEV;
-}
-
-static inline void devfs_dealloc_devnum (char type, kdev_t devnum)
-{
-    return;
-}
-
 static inline int devfs_alloc_unique_number (struct unique_numspace *space)
 {
     return -1;

--------------020908090708020803010901--

