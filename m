Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312619AbSFJMX1>; Mon, 10 Jun 2002 08:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312938AbSFJMX0>; Mon, 10 Jun 2002 08:23:26 -0400
Received: from [195.63.194.11] ([195.63.194.11]:37126 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S312619AbSFJMXV>; Mon, 10 Jun 2002 08:23:21 -0400
Message-ID: <3D048C78.5080606@evision-ventures.com>
Date: Mon, 10 Jun 2002 13:24:40 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.21 kill warnings 3/19
In-Reply-To: <Pine.LNX.4.33.0206082235240.4635-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------060103020300040104070902"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060103020300040104070902
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Kill unused variables in legacy cdrom drivers,
after the janitorial patch got in.

--------------060103020300040104070902
Content-Type: text/plain;
 name="warn-2.5.21-3.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="warn-2.5.21-3.diff"

diff -urN linux-2.5.21/drivers/cdrom/optcd.c linux/drivers/cdrom/optcd.c
--- linux-2.5.21/drivers/cdrom/optcd.c	2002-06-09 07:28:11.000000000 +0200
+++ linux/drivers/cdrom/optcd.c	2002-06-09 19:15:18.000000000 +0200
@@ -1507,7 +1507,6 @@
 
 static int cdromreadtochdr(unsigned long arg)
 {
-	int status;
 	struct cdrom_tochdr tochdr;
 
 	tochdr.cdth_trk0 = disk_info.first;
@@ -1519,7 +1518,6 @@
 
 static int cdromreadtocentry(unsigned long arg)
 {
-	int status;
 	struct cdrom_tocentry entry;
 	struct cdrom_subchnl *tocptr;
 
@@ -1646,7 +1644,6 @@
 #ifdef MULTISESSION
 static int cdrommultisession(unsigned long arg)
 {
-	int status;
 	struct cdrom_multisession ms;
 
 	if (copy_from_user(&ms, (void*) arg, sizeof ms))
diff -urN linux-2.5.21/drivers/cdrom/sonycd535.c linux/drivers/cdrom/sonycd535.c
--- linux-2.5.21/drivers/cdrom/sonycd535.c	2002-06-09 07:28:49.000000000 +0200
+++ linux/drivers/cdrom/sonycd535.c	2002-06-09 19:00:00.000000000 +0200
@@ -1012,7 +1012,6 @@
 sony_get_subchnl_info(long arg)
 {
 	struct cdrom_subchnl schi;
-	int err;
 
 	/* Get attention stuff */
 	if (check_drive_status() != 0)

--------------060103020300040104070902--

