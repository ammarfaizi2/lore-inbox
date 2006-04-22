Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751187AbWDVUyQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbWDVUyQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 16:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbWDVUyQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 16:54:16 -0400
Received: from c-24-125-75-112.hsd1.va.comcast.net ([24.125.75.112]:29391 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1751187AbWDVUyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 16:54:16 -0400
From: James Nelson <james4765@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: kbuild-devel@lists.sourceforge.net, marcelo.tosatti@cyclades.com,
       James Nelson <james4765@gmail.com>
Message-Id: <20060422205305.8186.12589.66920@david.homenet>
Subject: [PATCH] kbuild: Fix "make xconfig" failure in 2.4.33-pre2
Date: Sat, 22 Apr 2006 16:54:16 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urpN linux-2.4.33-pre2-original/drivers/input/Config.in linux-2.4.33-pre2/drivers/input/Config.in
--- linux-2.4.33-pre2-original/drivers/input/Config.in	2006-04-22 15:52:47.000000000 -0400
+++ linux-2.4.33-pre2/drivers/input/Config.in	2006-04-22 15:53:32.000000000 -0400
@@ -8,7 +8,7 @@ comment 'Input core support'
 tristate 'Input core support' CONFIG_INPUT
 dep_tristate '  Keyboard support' CONFIG_INPUT_KEYBDEV $CONFIG_INPUT
 
-if [ "$CONFIG_INPUT_KEYBDEV" == "n" ]; then
+if [ "$CONFIG_INPUT_KEYBDEV" = "n" ]; then
 	bool '  Use dummy keyboard driver' CONFIG_DUMMY_KEYB $CONFIG_INPUT
 fi
 
