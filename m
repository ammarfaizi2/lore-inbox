Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261993AbVAHJKN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261993AbVAHJKN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 04:10:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261991AbVAHIru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 03:47:50 -0500
Received: from mail.kroah.org ([69.55.234.183]:57989 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261888AbVAHFs3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:29 -0500
Subject: Re: [PATCH] I2C patches for 2.6.10
In-Reply-To: <1105162774723@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:39:35 -0800
Message-Id: <11051627741477@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.439.54, 2005/01/07 11:15:15-08:00, ladis@linux-mips.org

[PATCH] I2C: let I2C_ALGO_SGI depend on MIPS

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/algos/Kconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/i2c/algos/Kconfig b/drivers/i2c/algos/Kconfig
--- a/drivers/i2c/algos/Kconfig	2005-01-07 14:53:33 -08:00
+++ b/drivers/i2c/algos/Kconfig	2005-01-07 14:53:33 -08:00
@@ -61,7 +61,7 @@
 
 config I2C_ALGO_SGI
 	tristate "I2C SGI interfaces"
-	depends on I2C
+	depends on I2C && (SGI_IP22 || SGI_IP32 || X86_VISWS)
 	help
 	  Supports the SGI interfaces like the ones found on SGI Indy VINO
 	  or SGI O2 MACE.

