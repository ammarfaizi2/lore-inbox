Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267162AbSLEAn5>; Wed, 4 Dec 2002 19:43:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267163AbSLEAn5>; Wed, 4 Dec 2002 19:43:57 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54532 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267162AbSLEAn4>;
	Wed, 4 Dec 2002 19:43:56 -0500
Message-ID: <3DEEA2EF.3040004@pobox.com>
Date: Wed, 04 Dec 2002 19:50:55 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Alexander Viro <viro@math.psu.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix ppdev compile breakage
Content-Type: multipart/mixed;
 boundary="------------050601040200000308060007"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050601040200000308060007
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Cleaning up after viro ;-)

--------------050601040200000308060007
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

--- 1.17/drivers/char/ppdev.c	Tue Dec  3 12:53:57 2002
+++ edited/drivers/char/ppdev.c	Wed Dec  4 19:49:05 2002
@@ -751,6 +751,8 @@
 
 static int __init ppdev_init (void)
 {
+	int i;
+
 	if (register_chrdev (PP_MAJOR, CHRDEV, &pp_fops)) {
 		printk (KERN_WARNING CHRDEV ": unable to get major %d\n",
 			PP_MAJOR);

--------------050601040200000308060007--

