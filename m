Return-Path: <linux-kernel-owner+w=401wt.eu-S937575AbWLKTLX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937575AbWLKTLX (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 14:11:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937577AbWLKTLX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 14:11:23 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:4083 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S937575AbWLKTLW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 14:11:22 -0500
Date: Mon, 11 Dec 2006 20:11:32 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] make kernel/printk.c:ignore_loglevel_setup() static
Message-ID: <20061211191132.GG28443@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the needlessly global ignore_loglevel_setup() static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.19-mm1/kernel/printk.c.old	2006-12-11 18:38:13.000000000 +0100
+++ linux-2.6.19-mm1/kernel/printk.c	2006-12-11 18:38:47.000000000 +0100
@@ -335,7 +335,7 @@
 
 static int __read_mostly ignore_loglevel;
 
-int __init ignore_loglevel_setup(char *str)
+static int __init ignore_loglevel_setup(char *str)
 {
 	ignore_loglevel = 1;
 	printk(KERN_INFO "debug: ignoring loglevel setting.\n");

