Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265849AbUATWxN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 17:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265844AbUATWux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 17:50:53 -0500
Received: from gprs214-112.eurotel.cz ([160.218.214.112]:56195 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S265841AbUATWuI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 17:50:08 -0500
Date: Tue, 20 Jan 2004 23:50:02 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>
Subject: Trivial cleanups for swsusp
Message-ID: <20040120225002.GA19175@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This kills unused part of struct and fixes spelling. Please apply,

								Pavel

Index: linux/include/linux/suspend.h
===================================================================
--- linux.orig/include/linux/suspend.h	2004-01-13 22:52:40.000000000 +0100
+++ linux/include/linux/suspend.h	2004-01-20 22:51:15.000000000 +0100
@@ -32,9 +33,6 @@
 	int page_size;
 	suspend_pagedir_t *suspend_pagedir;
 	unsigned int num_pbes;
-	struct swap_location {
-		char filename[SWAP_FILENAME_MAXLENGTH];
-	} swap_location[MAX_SWAPFILES];
 };
 
 #define SUSPEND_PD_PAGES(x)     (((x)*sizeof(struct pbe))/PAGE_SIZE+1)
Index: linux/kernel/power/swsusp.c
===================================================================
--- linux.orig/kernel/power/swsusp.c	2004-01-13 22:52:40.000000000 +0100
+++ linux/kernel/power/swsusp.c	2004-01-09 20:33:05.000000000 +0100
@@ -283,8 +287,8 @@
  *    would happen on next reboot -- corrupting data.
  *
  *    Note: The buffer we allocate to use to write the suspend header is
- *    not freed; its not needed since system is going down anyway
- *    (plus it causes oops and I'm lazy^H^H^H^Htoo busy).
+ *    not freed; its not needed since the system is going down anyway
+ *    (plus it causes an oops and I'm lazy^H^H^H^Htoo busy).
  */
 static int write_suspend_image(void)
 {

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
