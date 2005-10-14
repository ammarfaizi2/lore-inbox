Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750804AbVJNRRf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbVJNRRf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 13:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750805AbVJNRRf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 13:17:35 -0400
Received: from usbb-lacimss2.unisys.com ([192.63.108.52]:21768 "EHLO
	usbb-lacimss2.unisys.com") by vger.kernel.org with ESMTP
	id S1750804AbVJNRRe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 13:17:34 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] Kconfig fix, (ES7000 dependencies)
Date: Fri, 14 Oct 2005 12:17:15 -0500
Message-ID: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04DC8@USRV-EXCH4.na.uis.unisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Kconfig fix, (ES7000 dependencies)
Thread-Index: AcXQrfIiqAa95k0ITkmyy/xDNw4wqAANINDQ
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "Peter Hagervall" <hager@cs.umu.se>, <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>
X-OriginalArrivalTime: 14 Oct 2005 17:17:16.0036 (UTC) FILETIME=[1FD87440:01C5D0E3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Targets X86_GENERICARCH and X86_ES7000 fail to build without 
> CONFIG_ACPI.
> 
> Signed-off-by: Peter Hagervall <hager@cs.umu.se>
> ---
> 
> diff --git a/arch/i386/Kconfig b/arch/i386/Kconfig
> --- a/arch/i386/Kconfig
> +++ b/arch/i386/Kconfig
> @@ -115,14 +115,14 @@ config X86_VISWS
>  
>  config X86_GENERICARCH
>         bool "Generic architecture (Summit, bigsmp, ES7000, default)"
> -       depends on SMP
> +       depends on SMP && ACPI
>         help
>            This option compiles in the Summit, bigsmp, 
> ES7000, default subarchitectures.
>  	  It is intended for a generic binary kernel.
>  
>  config X86_ES7000
>  	bool "Support for Unisys ES7000 IA32 series"
> -	depends on SMP
> +	depends on SMP && ACPI
>  	help
>  	  Support for Unisys ES7000 systems.  Say 'Y' here if 
> this kernel is
>  	  supposed to run on an IA32-based Unisys ES7000 system.


No, ES7000 doesn't have to depend on ACPI, it uses MPS for
testing/failsafe purposes a lot. I had a patch for the build bix
submitted http://bugzilla.kernel.org/show_bug.cgi?id=5124, I think Len
was going to sort it out.
Thanks,
--Natalie

> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in the body of a message to 
> majordomo@vger.kernel.org More majordomo info at  
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
