Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261588AbVA2XN3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261588AbVA2XN3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 18:13:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261590AbVA2XN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 18:13:29 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:8718 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261588AbVA2XM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 18:12:56 -0500
Date: Sun, 30 Jan 2005 00:12:55 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Ralf Baechle <ralf@linux-mips.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 2.6.11-rc2-mm2] fix SERIAL_TXX9 dependencies
Message-ID: <20050129231255.GA3185@stusta.de>
References: <20050129131134.75dacb41.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050129131134.75dacb41.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 29, 2005 at 01:11:34PM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.11-rc2-mm1:
>...
> +mips-txx9-serieal-driver-rewrite.patch
>...
>  MIPS update
>...

It seems the SERIAL_TXX9 dependencies are incorrect.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.11-rc2-mm2-full/drivers/serial/Kconfig.old	2005-01-30 00:08:24.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/serial/Kconfig	2005-01-30 00:07:48.000000000 +0100
@@ -794,7 +794,7 @@
 
 config SERIAL_TXX9
 	bool "TMPTX39XX/49XX SIO support"
-	depends on MIPS || PCI
+	depends on MIPS && PCI
 	select SERIAL_CORE
 
 config SERIAL_TXX9_CONSOLE

