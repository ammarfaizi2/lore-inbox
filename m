Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261589AbVAXT2K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261589AbVAXT2K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 14:28:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261588AbVAXT2I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 14:28:08 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:36369 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261592AbVAXT0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 14:26:08 -0500
Date: Mon, 24 Jan 2005 20:26:05 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] update scripts/namespace.pl
Message-ID: <20050124192605.GR3515@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below removes some false positives I've observed.

Is this correct, or is there another correct solution?


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.11-rc2-mm1-full/scripts/namespace.pl.old	2005-01-24 19:45:52.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/scripts/namespace.pl	2005-01-24 20:20:58.000000000 +0100
@@ -406,6 +406,11 @@
 					&& $name !~ /^__.*per_cpu_end/
 					&& $name !~ /^__alt_instructions/
 					&& $name !~ /^__setup_/
+					&& $name !~ /^jiffies/
+					&& $name !~ /^__mod_timer/
+					&& $name !~ /^__mod_page_state/
+					&& $name !~ /^init_module/
+					&& $name !~ /^cleanup_module/
 				) {
 					printf "Cannot resolve ";
 					printf "weak " if ($type eq "w");

