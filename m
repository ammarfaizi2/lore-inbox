Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161001AbWCCSBE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161001AbWCCSBE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 13:01:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161002AbWCCSBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 13:01:04 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:9227 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1161001AbWCCSBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 13:01:02 -0500
Date: Fri, 3 Mar 2006 19:01:01 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org, "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
Subject: [2.4 patch] Corrected faulty syntax in drivers/input/Config.in
Message-ID: <20060303180100.GV9295@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>

If statement in drivers/input/Config.in for "make xconfig" corrected.


Signed-off-by: Stefan-W. Hahn <stefan.hahn@s-hahn.de>
Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was sent by Stefan-W. Hahn on:
- 26 Feb 2006

--- a/drivers/input/Config.in
+++ b/drivers/input/Config.in
@@ -8,7 +8,7 @@ comment 'Input core support'
 tristate 'Input core support' CONFIG_INPUT
 dep_tristate '  Keyboard support' CONFIG_INPUT_KEYBDEV $CONFIG_INPUT
 
-if [ "$CONFIG_INPUT_KEYBDEV" == "n" ]; then
+if [ "$CONFIG_INPUT_KEYBDEV" = "n" ]; then
 	bool '  Use dummy keyboard driver' CONFIG_DUMMY_KEYB $CONFIG_INPUT
 fi
 
