Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262955AbVAFSRL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262955AbVAFSRL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 13:17:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262986AbVAFSQ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 13:16:58 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:11281 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262955AbVAFSPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 13:15:30 -0500
Date: Thu, 6 Jan 2005 19:15:20 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, greg@kroah.com,
       Ladislav Michl <ladis@linux-mips.org>
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com,
       ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: [2.6 patch] 2.6.10-mm2: let I2C_ALGO_SGI depend on MIPS
Message-ID: <20050106181519.GG3096@stusta.de>
References: <20050106002240.00ac4611.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050106002240.00ac4611.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2005 at 12:22:40AM -0800, Andrew Morton wrote:
>...
> All 560 patches:
>...
> bk-i2c.patch
>...


There's no reason for offering a MIPS-only driver on other architectures 
(even though it does compile).

Even better dependencies on specific MIPS variables might be possible 
that obsolete this patch, but this patch fixes at least the !MIPS case.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-mm2-full/drivers/i2c/algos/Kconfig.old	2005-01-06 19:07:16.000000000 +0100
+++ linux-2.6.10-mm2-full/drivers/i2c/algos/Kconfig	2005-01-06 19:08:22.000000000 +0100
@@ -61,7 +61,7 @@
 
 config I2C_ALGO_SGI
 	tristate "I2C SGI interfaces"
-	depends on I2C
+	depends on I2C && MIPS
 	help
 	  Supports the SGI interfaces like the ones found on SGI Indy VINO
 	  or SGI O2 MACE.


