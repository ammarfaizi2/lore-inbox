Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262940AbVFVImE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262940AbVFVImE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 04:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262897AbVFVIjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 04:39:24 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:65187 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262901AbVFVIh4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 04:37:56 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Hollis Blanchard <hollis@penguinppc.org>,
       Paul Mackerras <paulus@samba.org>
Subject: [PATCH] ppc64: enable BPA nvram driver
Date: Wed, 22 Jun 2005 10:34:37 +0200
User-Agent: KMail/1.7.2
Cc: ppc64-dev List <linuxppc64-dev@ozlabs.org>,
       LKML list <linux-kernel@vger.kernel.org>,
       Hollis Blanchard <hollis@penguinppc.org>
References: <200506212310.54156.arnd@arndb.de> <200506212324.19713.arnd@arndb.de> <eaabcca10740f5e2cd8a1ca86245ba5d@penguinppc.org>
In-Reply-To: <eaabcca10740f5e2cd8a1ca86245ba5d@penguinppc.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506221034.39268.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hollis Blanchard noticed that the initialization of the nvram driver
was commented out in [PATCH 7/11] ppc64: add BPA platform type,
which probably resulted from my reordering the patches incorrectly.

Signed-off-by: Arnd Bergmann <arndb@de.ibm.com>

--- linux-cg.orig/arch/ppc64/kernel/bpa_setup.c	2005-06-22 10:33:09.329915056 -0400
+++ linux-cg/arch/ppc64/kernel/bpa_setup.c	2005-06-22 10:32:43.138901744 -0400
@@ -91,7 +91,7 @@ static void __init bpa_setup_arch(void)
 	conswitchp = &dummy_con;
 #endif
 
-	// bpa_nvram_init();
+	bpa_nvram_init();
 }
 
 /*
