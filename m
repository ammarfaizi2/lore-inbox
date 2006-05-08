Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750787AbWEHW0N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbWEHW0N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 18:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbWEHW0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 18:26:12 -0400
Received: from mga02.intel.com ([134.134.136.20]:47445 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750728AbWEHW0L convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 18:26:11 -0400
X-IronPort-AV: i="4.05,103,1146466800"; 
   d="scan'208"; a="33342758:sNHT377453615"
X-MIMEOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] tpm: update module dependencies (PNPACPI)
Date: Mon, 8 May 2006 18:26:05 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB65EAC3D@hdsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] tpm: update module dependencies (PNPACPI)
Thread-index: AcZy7NmodhP6GuFIQDa+jGgq+jnUkAAAQMAA
From: "Brown, Len" <len.brown@intel.com>
To: "Kylene Jo Hall" <kjhall@us.ibm.com>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>, <akpm@osdl.org>,
       "TPM Device Driver List" <tpmdd-devel@lists.sourceforge.net>,
       <linux-acpi@vger.kernel.org>
X-OriginalArrivalTime: 08 May 2006 22:26:06.0038 (UTC) FILETIME=[65AEDF60:01C672EE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Mon, 2006-05-08 at 17:59 -0400, Brown, Len wrote:
>> >The TIS driver is dependent upon information from the ACPI table for
>> >device discovery thus it compiles but does no actual work 
>with out this
>> >dependency.
>> >
>> >Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
>> >---
>> > drivers/char/tpm/Kconfig |    2 +-
>> > 1 files changed, 1 insertion(+), 1 deletion(-)
>> >
>> >--- linux-2.6.17-rc3/drivers/char/tpm/Kconfig	2006-04-26 
>> >21:19:25.000000000 -0500
>> >+++ linux-2.6.17-rc3-tpm/drivers/char/tpm/Kconfig	
>> >2006-05-08 16:11:03.707961750 -0500
>> >@@ -22,7 +22,7 @@ config TCG_TPM
>> > 
>> > config TCG_TIS
>> > 	tristate "TPM Interface Specification 1.2 Interface"
>> >-	depends on TCG_TPM
>> >+	depends on TCG_TPM && PNPACPI
>> 
>> I think you want simply "ACPI" rather than "PNPACPI" here, yes?

>No I think I really want PNPACPI because I have a pnp_driver which
>probes based on a CID value.  PNPACPI is dependent on ACPI.  Am I
>misunderstanding something.  It works with PNPACPI on but turning off
>only PNPACPI causes it to not work.

So if you boot with "pnpacpi=off" it fails to probe?
Nice to have proof that PNPACPI finally obsoletes PNPBIOS
on a real system in the field.

thanks,
-Len
