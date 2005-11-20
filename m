Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750724AbVKTGrf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbVKTGrf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 01:47:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbVKTGrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 01:47:13 -0500
Received: from smtp107.sbc.mail.re2.yahoo.com ([68.142.229.98]:14772 "HELO
	smtp107.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750724AbVKTGrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 01:47:10 -0500
Message-Id: <20051120064419.680523000.dtor_core@ameritech.net>
References: <20051120063611.269343000.dtor_core@ameritech.net>
Date: Sun, 20 Nov 2005 01:36:14 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [git pull 03/14] Wistron - disable for x86_64
Content-Disposition: inline; filename=wistron-button-x86_64-fix.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>

Input: wistron - disable for x86_64

On x86_64:

{standard input}:233: Error: suffix or operands invalid for `push'
{standard input}:233: Error: suffix or operands invalid for `pop'

Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/misc/Kconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: work/drivers/input/misc/Kconfig
===================================================================
--- work.orig/drivers/input/misc/Kconfig
+++ work/drivers/input/misc/Kconfig
@@ -42,7 +42,7 @@ config INPUT_M68K_BEEP
 
 config INPUT_WISTRON_BTNS
 	tristate "x86 Wistron laptop button interface"
-	depends on X86
+	depends on X86 && !X86_64
 	help
 	  Say Y here for support of Winstron laptop button interface, used on
 	  laptops of various brands, including Acer and Fujitsu-Siemens.

