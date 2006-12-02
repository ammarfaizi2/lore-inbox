Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759484AbWLBK7w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759484AbWLBK7w (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 05:59:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162418AbWLBK7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 05:59:46 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:55527 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1759484AbWLBK7n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 05:59:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=PlxrLxhARKKebAaNp+Zj352vImKTy7g3p+knohGOD6q8QNbMP+dktbQrUJS6OTqKNsdnQdprELruFkIE2TOiUfMJ9ShsfFFJCgJqiF8bn3affo/RKFZdP7QpuuPKuqzz3NrOACmuIXhT9XBIlWBpZOTioeiKyu1uT9CGyoImTlk=
From: Alon Bar-Lev <alon.barlev@gmail.com>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 22/26] Dynamic kernel command-line - sparc64
Date: Sat, 2 Dec 2006 12:56:19 +0200
User-Agent: KMail/1.9.5
References: <200612021247.43291.alon.barlev@gmail.com>
In-Reply-To: <200612021247.43291.alon.barlev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612021256.19890.alon.barlev@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Rename saved_command_line into boot_command_line.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---

diff -urNp linux-2.6.19.org/arch/sparc64/kernel/setup.c linux-2.6.19/arch/sparc64/kernel/setup.c
--- linux-2.6.19.org/arch/sparc64/kernel/setup.c	2006-11-29 23:57:37.000000000 +0200
+++ linux-2.6.19/arch/sparc64/kernel/setup.c	2006-12-02 11:31:33.000000000 +0200
@@ -315,7 +315,7 @@ void __init setup_arch(char **cmdline_p)
 {
 	/* Initialize PROM console and command line. */
 	*cmdline_p = prom_getbootargs();
-	strcpy(saved_command_line, *cmdline_p);
+	strcpy(boot_command_line, *cmdline_p);
 
 	if (tlb_type == hypervisor)
 		printk("ARCH: SUN4V\n");
diff -urNp linux-2.6.19.org/arch/sparc64/kernel/sparc64_ksyms.c linux-2.6.19/arch/sparc64/kernel/sparc64_ksyms.c
--- linux-2.6.19.org/arch/sparc64/kernel/sparc64_ksyms.c	2006-11-29 23:57:37.000000000 +0200
+++ linux-2.6.19/arch/sparc64/kernel/sparc64_ksyms.c	2006-12-02 11:31:33.000000000 +0200
@@ -253,7 +253,7 @@ EXPORT_SYMBOL(prom_getproplen);
 EXPORT_SYMBOL(prom_getproperty);
 EXPORT_SYMBOL(prom_node_has_property);
 EXPORT_SYMBOL(prom_setprop);
-EXPORT_SYMBOL(saved_command_line);
+EXPORT_SYMBOL(boot_command_line);
 EXPORT_SYMBOL(prom_finddevice);
 EXPORT_SYMBOL(prom_feval);
 EXPORT_SYMBOL(prom_getbool);
