Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267748AbUIJSie@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267748AbUIJSie (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 14:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267751AbUIJSie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 14:38:34 -0400
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:48061 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S267748AbUIJSiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 14:38:10 -0400
Subject: [patch 1/1] Refer to CONFIG_USERMODE, not to CONFIG_UM
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Fri, 10 Sep 2004 19:08:58 +0200
Message-Id: <20040910170859.24ABDC74B@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Correct one Kconfig dependency, which should refer to CONFIG_USERMODE rather
than to CONFIG_UM.
We should also figure out how to make the config process work better for UML.
We would like to make UML able to "source drivers/Kconfig" and have the right
drivers selectable (i.e. LVM, ramdisk, and so on) and the ones for actual
hardware excluded. I've been reading such a request even from Jeff Dike at the
last Kernel Summit, (in the lwn.net coverage) but without any followup.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.9-current-paolo/drivers/char/Kconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/char/Kconfig~CONFIG_UM-is-USERMODE drivers/char/Kconfig
--- linux-2.6.9-current/drivers/char/Kconfig~CONFIG_UM-is-USERMODE	2004-09-10 19:08:43.631737936 +0200
+++ linux-2.6.9-current-paolo/drivers/char/Kconfig	2004-09-10 19:08:43.633737632 +0200
@@ -59,7 +59,7 @@ config VT_CONSOLE
 
 config HW_CONSOLE
 	bool
-	depends on VT && !S390 && !UM
+	depends on VT && !S390 && !USERMODE
 	default y
 
 config SERIAL_NONSTANDARD
_
