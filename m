Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750930AbWAIDS4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930AbWAIDS4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 22:18:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbWAIDSz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 22:18:55 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:43717 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1750930AbWAIDSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 22:18:55 -0500
Message-Id: <200601090411.k094B04Z001191@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 3/6] UML - Revert compile-time option checking
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 08 Jan 2006 23:11:00 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Undo the previous no-modes patch since Adrian Bunk sent in a kbuild way
of doing the same thing.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15-mm/arch/um/kernel/um_arch.c
===================================================================
--- linux-2.6.15-mm.orig/arch/um/kernel/um_arch.c	2006-01-06 22:25:10.000000000 -0500
+++ linux-2.6.15-mm/arch/um/kernel/um_arch.c	2006-01-06 23:36:39.000000000 -0500
@@ -243,10 +243,6 @@ static int __init mode_tt_setup(char *li
 	return(0);
 }
 
-#else
-
-#error Either CONFIG_MODE_TT or CONFIG_MODE_SKAS must be enabled
-
 #endif
 #endif
 #endif

