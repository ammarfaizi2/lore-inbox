Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261321AbTC3X7q>; Sun, 30 Mar 2003 18:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261327AbTC3X7q>; Sun, 30 Mar 2003 18:59:46 -0500
Received: from dp.samba.org ([66.70.73.150]:25477 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261321AbTC3X7p>;
	Sun, 30 Mar 2003 18:59:45 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16007.34354.70218.480707@nanango.paulus.ozlabs.org>
Date: Mon, 31 Mar 2003 10:05:06 +1000 (EST)
To: jt@hpl.hp.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] small fix for wireless.c
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

net/core/wireless.c needs <linux/init.h> since it uses __init.
Without this it won't compile on PPC.

Paul.

diff -urN linux-2.5/net/core/wireless.c linuxppc-2.5/net/core/wireless.c
--- linux-2.5/net/core/wireless.c	2002-11-25 10:10:59.000000000 +1100
+++ linuxppc-2.5/net/core/wireless.c	2002-12-26 20:34:34.000000000 +1100
@@ -54,6 +54,7 @@
 #include <linux/rtnetlink.h>		/* rtnetlink stuff */
 #include <linux/seq_file.h>
 #include <linux/wireless.h>		/* Pretty obvious */
+#include <linux/init.h>			/* for __init */
 
 #include <net/iw_handler.h>		/* New driver API */
 
