Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030443AbWARUpc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030443AbWARUpc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 15:45:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030450AbWARUpb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 15:45:31 -0500
Received: from uproxy.gmail.com ([66.249.92.201]:6282 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030448AbWARUp2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 15:45:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=AQ2bqTTabpwiO35pg0JFPUb1xM+JQ50/146tdp9Tjt3Ms5VtH9v3kjMm+JEuvukEQVNvk5FPzyTb/FnHj1cy39kt8p7XKlC3ciNSN9Doayc/A4LUNlOdNO1JKmUDeaWJyKmTzCR6MfPDf8mwiBQ5H6febY3yRujXDpKfEcarrtY=
Date: Thu, 19 Jan 2006 00:02:53 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ian Molton <spyro@f2s.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] arm26: select BLK_DEV_FD only on A5K
Message-ID: <20060118210253.GJ12771@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 arch/arm26/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

--- a/arch/arm26/Kconfig
+++ b/arch/arm26/Kconfig
@@ -53,7 +53,6 @@ config GENERIC_ISA_DMA
 
 config ARCH_MAY_HAVE_PC_FDC
 	bool
-	default y
 
 source "init/Kconfig"
 
@@ -74,6 +73,7 @@ config ARCH_ARC
 
 config ARCH_A5K
         bool "A5000"
+	select ARCH_MAY_HAVE_PC_FDC
         help
           Say Y here to to support the Acorn A5000.
 

