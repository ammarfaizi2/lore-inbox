Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261460AbVDQUNX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261460AbVDQUNX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 16:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261471AbVDQUI5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 16:08:57 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:11795 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261479AbVDQUIF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 16:08:05 -0400
Date: Sun, 17 Apr 2005 22:08:03 +0200
From: Adrian Bunk <bunk@stusta.de>
To: vojtech@suse.cz
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/keyboard.c: make a function static
Message-ID: <20050417200803.GK3625@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a needlessly globbal function static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-rc2-mm3-full/drivers/char/keyboard.c.old	2005-04-17 18:10:34.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/char/keyboard.c	2005-04-17 18:10:55.000000000 +0200
@@ -1026,7 +1026,8 @@
 		put_queue(vc, data);
 }
 
-void kbd_keycode(unsigned int keycode, int down, int hw_raw, struct pt_regs *regs)
+static void kbd_keycode(unsigned int keycode, int down,
+			int hw_raw, struct pt_regs *regs)
 {
 	struct vc_data *vc = vc_cons[fg_console].d;
 	unsigned short keysym, *key_map;



