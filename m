Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751367AbVLADIg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbVLADIg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 22:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbVLADIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 22:08:36 -0500
Received: from fmr13.intel.com ([192.55.52.67]:62121 "EHLO
	fmsfmr001.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751367AbVLADIg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 22:08:36 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [patch 5/9] ACPI should depend on, not select PCI
Date: Wed, 30 Nov 2005 20:58:22 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B300549CF57@hdsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch 5/9] ACPI should depend on, not select PCI
Thread-Index: AcXcCuMgyzE36HFnR4mcJue5P01GOQaD4d4g
From: "Brown, Len" <len.brown@intel.com>
To: <akpm@osdl.org>, <bunk@stusta.de>
Cc: <acpi-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 01 Dec 2005 01:58:24.0656 (UTC) FILETIME=[B6CF7900:01C5F61A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No, I can't apply this -- it allows
Kconfig to create IA64 configs without PCI,
which do not build.

there must be a better way.

-Len 

>-----Original Message-----
>From: akpm@osdl.org [mailto:akpm@osdl.org] 
>Sent: Friday, October 28, 2005 6:00 PM
>To: Brown, Len
>Cc: acpi-devel@lists.sourceforge.net; akpm@osdl.org; bunk@stusta.de
>Subject: [patch 5/9] ACPI should depend on, not select PCI
>
>
>From: Adrian Bunk <bunk@stusta.de>
>
>ACPI should depend on, not select PCI.
>
>The practical differences should be nearly zero except that it avoids 
>the illegal configuration PCI=y, X86_VOYAGER=y.
>
>Signed-off-by: Adrian Bunk <bunk@stusta.de>
>Signed-off-by: Andrew Morton <akpm@osdl.org>
>---
>
> drivers/acpi/Kconfig |    2 +-
> 1 files changed, 1 insertion(+), 1 deletion(-)
>
>diff -puN 
>drivers/acpi/Kconfig~acpi-should-depend-on-not-select-pci 
>drivers/acpi/Kconfig
>--- 
>25/drivers/acpi/Kconfig~acpi-should-depend-on-not-select-pci	
>Fri Oct 28 14:59:08 2005
>+++ 25-akpm/drivers/acpi/Kconfig	Fri Oct 28 14:59:21 2005
>@@ -10,8 +10,8 @@ menu "ACPI (Advanced Configuration and P
> config ACPI
> 	bool "ACPI Support"
> 	depends on IA64 || X86
>+	depends on PCI
> 	select PM
>-	select PCI
> 
> 	default y
> 	---help---
>_
>
