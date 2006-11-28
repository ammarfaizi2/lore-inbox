Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758626AbWK1B2Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758626AbWK1B2Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 20:28:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758634AbWK1B2Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 20:28:24 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:55558 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1758626AbWK1B2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 20:28:23 -0500
Date: Tue, 28 Nov 2006 02:28:27 +0100
From: Adrian Bunk <bunk@stusta.de>
To: tim@cyberelk.net
Cc: linux-parport@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] remove the unused PARIDE_PARPORT function
Message-ID: <20061128012827.GR15364@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the unused PARIDE_PARPORT function.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.19-rc6-mm1/drivers/block/paride/Kconfig.old	2006-11-27 22:13:03.000000000 +0100
+++ linux-2.6.19-rc6-mm1/drivers/block/paride/Kconfig	2006-11-27 22:13:11.000000000 +0100
@@ -1,15 +1,6 @@
 #
 # PARIDE configuration
 #
-# PARIDE doesn't need PARPORT, but if PARPORT is configured as a module,
-# PARIDE must also be a module.  The bogus CONFIG_PARIDE_PARPORT option
-# controls the choices given to the user ...
-# PARIDE only supports PC style parports. Tough for USB or other parports...
-config PARIDE_PARPORT
-	tristate
-	depends on PARIDE!=n
-	default m if PARPORT_PC=m
-	default y if PARPORT_PC!=m
 
 comment "Parallel IDE high-level drivers"
 	depends on PARIDE

