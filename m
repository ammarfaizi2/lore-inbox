Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261304AbVA0XeT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261304AbVA0XeT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 18:34:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261288AbVA0XeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 18:34:19 -0500
Received: from out005pub.verizon.net ([206.46.170.143]:8437 "EHLO
	out005.verizon.net") by vger.kernel.org with ESMTP id S261304AbVA0XbJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 18:31:09 -0500
From: James Nelson <james4765@cwazy.co.uk>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, cristoph@lameter.com, James Nelson <james4765@cwazy.co.uk>
Message-Id: <20050127233107.23569.97358.38472@localhost.localdomain>
In-Reply-To: <20050127233053.23569.16444.60993@localhost.localdomain>
References: <20050127233053.23569.16444.60993@localhost.localdomain>
Subject: [PATCH 2/8] pcxx: Remove reference in drivers/char/Kconfig
X-Authentication-Info: Submitted using SMTP AUTH at out005.verizon.net from [70.16.225.90] at Thu, 27 Jan 2005 17:31:07 -0600
Date: Thu, 27 Jan 2005 17:31:08 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes references to the pcxx driver in drivers/char/Kconfig

It depends on the previous patch.

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.11-rc2-mm1-original/drivers/char/Kconfig linux-2.6.11-rc2-mm1/drivers/char/Kconfig
--- linux-2.6.11-rc2-mm1-original/drivers/char/Kconfig	2005-01-24 17:15:55.000000000 -0500
+++ linux-2.6.11-rc2-mm1/drivers/char/Kconfig	2005-01-27 16:27:32.000000000 -0500
@@ -161,26 +161,9 @@
 	  you have a card like this, say Y here and read the file
 	  <file:Documentation/digiepca.txt>.
 
-	  NOTE: There is another, separate driver for the Digiboard PC boards:
-	  "Digiboard PC/Xx Support" below. You should (and can) only select
-	  one of the two drivers.
-
 	  To compile this driver as a module, choose M here: the
 	  module will be called epca.
 
-config DIGI
-	tristate "Digiboard PC/Xx Support"
-	depends on SERIAL_NONSTANDARD && DIGIEPCA=n && BROKEN_ON_SMP
-	help
-	  This is a driver for the Digiboard PC/Xe, PC/Xi, and PC/Xeve cards
-	  that give you many serial ports. You would need something like this
-	  to connect more than two modems to your Linux box, for instance in
-	  order to become a dial-in server. If you have a card like that, say
-	  Y here and read the file <file:Documentation/digiboard.txt>.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called pcxx.
-
 config ESPSERIAL
 	tristate "Hayes ESP serial port support"
 	depends on SERIAL_NONSTANDARD && ISA && BROKEN_ON_SMP
