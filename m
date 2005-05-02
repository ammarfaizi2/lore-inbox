Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261782AbVEBC12@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261782AbVEBC12 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 22:27:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261783AbVEBC11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 22:27:27 -0400
Received: from gate.crashing.org ([63.228.1.57]:59294 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261876AbVEBC0r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 22:26:47 -0400
Subject: [PATCH] ppc32: Fix sleep on old 101 PowerBook
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 02 May 2005 12:24:44 +1000
Message-Id: <1115000685.7111.366.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

A typo in the machine table incorrectly mark the 101 PowerBook as
needing explicit callback from the video driver to enable sleep mode. I
did not implement that mecanism for chipsest older than r128, so we need
to mark this machine as always beeing able to sleep for now.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/arch/ppc/platforms/pmac_feature.c
===================================================================
--- linux-work.orig/arch/ppc/platforms/pmac_feature.c	2005-05-02 10:48:08.000000000 +1000
+++ linux-work/arch/ppc/platforms/pmac_feature.c	2005-05-02 12:15:22.000000000 +1000
@@ -2249,7 +2249,7 @@
 	},
 	{	"PowerBook1,1",			"PowerBook 101 (Lombard)",
 		PMAC_TYPE_101_PBOOK,		paddington_features,
-		PMAC_MB_MAY_SLEEP | PMAC_MB_MOBILE
+		PMAC_MB_CAN_SLEEP | PMAC_MB_MOBILE
 	},
 	{	"PowerBook2,1",			"iBook (first generation)",
 		PMAC_TYPE_ORIG_IBOOK,		core99_features,



