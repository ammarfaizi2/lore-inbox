Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265200AbUBOWN7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 17:13:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265210AbUBOWN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 17:13:59 -0500
Received: from gate.crashing.org ([63.228.1.57]:51870 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265200AbUBOWN6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 17:13:58 -0500
Subject: [Fwd: New radeonfb: some troubles]
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1076883158.6960.91.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 16 Feb 2004 09:12:38 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix proper detection of the "noaccel" command line argument for
new radeonfb so we can boot without acceleration. Useful when
diagnosing an accel-related problem.

Ben.


--- radeon_base.c.orig	Sun Feb 15 17:01:11 2004
+++ radeon_base.c	Sun Feb 15 17:35:13 2004
@@ -2331,7 +2331,7 @@
 			continue;
 
 		if (!strncmp(this_opt, "noaccel", 7)) {
-			radeonfb_noaccel = 1;
+			noaccel = radeonfb_noaccel = 1;
 		} else if (!strncmp(this_opt, "mirror", 6)) {
 			mirror = 1;
 		} else if (!strncmp(this_opt, "force_dfp", 9)) {



