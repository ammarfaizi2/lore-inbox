Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262099AbVEFBYl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262099AbVEFBYl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 21:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbVEFBYl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 21:24:41 -0400
Received: from ozlabs.org ([203.10.76.45]:16083 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262099AbVEFBYk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 21:24:40 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17018.51064.311305.718975@cargo.ozlabs.ibm.com>
Date: Fri, 6 May 2005 11:25:12 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
CC: johnrose@austin.ibm.com, linux-kernel@vger.kernel.org, anton@samba.org
Subject: [PATCH] enable CONFIG_RTAS_PROC by default
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables CONFIG_RTAS_PROC by default on pSeries.  This will
preserve /proc/ppc64/rtas/rmo_buffer, which is needed by librtas.

This patch should go in 2.6.12.

Signed-off-by: John Rose <johnrose@austin.ibm.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>
---
diff -puN arch/ppc64/Kconfig~fix_Kconfig arch/ppc64/Kconfig
--- 2_6_linus_3/arch/ppc64/Kconfig~fix_Kconfig	2005-04-12 18:03:45.000000000 -0500
+++ 2_6_linus_3-johnrose/arch/ppc64/Kconfig	2005-04-12 18:03:56.000000000 -0500
@@ -262,6 +262,7 @@ config PPC_RTAS
 config RTAS_PROC
 	bool "Proc interface to RTAS"
 	depends on PPC_RTAS
+	default y
 
 config RTAS_FLASH
 	tristate "Firmware flash interface"
