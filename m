Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750897AbVIBTMB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897AbVIBTMB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 15:12:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750924AbVIBTMB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 15:12:01 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:15298 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750897AbVIBTMA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 15:12:00 -0400
Date: Fri, 2 Sep 2005 20:12:01 +0100
From: viro@ZenIV.linux.org.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] more of sparc32 dependencies fallout
Message-ID: <20050902191201.GB5155@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

More stuff that got exposed to sparc32 build due to inclusion of
drivers/char/Kconfig in arch/sparc/Kconfig needs to be excluded.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC13-zatm/drivers/char/Kconfig RC13-mxser-sparc32/drivers/char/Kconfig
--- RC13-zatm/drivers/char/Kconfig	2005-09-02 03:34:00.000000000 -0400
+++ RC13-mxser-sparc32/drivers/char/Kconfig	2005-09-02 03:34:20.000000000 -0400
@@ -175,7 +175,7 @@
 
 config MOXA_SMARTIO
 	tristate "Moxa SmartIO support"
-	depends on SERIAL_NONSTANDARD
+	depends on SERIAL_NONSTANDARD && (BROKEN || !SPARC32)
 	help
 	  Say Y here if you have a Moxa SmartIO multiport serial card.
 
