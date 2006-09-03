Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751001AbWICWKP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751001AbWICWKP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 18:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750940AbWICWJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 18:09:50 -0400
Received: from wx-out-0506.google.com ([66.249.82.233]:25868 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750699AbWICWJg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 18:09:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=WYOGcDdqhxHbcJ8aGI88u3WQ5JolPdJOF/W0IVuXx9EqNZH3ZcWdRcysMSqf65Mr/rdpsj/1Hh0HtKu+/Jqq106GXySf1LNx8N5MnTTwfraDB2WfVVGeOsDvmPQVtcf1c8olu9jOuqH3kHCeF23dhgFhZpobjEsAnf5mzTEFLKg=
From: Alon Bar-Lev <alon.barlev@gmail.com>
To: Andi Kleen <ak@suse.de>
Subject: [PATCH 21/26] Dynamic kernel command-line - sparc
Date: Mon, 4 Sep 2006 01:01:47 +0300
User-Agent: KMail/1.9.4
Cc: Matt Domsch <Matt_Domsch@dell.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, johninsd@san.rr.com,
       davej@codemonkey.org.uk, Riley@williams.name, trini@kernel.crashing.org,
       davem@davemloft.net, ecd@brainaid.de, jj@sunsite.ms.mff.cuni.cz,
       anton@samba.org, wli@holomorphy.com, lethal@linux-sh.org, rc@rc0.org.uk,
       spyro@f2s.com, rth@twiddle.net, avr32@atmel.com, hskinnemoen@atmel.com,
       starvik@axis.com, ralf@linux-mips.org, matthew@wil.cx,
       grundler@parisc-linux.org, geert@linux-m68k.org, zippel@linux-m68k.org,
       paulus@samba.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
       uclinux-v850@lsi.nec.co.jp, chris@zankel.net
References: <200609040050.13410.alon.barlev@gmail.com>
In-Reply-To: <200609040050.13410.alon.barlev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609040101.47950.alon.barlev@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Rename saved_command_line into boot_command_line.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---

diff -urNp 
linux-2.6.18-rc5-mm1.org/arch/sparc/kernel/setup.c 
linux-2.6.18-rc5-mm1/arch/sparc/kernel/setup.c
--- linux-2.6.18-rc5-mm1.org/arch/sparc/kernel/setup.c	
2006-09-03 18:55:18.000000000 +0300
+++ linux-2.6.18-rc5-mm1/arch/sparc/kernel/setup.c	
2006-09-03 19:47:59.000000000 +0300
@@ -258,7 +258,7 @@ void __init setup_arch(char **cmdline_p)
 
 	/* Initialize PROM console and command line. */
 	*cmdline_p = prom_getbootargs();
-	strcpy(saved_command_line, *cmdline_p);
+	strcpy(boot_command_line, *cmdline_p);
 
 	/* Set sparc_cpu_model */
 	sparc_cpu_model = sun_unknown;
diff -urNp 
linux-2.6.18-rc5-mm1.org/arch/sparc/kernel/sparc_ksyms.c 
linux-2.6.18-rc5-mm1/arch/sparc/kernel/sparc_ksyms.c
--- linux-2.6.18-rc5-mm1.org/arch/sparc/kernel/sparc_ksyms.c	
2006-09-03 18:55:18.000000000 +0300
+++ linux-2.6.18-rc5-mm1/arch/sparc/kernel/sparc_ksyms.c	
2006-09-03 19:47:59.000000000 +0300
@@ -235,7 +235,7 @@ EXPORT_SYMBOL(prom_getproplen);
 EXPORT_SYMBOL(prom_getproperty);
 EXPORT_SYMBOL(prom_node_has_property);
 EXPORT_SYMBOL(prom_setprop);
-EXPORT_SYMBOL(saved_command_line);
+EXPORT_SYMBOL(boot_command_line);
 EXPORT_SYMBOL(prom_apply_obio_ranges);
 EXPORT_SYMBOL(prom_feval);
 EXPORT_SYMBOL(prom_getbool);

-- 
VGER BF report: H 0.0020444
