Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261773AbUB0Kde (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 05:33:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261783AbUB0Kdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 05:33:33 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:53009 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261773AbUB0Kdc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 05:33:32 -0500
Date: Fri, 27 Feb 2004 21:33:20 +1100
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [X86] Allow X86_MCE_NONFATAL to be a module
Message-ID: <20040227103320.GA27726@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi:

By allowing X86_MCE_NONFATAL to be a module, it can be included in
distribution kernels without upsetting those with strange hardware.

Cheers,
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

Index: kernel-2.5/arch/i386/Kconfig
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/arch/i386/Kconfig,v
retrieving revision 1.10
diff -u -r1.10 Kconfig
--- kernel-2.5/arch/i386/Kconfig	19 Feb 2004 09:55:28 -0000	1.10
+++ kernel-2.5/arch/i386/Kconfig	27 Feb 2004 10:31:01 -0000
@@ -569,7 +569,7 @@
 	  the 386 and 486, so nearly everyone can say Y here.
 
 config X86_MCE_NONFATAL
-	bool "Check for non-fatal errors on AMD Athlon/Duron / Intel Pentium 4"
+	tristate "Check for non-fatal errors on AMD Athlon/Duron / Intel Pentium 4"
 	depends on X86_MCE
 	help
 	  Enabling this feature starts a timer that triggers every 5 seconds which

--tKW2IUtsqtDRztdT--
