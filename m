Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270200AbTHSKd3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 06:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270203AbTHSKd3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 06:33:29 -0400
Received: from nessie.weebeastie.net ([61.8.7.205]:38036 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id S270200AbTHSKd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 06:33:26 -0400
Date: Tue, 19 Aug 2003 20:34:17 +1000
From: CaT <cat@zip.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Dumitru Ciobarcianu <cioby@ines.ro>, linux-kernel@vger.kernel.org,
       linux-acpi@unix-os.sc.intel.com
Subject: [PATCH] Re: 2.6.0-test3-mm3
Message-ID: <20030819103417.GU643@zip.com.au>
References: <20030819013834.1fa487dc.akpm@osdl.org> <Pine.LNX.4.44.0308191302180.15679-100000@MailBox.iNES.RO> <20030819031755.730e892b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="n1iI6MeELQa9IOaF"
Content-Disposition: inline
In-Reply-To: <20030819031755.730e892b.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--n1iI6MeELQa9IOaF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 19, 2003 at 03:17:55AM -0700, Andrew Morton wrote:
> If you look at it, yes, everything in there has become dependent on
> X86_LOCAL_APIC.   It looks like a mistake.

This patch works for me (against bk6)

-- 
"How can I not love the Americans? They helped me with a flat tire the
other day," he said.
	- http://tinyurl.com/h6fo

--n1iI6MeELQa9IOaF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="2.6.0-t3-bk6.acpiht.patch"

--- linux/drivers/acpi/Kconfig.old	Tue Aug 19 20:27:41 2003
+++ linux/drivers/acpi/Kconfig	Tue Aug 19 20:31:33 2003
@@ -30,7 +30,7 @@
 	bool "Full ACPI Support"
 	depends on !X86_VISWS
 	depends on !IA64_HP_SIM
-	depends on IA64 || (X86 && ACPI_HT)
+	depends on IA64 || X86
 	default y
 	---help---
 	  Advanced Configuration and Power Interface (ACPI) support for 

--n1iI6MeELQa9IOaF--
