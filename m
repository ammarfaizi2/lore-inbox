Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750955AbWJAPVT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750955AbWJAPVT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 11:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750974AbWJAPVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 11:21:19 -0400
Received: from havoc.gtf.org ([69.61.125.42]:3563 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1750955AbWJAPVS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 11:21:18 -0400
Date: Sun, 1 Oct 2006 11:21:16 -0400
From: Jeff Garzik <jeff@garzik.org>
To: kkeil@suse.de, kai.germaschewski@gmx.de, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] ISDN: mark as 32-bit only
Message-ID: <20061001152116.GA4684@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Tons of ISDN drivers cast pointers to/from 32-bit values, which just
won't work on 64-bit.

Signed-off-by: Jeff Garzik <jeff@garzik.org>

diff --git a/drivers/isdn/Kconfig b/drivers/isdn/Kconfig
index c90afee..608588f 100644
--- a/drivers/isdn/Kconfig
+++ b/drivers/isdn/Kconfig
@@ -6,7 +6,7 @@ menu "ISDN subsystem"
 
 config ISDN
 	tristate "ISDN support"
-	depends on NET
+	depends on NET && 32BIT
 	---help---
 	  ISDN ("Integrated Services Digital Networks", called RNIS in France)
 	  is a special type of fully digital telephone service; it's mostly
