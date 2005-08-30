Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932527AbVISST4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932527AbVISST4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 14:19:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932550AbVISSTz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 14:19:55 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3202 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S932527AbVISSTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 14:19:54 -0400
Date: Tue, 30 Aug 2005 17:35:09 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] more sparc32 dependencies fallout
Message-ID: <20050830163509.GK9322@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	More stuff that got exposed to sparc32 build due to inclusion
of drivers/char/Kconfig needs to be excluded
Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-base/drivers/char/Kconfig current/drivers/char/Kconfig
--- RC13-base/drivers/char/Kconfig	2005-08-30 03:24:42.000000000 -0400
+++ current/drivers/char/Kconfig	2005-08-30 03:25:18.000000000 -0400
@@ -175,7 +175,7 @@
 
 config MOXA_SMARTIO
 	tristate "Moxa SmartIO support"
-	depends on SERIAL_NONSTANDARD
+	depends on SERIAL_NONSTANDARD && (BROKEN || !SPARC32)
 	help
 	  Say Y here if you have a Moxa SmartIO multiport serial card.
 
