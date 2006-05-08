Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751320AbWEHWOc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbWEHWOc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 18:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbWEHWOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 18:14:30 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:2790 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751290AbWEHWO0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 18:14:26 -0400
Subject: RE: [PATCH] tpm: update module dependencies
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: "Brown, Len" <len.brown@intel.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       TPM Device Driver List <tpmdd-devel@lists.sourceforge.net>
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB65EAC0D@hdsmsx411.amr.corp.intel.com>
References: <CFF307C98FEABE47A452B27C06B85BB65EAC0D@hdsmsx411.amr.corp.intel.com>
Content-Type: text/plain
Date: Mon, 08 May 2006 17:12:49 -0500
Message-Id: <1147126369.29414.63.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No I think I really want PNPACPI because I have a pnp_driver which
probes based on a CID value.  PNPACPI is dependent on ACPI.  Am I
misunderstanding something.  It works with PNPACPI on but turning off
only PNPACPI causes it to not work.

Thanks,
Kylie

On Mon, 2006-05-08 at 17:59 -0400, Brown, Len wrote:
> >The TIS driver is dependent upon information from the ACPI table for
> >device discovery thus it compiles but does no actual work with out this
> >dependency.
> >
> >Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
> >---
> > drivers/char/tpm/Kconfig |    2 +-
> > 1 files changed, 1 insertion(+), 1 deletion(-)
> >
> >--- linux-2.6.17-rc3/drivers/char/tpm/Kconfig	2006-04-26 
> >21:19:25.000000000 -0500
> >+++ linux-2.6.17-rc3-tpm/drivers/char/tpm/Kconfig	
> >2006-05-08 16:11:03.707961750 -0500
> >@@ -22,7 +22,7 @@ config TCG_TPM
> > 
> > config TCG_TIS
> > 	tristate "TPM Interface Specification 1.2 Interface"
> >-	depends on TCG_TPM
> >+	depends on TCG_TPM && PNPACPI
> 
> I think you want simply "ACPI" rather than "PNPACPI" here, yes?
> 
> -Len

