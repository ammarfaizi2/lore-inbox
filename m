Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261709AbTISTsn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 15:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261700AbTISTri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 15:47:38 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:33700 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S261702AbTISTr0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 15:47:26 -0400
Subject: [PATCH 5/5] Fix Kconfig KEYBOARD_ATKBD when SERIO is modular
In-Reply-To: <10640008352154@twilight.ucw.cz>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Fri, 19 Sep 2003 21:47:15 +0200
Message-Id: <10640008352360@twilight.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1354, 2003-09-19 13:51:40+02:00, bunk@fs.tum.de
  input: Fix Kconfig KEYBOARD_ATKBD when SERIO is modular.


 Kconfig |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

===================================================================

diff -Nru a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
--- a/drivers/input/keyboard/Kconfig	Fri Sep 19 14:12:35 2003
+++ b/drivers/input/keyboard/Kconfig	Fri Sep 19 14:12:35 2003
@@ -13,7 +13,8 @@
 
 config KEYBOARD_ATKBD
 	tristate "AT keyboard support" if EMBEDDED || !X86 
-	default y
+	default y if INPUT=y && INPUT_KEYBOARD=y && SERIO=y
+	default m
 	depends on INPUT && INPUT_KEYBOARD && SERIO
 	help
 	  Say Y here if you want to use a standard AT or PS/2 keyboard. Usually

