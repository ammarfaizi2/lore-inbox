Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264527AbUFGMmi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264527AbUFGMmi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 08:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264722AbUFGM2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 08:28:47 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:4993 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S264542AbUFGLzy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 07:55:54 -0400
To: torvalds@osdl.org, akpm@osdl.org, vojtech@ucw.cz,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
Message-Id: <10866093533797@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <10866093532546@twilight.ucw.cz>
Mime-Version: 1.0
Date: Mon, 7 Jun 2004 13:55:53 +0200
Subject: [PATCH 16/39] input: Allow disabling legacy psaux device
X-Mailer: gregkh_patchbomb_levon_offspring
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input-for-linus

===================================================================

ChangeSet@1.1371.753.23, 2004-04-23 02:46:06-05:00, dtor_core@ameritech.net
  Input: allow disabling legacy psaux device even for non-embedded systems


 Kconfig |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletion(-)

===================================================================

diff -Nru a/drivers/input/Kconfig b/drivers/input/Kconfig
--- a/drivers/input/Kconfig	2004-06-07 13:12:25 +02:00
+++ b/drivers/input/Kconfig	2004-06-07 13:12:25 +02:00
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

