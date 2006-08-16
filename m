Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750763AbWHPE7T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbWHPE7T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 00:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbWHPE7T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 00:59:19 -0400
Received: from mga03.intel.com ([143.182.124.21]:53821 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1750733AbWHPE7S convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 00:59:18 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.08,130,1154934000"; 
   d="scan'208"; a="103552508:sNHT28982863"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch] pci/hotplug acpiphp: fix Kconfig for Dock dependencies
Date: Wed, 16 Aug 2006 00:59:09 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6013DE0BC@hdsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch] pci/hotplug acpiphp: fix Kconfig for Dock dependencies
Thread-Index: Acaw2YxdI+vuJ3lQQCCk00GFigzJngQFyHfA
From: "Brown, Len" <len.brown@intel.com>
To: "Accardi, Kristen C" <kristen.c.accardi@intel.com>,
       "Keshavamurthy, Anil S" <anil.s.keshavamurthy@intel.com>
Cc: <linux-acpi@vger.kernel.org>, <akpm@osdl.org>, <zippel@linux-m68k.org>,
       <rdunlap@xenotime.net>, <linux-kernel@vger.kernel.org>,
       <greg@kroah.com>, <pcihpd-discuss@lists.sourceforge.net>
X-OriginalArrivalTime: 16 Aug 2006 04:59:10.0468 (UTC) FILETIME=[B5FE8C40:01C6C0F0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.

thanks,
-Len 

>-----Original Message-----
>From: Kristen Carlson Accardi [mailto:kristen.c.accardi@intel.com] 
>Sent: Wednesday, July 26, 2006 1:32 PM
>To: Keshavamurthy, Anil S
>Cc: linux-acpi@vger.kernel.org; Brown, Len; akpm@osdl.org; 
>zippel@linux-m68k.org; rdunlap@xenotime.net; 
>linux-kernel@vger.kernel.org; greg@kroah.com; 
>pcihpd-discuss@lists.sourceforge.net
>Subject: Re: [patch] pci/hotplug acpiphp: fix Kconfig for Dock 
>dependencies
>
>---
>I confirmed that Anil's patch will work, here is a proper patch with
>Anil's changes.
>
>Change the build options for acpiphp so that it may build without being
>dependent on the ACPI_DOCK option, but yet does not allow the option of
>acpiphp being built-in when dock is built as a module.
>
>Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
>Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
>---
> drivers/pci/hotplug/Kconfig |    2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>--- 2.6-git.orig/drivers/pci/hotplug/Kconfig
>+++ 2.6-git/drivers/pci/hotplug/Kconfig
>@@ -76,7 +76,7 @@ config HOTPLUG_PCI_IBM
> 
> config HOTPLUG_PCI_ACPI
> 	tristate "ACPI PCI Hotplug driver"
>-	depends on ACPI_DOCK && HOTPLUG_PCI
>+	depends on (!ACPI_DOCK && ACPI && HOTPLUG_PCI) || 
>(ACPI_DOCK && HOTPLUG_PCI)
> 	help
> 	  Say Y here if you have a system that supports PCI 
>Hotplug using
> 	  ACPI.
>
