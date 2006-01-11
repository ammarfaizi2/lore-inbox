Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932516AbWAKDSJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932516AbWAKDSJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 22:18:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932569AbWAKDSJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 22:18:09 -0500
Received: from gate.crashing.org ([63.228.1.57]:23751 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932516AbWAKDSI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 22:18:08 -0500
Subject: [PATCH] Fix wireless build
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 11 Jan 2006 14:17:32 +1100
Message-Id: <1136949452.5333.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Current wireless core doesn't link here with a link error on
compare_ether_addr. The function exists, but is defined inline and the
wireless code forgets to #include the file containing the definition.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/net/core/wireless.c
===================================================================
--- linux-work.orig/net/core/wireless.c	2006-01-11 12:56:30.000000000 +1100
+++ linux-work/net/core/wireless.c	2006-01-11 14:14:27.000000000 +1100
@@ -78,7 +78,7 @@
 #include <linux/seq_file.h>
 #include <linux/init.h>			/* for __init */
 #include <linux/if_arp.h>		/* ARPHRD_ETHER */
-
+#include <linux/etherdevice.h>
 #include <linux/wireless.h>		/* Pretty obvious */
 #include <net/iw_handler.h>		/* New driver API */
 


