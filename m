Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268311AbUH2U7x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268311AbUH2U7x (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 16:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268305AbUH2U7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 16:59:53 -0400
Received: from verein.lst.de ([213.95.11.210]:3000 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S266836AbUH2U7u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 16:59:50 -0400
Date: Sun, 29 Aug 2004 22:59:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] mark pcxx as broken
Message-ID: <20040829205946.GB5136@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's already marked BROKEN_ON_SMP, but even a UP compile yields tons of
errors.  While those aren't deeply complicated to fix having them for
over a year now is a pretty good indicator no one cares.


--- 1.49/drivers/char/Kconfig	2004-08-28 19:04:06 +02:00
+++ edited/drivers/char/Kconfig	2004-08-29 22:39:10 +02:00
@@ -138,7 +138,7 @@
 
 config DIGIEPCA
 	tristate "Digiboard Intelligent Async Support"
-	depends on SERIAL_NONSTANDARD && BROKEN_ON_SMP
+	depends on SERIAL_NONSTANDARD && BROKEN
 	---help---
 	  This is a driver for Digi International's Xx, Xeve, and Xem series
 	  of cards which provide multiple serial ports. You would need
