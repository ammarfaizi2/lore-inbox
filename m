Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271656AbRICPVl>; Mon, 3 Sep 2001 11:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271681AbRICPVb>; Mon, 3 Sep 2001 11:21:31 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:46209 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S271656AbRICPVV>; Mon, 3 Sep 2001 11:21:21 -0400
Date: Mon, 3 Sep 2001 11:21:39 -0400 (EDT)
From: Ben LaHaise <bcrl@redhat.com>
X-X-Sender: <bcrl@toomuch.toronto.redhat.com>
To: <torvalds@transmeta.com>
cc: <linux-kernel@vger.kernel.org>
Subject: [resend PATCH] reserve BLKGETSIZE64 ioctl
Message-ID: <Pine.LNX.4.33.0109031119400.1610-100000@toomuch.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Is there any problem with the patch below for reserving a 64 bit get block
device size ioctl?

		-ben

diff -urN v2.4.10-pre4/include/linux/fs.h work/include/linux/fs.h
--- v2.4.10-pre4/include/linux/fs.h	Mon Sep  3 11:04:39 2001
+++ work/include/linux/fs.h	Mon Sep  3 11:18:44 2001
@@ -182,7 +182,8 @@
 /* This was here just to show that the number is taken -
    probably all these _IO(0x12,*) ioctls should be moved to blkpg.h. */
 #endif
-/* A jump here: 108-111 have been used for various private purposes. */
+/* A jump here: 108,109,111 have been used for various private purposes. */
+#define BLKBSZGET  _IOR(0x12,110,sizeof(u64))
 #define BLKBSZGET  _IOR(0x12,112,sizeof(int))
 #define BLKBSZSET  _IOW(0x12,113,sizeof(int))


