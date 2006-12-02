Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162424AbWLBK77@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162424AbWLBK77 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 05:59:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162441AbWLBK7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 05:59:48 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:17093 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1759483AbWLBK7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 05:59:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=mCFTMQY+RutSUeAxcP/jjGAITSlmEvJGlV5hs1h6tglQ3O/JKDC2ObfCF3lWJSP+p0l5aXP42avHDr4jUleTWcUoIQAKig2HQMUUuYyy1xxanp8GvVd6/xWk2Pa/AIU7Q8Hht5JbABAokiyNTl3neaEY32QobOFfo4i1S5VfDG0=
From: Alon Bar-Lev <alon.barlev@gmail.com>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 21/26] Dynamic kernel command-line - sparc
Date: Sat, 2 Dec 2006 12:55:59 +0200
User-Agent: KMail/1.9.5
References: <200612021247.43291.alon.barlev@gmail.com>
In-Reply-To: <200612021247.43291.alon.barlev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612021255.59942.alon.barlev@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Rename saved_command_line into boot_command_line.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---

diff -urNp linux-2.6.19.org/arch/sparc/kernel/setup.c linux-2.6.19/arch/sparc/kernel/setup.c
--- linux-2.6.19.org/arch/sparc/kernel/setup.c	2006-11-29 23:57:37.000000000 +0200
+++ linux-2.6.19/arch/sparc/kernel/setup.c	2006-12-02 11:31:33.000000000 +0200
@@ -246,7 +246,7 @@ void __init setup_arch(char **cmdline_p)
 
 	/* Initialize PROM console and command line. */
 	*cmdline_p = prom_getbootargs();
-	strcpy(saved_command_line, *cmdline_p);
+	strcpy(boot_command_line, *cmdline_p);
 
 	/* Set sparc_cpu_model */
 	sparc_cpu_model = sun_unknown;
diff -urNp linux-2.6.19.org/arch/sparc/kernel/sparc_ksyms.c linux-2.6.19/arch/sparc/kernel/sparc_ksyms.c
--- linux-2.6.19.org/arch/sparc/kernel/sparc_ksyms.c	2006-11-29 23:57:37.000000000 +0200
+++ linux-2.6.19/arch/sparc/kernel/sparc_ksyms.c	2006-12-02 11:31:33.000000000 +0200
@@ -237,7 +237,7 @@ EXPORT_SYMBOL(prom_getproplen);
 EXPORT_SYMBOL(prom_getproperty);
 EXPORT_SYMBOL(prom_node_has_property);
 EXPORT_SYMBOL(prom_setprop);
-EXPORT_SYMBOL(saved_command_line);
+EXPORT_SYMBOL(boot_command_line);
 EXPORT_SYMBOL(prom_apply_obio_ranges);
 EXPORT_SYMBOL(prom_feval);
 EXPORT_SYMBOL(prom_getbool);
