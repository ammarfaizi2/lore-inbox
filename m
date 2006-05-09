Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751772AbWEIOCX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751772AbWEIOCX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 10:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751753AbWEIOCX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 10:02:23 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:36812 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751310AbWEIOCW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 10:02:22 -0400
Subject: Re: [tpmdd-devel] RE: [PATCH] tpm: update module dependencies
	(PNPACPI)
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: "Brown, Len" <len.brown@intel.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       TPM Device Driver List <tpmdd-devel@lists.sourceforge.net>,
       linux-acpi@vger.kernel.org
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB65EAC3D@hdsmsx411.amr.corp.intel.com>
References: <CFF307C98FEABE47A452B27C06B85BB65EAC3D@hdsmsx411.amr.corp.intel.com>
Content-Type: text/plain
Date: Tue, 09 May 2006 09:00:33 -0500
Message-Id: <1147183233.29414.66.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-08 at 18:26 -0400, Brown, Len wrote:
> >On Mon, 2006-05-08 at 17:59 -0400, Brown, Len wrote:
> >> >The TIS driver is dependent upon information from the ACPI table for
> >> >device discovery thus it compiles but does no actual work 
> >with out this
> >> >dependency.
> >> >
> >> >Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
> >> >---
> >> > drivers/char/tpm/Kconfig |    2 +-
> >> > 1 files changed, 1 insertion(+), 1 deletion(-)
> >> >
> >> >--- linux-2.6.17-rc3/drivers/char/tpm/Kconfig	2006-04-26 
> >> >21:19:25.000000000 -0500
> >> >+++ linux-2.6.17-rc3-tpm/drivers/char/tpm/Kconfig	
> >> >2006-05-08 16:11:03.707961750 -0500
> >> >@@ -22,7 +22,7 @@ config TCG_TPM
> >> > 
> >> > config TCG_TIS
> >> > 	tristate "TPM Interface Specification 1.2 Interface"
> >> >-	depends on TCG_TPM
> >> >+	depends on TCG_TPM && PNPACPI
> >> 
> >> I think you want simply "ACPI" rather than "PNPACPI" here, yes?
> 
> >No I think I really want PNPACPI because I have a pnp_driver which
> >probes based on a CID value.  PNPACPI is dependent on ACPI.  Am I
> >misunderstanding something.  It works with PNPACPI on but turning off
> >only PNPACPI causes it to not work.
> 
> So if you boot with "pnpacpi=off" it fails to probe?
> Nice to have proof that PNPACPI finally obsoletes PNPBIOS
> on a real system in the field.

Correct probe fails with pnpacpi=off.

Thanks,
Kylie

> 
> thanks,
> -Len
> 
> 
> -------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid0709&bid&3057&dat1642
> _______________________________________________
> tpmdd-devel mailing list
> tpmdd-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/tpmdd-devel

