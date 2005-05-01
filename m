Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261679AbVEAQCE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261679AbVEAQCE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 12:02:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261675AbVEAPsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 11:48:50 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:49672 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261676AbVEAPnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 11:43:05 -0400
Date: Sun, 1 May 2005 17:43:02 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: vojtech@suse.cz, linux-input@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/keyboard.c: make a function static
Message-ID: <20050501154302.GQ3592@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a needlessly globbal function static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 17 Apr 2005

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



