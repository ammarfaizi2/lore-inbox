Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751268AbWEHWBQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbWEHWBQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 18:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbWEHWBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 18:01:16 -0400
Received: from mga03.intel.com ([143.182.124.21]:20046 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751271AbWEHWBP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 18:01:15 -0400
X-IronPort-AV: i="4.05,103,1146466800"; 
   d="scan'208"; a="33365188:sNHT23478154322"
X-MIMEOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] tpm: update module dependencies
Date: Mon, 8 May 2006 17:59:44 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB65EAC0D@hdsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] tpm: update module dependencies
Thread-index: AcZy4f7Jo9lwZ8ZuTU2KINtiWvs8CQACKXiA
From: "Brown, Len" <len.brown@intel.com>
To: "Kylene Jo Hall" <kjhall@us.ibm.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Cc: <akpm@osdl.org>,
       "TPM Device Driver List" <tpmdd-devel@lists.sourceforge.net>
X-OriginalArrivalTime: 08 May 2006 21:59:45.0681 (UTC) FILETIME=[B7B78810:01C672EA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>The TIS driver is dependent upon information from the ACPI table for
>device discovery thus it compiles but does no actual work with out this
>dependency.
>
>Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
>---
> drivers/char/tpm/Kconfig |    2 +-
> 1 files changed, 1 insertion(+), 1 deletion(-)
>
>--- linux-2.6.17-rc3/drivers/char/tpm/Kconfig	2006-04-26 
>21:19:25.000000000 -0500
>+++ linux-2.6.17-rc3-tpm/drivers/char/tpm/Kconfig	
>2006-05-08 16:11:03.707961750 -0500
>@@ -22,7 +22,7 @@ config TCG_TPM
> 
> config TCG_TIS
> 	tristate "TPM Interface Specification 1.2 Interface"
>-	depends on TCG_TPM
>+	depends on TCG_TPM && PNPACPI

I think you want simply "ACPI" rather than "PNPACPI" here, yes?

-Len
