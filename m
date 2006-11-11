Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1947248AbWKKOTG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947248AbWKKOTG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 09:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947250AbWKKOTG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 09:19:06 -0500
Received: from sd291.sivit.org ([194.146.225.122]:47117 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S1947248AbWKKOTD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 09:19:03 -0500
Subject: [PATCH] MAC_EMUMOUSEBTN shouldn't depend on INPUT_ADBHID
From: Stelian Pop <stelian@popies.net>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Sat, 11 Nov 2006 15:18:51 +0100
Message-Id: <1163254732.4884.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

As the subject says, the mouse button emulation for the one-button mouse
Apple machines isn't restricted to older ADB based machines.

I have a PPC Powerbook where the keyboard and the mouse are no longer on
the ADB bus but regular USB, and I still like (and need) to be able to
emulate the middle mouse button with F11 and the right mouse button with
F12.

Stelian.

diff -r 10ae4c90e8b5 drivers/macintosh/Kconfig
--- a/drivers/macintosh/Kconfig	Wed Jan 18 12:50:02 2006 +0100
+++ b/drivers/macintosh/Kconfig	Wed Jan 18 13:01:44 2006 +0100
@@ -135,7 +135,6 @@
 
 config MAC_EMUMOUSEBTN
 	bool "Support for mouse button 2+3 emulation"
-	depends on INPUT_ADBHID
 	help
 	  This provides generic support for emulating the 2nd and 3rd mouse
 	  button with keypresses.  If you say Y here, the emulation is still

-- 
Stelian Pop <stelian@popies.net>

