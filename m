Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265026AbUDUGPW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265026AbUDUGPW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 02:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265021AbUDUGNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 02:13:38 -0400
Received: from smtp804.mail.sc5.yahoo.com ([66.163.168.183]:43948 "HELO
	smtp804.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264973AbUDUGFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 02:05:52 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 15/15] New set of input patches: allow disabling psaux
Date: Wed, 21 Apr 2004 01:05:25 -0500
User-Agent: KMail/1.6.1
Cc: Vojtech Pavlik <vojtech@suse.cz>
References: <200404210049.17139.dtor_core@ameritech.net>
In-Reply-To: <200404210049.17139.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200404210105.27719.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1916, 2004-04-21 00:02:58-05:00, dtor_core@ameritech.net
  Input: allow disabling legacy psaux device even for non-embedded systems


 Kconfig |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletion(-)


===================================================================



diff -Nru a/drivers/input/Kconfig b/drivers/input/Kconfig
--- a/drivers/input/Kconfig	Wed Apr 21 00:06:52 2004
+++ b/drivers/input/Kconfig	Wed Apr 21 00:06:52 2004
@@ -41,9 +41,16 @@
 	  module will be called mousedev.
 
 config INPUT_MOUSEDEV_PSAUX
-	bool "Provide legacy /dev/psaux device" if EMBEDDED
+	bool "Provide legacy /dev/psaux device"
 	default y
 	depends on INPUT_MOUSEDEV
+	---help---
+	  Say Y here if you want your mouse also be accessible as char device
+	  10:1 - /dev/psaux. The data available through /dev/psaux is exactly
+	  the same as the data from /dev/input/mice.
+
+	  If unsure, say Y.
+
 
 config INPUT_MOUSEDEV_SCREEN_X
 	int "Horizontal screen resolution"
