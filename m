Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267586AbUG2O45@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267586AbUG2O45 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 10:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267596AbUG2Oxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 10:53:32 -0400
Received: from styx.suse.cz ([82.119.242.94]:25238 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S264913AbUG2OIL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 10:08:11 -0400
To: torvalds@osdl.org, vojtech@suse.cz, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH 24/47] Remove an extra dmi_noloop declaration in i8042.c
Content-Transfer-Encoding: 7BIT
Date: Thu, 29 Jul 2004 16:09:55 +0200
X-Mailer: gregkh_patchbomb_levon_offspring
In-Reply-To: <10911101952752@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Message-Id: <10911101953521@twilight.ucw.cz>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1722.148.10, 2004-06-21 07:48:47+02:00, vojtech@suse.cz
  input: Remove an extra dmi_noloop declaration in i8042.c
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>


 i8042.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

===================================================================

diff -Nru a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
--- a/drivers/input/serio/i8042.c	Thu Jul 29 14:40:26 2004
+++ b/drivers/input/serio/i8042.c	Thu Jul 29 14:40:26 2004
@@ -52,9 +52,10 @@
 module_param_named(dumbkbd, i8042_dumbkbd, bool, 0);
 MODULE_PARM_DESC(dumbkbd, "Pretend that controller can only read data from keyboard");
 
+#ifdef __i386__
 extern unsigned int i8042_dmi_noloop;
+#endif
 static unsigned int i8042_noloop;
-extern unsigned int i8042_dmi_noloop;
 
 __obsolete_setup("i8042_noaux");
 __obsolete_setup("i8042_nomux");

