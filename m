Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277272AbRJEB1U>; Thu, 4 Oct 2001 21:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277285AbRJEB1M>; Thu, 4 Oct 2001 21:27:12 -0400
Received: from dot.cygnus.com ([205.180.230.224]:3076 "EHLO dot.cygnus.com")
	by vger.kernel.org with ESMTP id <S277272AbRJEB1D>;
	Thu, 4 Oct 2001 21:27:03 -0400
Date: Thu, 4 Oct 2001 18:27:20 -0700
From: Richard Henderson <rth@dot.cygnus.com>
To: torvalds@transmeta.com, alan@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: alpha 2.4.11-pre3: turn off pci setup debugging
Message-ID: <20011004182720.A6310@dot.cygnus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This bit of verbosity IMO shouldn't have remained enabled
in the mainline kernel.


r~


diff -rup 2.4.11-3-dist/drivers/pci/setup-bus.c 2.4.11-3/drivers/pci/setup-bus.c
--- 2.4.11-3-dist/drivers/pci/setup-bus.c	Sat May 19 17:43:06 2001
+++ 2.4.11-3/drivers/pci/setup-bus.c	Thu Oct  4 17:44:20 2001
@@ -23,7 +23,7 @@
 #include <linux/slab.h>
 
 
-#define DEBUG_CONFIG 1
+#define DEBUG_CONFIG 0
 #if DEBUG_CONFIG
 # define DBGC(args)     printk args
 #else
diff -rup 2.4.11-3-dist/drivers/pci/setup-res.c 2.4.11-3/drivers/pci/setup-res.c
--- 2.4.11-3-dist/drivers/pci/setup-res.c	Sat May 19 17:43:06 2001
+++ 2.4.11-3/drivers/pci/setup-res.c	Thu Oct  4 17:44:28 2001
@@ -25,7 +25,7 @@
 #include <linux/slab.h>
 
 
-#define DEBUG_CONFIG 1
+#define DEBUG_CONFIG 0
 #if DEBUG_CONFIG
 # define DBGC(args)     printk args
 #else
