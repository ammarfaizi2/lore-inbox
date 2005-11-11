Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932239AbVKKIgk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239AbVKKIgk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 03:36:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbVKKIgL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 03:36:11 -0500
Received: from i121.durables.org ([64.81.244.121]:7630 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S932238AbVKKIgF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 03:36:05 -0500
Date: Fri, 11 Nov 2005 02:35:51 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
X-PatchBomber: http://selenic.com/scripts/mailpatches
In-Reply-To: <6.282480653@selenic.com>
Message-Id: <7.282480653@selenic.com>
Subject: [PATCH 6/15] misc: Trim non-IPX builds
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

trivial: drop unused 802.3 code if we compile without IPX

(originally from http://wohnheim.fh-wedel.de/~joern/software/kernel/je/25/)

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: tiny/net/802/Makefile
===================================================================
--- tiny.orig/net/802/Makefile	2005-03-15 00:24:59.000000000 -0600
+++ tiny/net/802/Makefile	2005-03-15 00:25:48.000000000 -0600
@@ -2,8 +2,6 @@
 # Makefile for the Linux 802.x protocol layers.
 #
 
-obj-y			:= p8023.o
-
 # Check the p8022 selections against net/core/Makefile.
 obj-$(CONFIG_SYSCTL)	+= sysctl_net_802.o
 obj-$(CONFIG_LLC)	+= p8022.o psnap.o
@@ -11,5 +9,5 @@ obj-$(CONFIG_TR)	+= p8022.o psnap.o tr.o
 obj-$(CONFIG_NET_FC)	+=                 fc.o
 obj-$(CONFIG_FDDI)	+=                 fddi.o
 obj-$(CONFIG_HIPPI)	+=                 hippi.o
-obj-$(CONFIG_IPX)	+= p8022.o psnap.o
+obj-$(CONFIG_IPX)	+= p8022.o psnap.o p8023.o
 obj-$(CONFIG_ATALK)	+= p8022.o psnap.o
