Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030222AbVIIQHJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030222AbVIIQHJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 12:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030212AbVIIQHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 12:07:08 -0400
Received: from fmr16.intel.com ([192.55.52.70]:28822 "EHLO
	fmsfmr006.fm.intel.com") by vger.kernel.org with ESMTP
	id S1030222AbVIIQHH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 12:07:07 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH] [2.6.13-mm2] set IBM ThinkPad extras to default n in Kconfig
Date: Fri, 9 Sep 2005 12:06:34 -0400
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B30048FA292@hdsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] [2.6.13-mm2] set IBM ThinkPad extras to default n in Kconfig
Thread-Index: AcW1E9TzVUTUwRZ4Tn2hROgorwD2DAAQ2F6g
From: "Brown, Len" <len.brown@intel.com>
To: "Andi Kleen" <ak@suse.de>, <akpm@osdl.org>,
       "Borislav Petkov" <petkov@uni-muenster.de>
Cc: <acpi-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 09 Sep 2005 16:06:36.0943 (UTC) FILETIME=[74B0F1F0:01C5B558]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Hi Andrew,
>
>   I think the following isn't on purpose but the IBM Thinkpad acpi
>   extras default to y in Kconfig. The patch below fixes it:
>
>   Signed-off-by: <petkov@uni-muenster.de>
>
>
>--- drivers/acpi/Kconfig.orig	2005-09-09 09:46:26.000000000 +0200
>+++ drivers/acpi/Kconfig	2005-09-09 09:46:46.000000000 +0200
>@@ -197,7 +197,7 @@ config ACPI_ASUS
> config ACPI_IBM
> 	tristate "IBM ThinkPad Laptop Extras"
> 	depends on X86
>-	default y
>+	default n
> 	---help---
> 	  This is a Linux ACPI driver for the IBM ThinkPad 

Before we had "default m", since that is how a distro
is expected to compile this, and other, "ACPI drivers".

But we got complaits that _nothing_ should be "default m",
so I changed it to "default y".  Maybe that was simplistic --
button should be "default y", but the platform drivers should
all be "default n"?

I'm not sure what to do here -- what use-model
should we tune default Kconfig for?

thanks,
-Len
