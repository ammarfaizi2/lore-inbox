Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750937AbWC0MGA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750937AbWC0MGA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 07:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750942AbWC0MGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 07:06:00 -0500
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:34711 "EHLO
	mtaout01-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1750936AbWC0MF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 07:05:59 -0500
From: Daniel Drake <dsd@gentoo.org>
To: akpm@osdl.org
Cc: rusty@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] input.h should always include asm/types.h
Message-Id: <20060327120600.29F508771D5@zog.reactivated.net>
Date: Mon, 27 Mar 2006 13:06:00 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 1d8f430c15b3a345db990e285742c67c2f52f9a6 added modalias support to the
input subsystem. Now that input.h uses BITS_PER_LONG, asm/types.h should be
included even in __KERNEL__ space.

Signed-off-by: Daniel Drake <dsd@gentoo.org>

--- linux/include/linux/input.h.orig	2006-03-27 13:09:50.000000000 +0100
+++ linux/include/linux/input.h	2006-03-27 13:10:03.000000000 +0100
@@ -17,8 +17,8 @@
 #else
 #include <sys/time.h>
 #include <sys/ioctl.h>
-#include <asm/types.h>
 #endif
+#include <asm/types.h>
 
 /*
  * The event structure itself
