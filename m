Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264777AbTE1Prt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 11:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264778AbTE1Prr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 11:47:47 -0400
Received: from hazard.jcu.cz ([160.217.1.6]:62081 "EHLO hazard.jcu.cz")
	by vger.kernel.org with ESMTP id S264777AbTE1Prl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 11:47:41 -0400
Date: Wed, 28 May 2003 18:00:56 +0200
From: Jan Marek <linux@hazard.jcu.cz>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.70 mmu_cr4_features
Message-ID: <20030528160056.GB1454@hazard.jcu.cz>
References: <20030528155803.GA1454@hazard.jcu.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
In-Reply-To: <20030528155803.GA1454@hazard.jcu.cz>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 28, 2003 at 05:58:03PM +0200, Jan Marek wrote:
> Hallo l-k,
> 
> I tried to correct a 'Missing mmu_cr4_features symbol' in the DRM
> modules (in my case it's i810).
> 
> I've found this symbol only in i386 and x86_64 architectures...
> 
> For me this patch works fine.

attaching missing patch, sorry...

Sincerely
Jan Marek
-- 
Ing. Jan Marek
University of South Bohemia
Academic Computer Centre
Phone: +420-38-7772080

--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="mmu_rc4_features.patch"

diff -urN linux-2.5.70/arch/i386/kernel/setup.c linux-2.5.70-new/arch/i386/kernel/setup.c
--- linux-2.5.70/arch/i386/kernel/setup.c	2003-05-27 03:00:39.000000000 +0200
+++ linux-2.5.70-new/arch/i386/kernel/setup.c	2003-05-28 11:17:09.000000000 +0200
@@ -35,6 +35,7 @@
 #include <linux/console.h>
 #include <linux/root_dev.h>
 #include <linux/highmem.h>
+#include <linux/module.h>
 #include <video/edid.h>
 #include <asm/e820.h>
 #include <asm/mpspec.h>
@@ -58,6 +59,7 @@
 struct cpuinfo_x86 boot_cpu_data = { 0, 0, 0, 0, -1, 1, 0, 0, -1 };
 
 unsigned long mmu_cr4_features;
+EXPORT_SYMBOL(mmu_cr4_features);
 
 int acpi_disabled __initdata = 0;
 
diff -urN linux-2.5.70/arch/x86_64/kernel/setup.c linux-2.5.70-new/arch/x86_64/kernel/setup.c
--- linux-2.5.70/arch/x86_64/kernel/setup.c	2003-05-27 03:00:21.000000000 +0200
+++ linux-2.5.70-new/arch/x86_64/kernel/setup.c	2003-05-28 11:31:49.000000000 +0200
@@ -31,6 +31,7 @@
 #include <linux/initrd.h>
 #include <linux/highmem.h>
 #include <linux/bootmem.h>
+#include <linux/module.h>
 #include <asm/processor.h>
 #include <linux/console.h>
 #include <linux/seq_file.h>
@@ -61,6 +62,7 @@
 struct cpuinfo_x86 boot_cpu_data;
 
 unsigned long mmu_cr4_features;
+EXPORT_SYMBOL(mmu_cr4_features);
 
 int acpi_disabled __initdata = 0;
 

--Qxx1br4bt0+wmkIi--
