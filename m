Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317471AbSINTMf>; Sat, 14 Sep 2002 15:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317473AbSINTMe>; Sat, 14 Sep 2002 15:12:34 -0400
Received: from qix.net ([207.40.214.9]:35088 "EHLO neocygnus.qix.net")
	by vger.kernel.org with ESMTP id <S317471AbSINTMe>;
	Sat, 14 Sep 2002 15:12:34 -0400
Date: Sat, 14 Sep 2002 15:27:32 -0400
From: Dave Maietta <dave@qix.net>
To: linux-kernel@vger.kernel.org
Cc: trivial@rustcorp.com.au
Subject: [TRIVIAL][PATCH] 2.4 drivers_char_random.c fix sample shellscripts
Message-ID: <20020914152732.A8713@hell>
Reply-To: dave@qix.net
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.2.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the sample shellscripts given in the comments of 
drivers/char/random.c.
The scripts save and restore random seeds for /dev/random across reboots.

--- linux/drivers/char/random.c.orig	2002-09-14 14:56:03.000000000 -0400
+++ linux/drivers/char/random.c	2002-09-14 14:56:51.000000000 -0400
@@ -175,7 +175,7 @@
   *	chmod 600 $random_seed
   *	poolfile=/proc/sys/kernel/random/poolsize
   *	[ -r $poolfile ] && bytes=`cat $poolfile` || bytes=512
- *	dd if=/dev/urandom of=$random_seed count=1 bs=bytes
+ *	dd if=/dev/urandom of=$random_seed count=1 bs=$bytes
   *
   * and the following lines in an appropriate script which is run as
   * the system is shutdown:
@@ -188,7 +188,7 @@
   *	chmod 600 $random_seed
   *	poolfile=/proc/sys/kernel/random/poolsize
   *	[ -r $poolfile ] && bytes=`cat $poolfile` || bytes=512
- *	dd if=/dev/urandom of=$random_seed count=1 bs=bytes
+ *	dd if=/dev/urandom of=$random_seed count=1 bs=i$bytes
   *
   * For example, on most modern systems using the System V init
   * scripts, such code fragments would be found in

Dave Maietta
37167 North Orchard Cr #4-60
Westland MI 48186
734-326-3059 
