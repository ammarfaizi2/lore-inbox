Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751351AbWGJLOV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbWGJLOV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 07:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751358AbWGJLOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 07:14:21 -0400
Received: from fitch1.uni2.net ([130.227.52.101]:39118 "EHLO fitch1.uni2.net")
	by vger.kernel.org with ESMTP id S1751351AbWGJLOU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 07:14:20 -0400
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 1/9] -Wshadow: Add -Wshadow to toplevel Makefile
Date: Mon, 10 Jul 2006 13:12:27 +0200
User-Agent: KMail/1.8.2
Cc: jesper.juhl@gmail.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607101312.27738.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(please see the mail titled 
 "[RFC][PATCH 0/9] -Wshadow: Making the kernel build clean with -Wshadow"
 for an explanation of why I'm doing this)


Add -Wshadow to the top-level Makefile.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 Makefile |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.18-rc1/Makefile.orig	2006-07-10 10:31:59.000000000 +0200
+++ linux-2.6.18-rc1/Makefile	2006-07-10 10:32:33.000000000 +0200
@@ -188,7 +188,7 @@
 
 HOSTCC       = gcc
 HOSTCXX      = g++
-HOSTCFLAGS   = -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer
+HOSTCFLAGS   = -Wall -Wshadow -Wstrict-prototypes -O2 -fomit-frame-pointer
 HOSTCXXFLAGS = -O2
 
 # Decide whether to build built-in, modular, or both.
@@ -307,7 +307,7 @@
 
 CPPFLAGS        := -D__KERNEL__ $(LINUXINCLUDE)
 
-CFLAGS          := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
+CFLAGS          := -Wall -Wshadow -Wundef -Wstrict-prototypes -Wno-trigraphs \
                    -fno-strict-aliasing -fno-common
 # Force gcc to behave correct even for buggy distributions
 CFLAGS          += $(call cc-option, -fno-stack-protector-all \


