Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312254AbSFJMV4>; Mon, 10 Jun 2002 08:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312560AbSFJMVz>; Mon, 10 Jun 2002 08:21:55 -0400
Received: from [195.63.194.11] ([195.63.194.11]:34310 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S312254AbSFJMVx>; Mon, 10 Jun 2002 08:21:53 -0400
Message-ID: <3D048C20.7030206@evision-ventures.com>
Date: Mon, 10 Jun 2002 13:23:12 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.21 kill warnings 2/19
In-Reply-To: <Pine.LNX.4.33.0206082235240.4635-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------080606000009010801020400"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080606000009010801020400
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This is fixing warnings about unused variables in
pd.c and pcd.c

--------------080606000009010801020400
Content-Type: text/plain;
 name="warn-2.5.21-2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="warn-2.5.21-2.diff"

diff -urN linux-2.5.21/drivers/block/paride/pcd.c linux/drivers/block/paride/pcd.c
--- linux-2.5.21/drivers/block/paride/pcd.c	2002-06-09 07:29:30.000000000 +0200
+++ linux/drivers/block/paride/pcd.c	2002-06-09 19:14:13.000000000 +0200
@@ -329,8 +329,8 @@
 }
 
 int pcd_init (void)	/* preliminary initialisation */
-
-{       int 	i, unit;
+{
+	int unit;
 
 	if (disable) return -1;
 
diff -urN linux-2.5.21/drivers/block/paride/pd.c linux/drivers/block/paride/pd.c
--- linux-2.5.21/drivers/block/paride/pd.c	2002-06-09 07:31:18.000000000 +0200
+++ linux/drivers/block/paride/pd.c	2002-06-09 19:13:49.000000000 +0200
@@ -381,9 +381,8 @@
 }
 
 int pd_init (void)
-
-{       int i;
-	request_queue_t * q; 
+{
+	request_queue_t * q;
 
 	if (disable) return -1;
         if (devfs_register_blkdev(MAJOR_NR,name,&pd_fops)) {

--------------080606000009010801020400--

