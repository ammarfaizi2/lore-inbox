Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751321AbVJ2FHq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbVJ2FHq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 01:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbVJ2FHq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 01:07:46 -0400
Received: from usbb-lacimss1.unisys.com ([192.63.108.51]:55570 "EHLO
	usbb-lacimss1.unisys.com") by vger.kernel.org with ESMTP
	id S1751321AbVJ2FHp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 01:07:45 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] Kconfig fix, (ES7000 dependencies)
Date: Sat, 29 Oct 2005 00:07:34 -0500
Message-ID: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04DFA@USRV-EXCH4.na.uis.unisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Kconfig fix, (ES7000 dependencies)
Thread-Index: AcXQrfIiqAa95k0ITkmyy/xDNw4wqAANINDQAti2I2A=
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       "Peter Hagervall" <hager@cs.umu.se>, <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>
X-OriginalArrivalTime: 29 Oct 2005 05:07:35.0445 (UTC) FILETIME=[ACC6AC50:01C5DC46]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Targets X86_GENERICARCH and X86_ES7000 fail to build without 
> > CONFIG_ACPI.
> > 
> > Signed-off-by: Peter Hagervall <hager@cs.umu.se>
> > ---
> > 
> > diff --git a/arch/i386/Kconfig b/arch/i386/Kconfig
> > --- a/arch/i386/Kconfig
> > +++ b/arch/i386/Kconfig
> > @@ -115,14 +115,14 @@ config X86_VISWS
> >  
> >  config X86_GENERICARCH
> >         bool "Generic architecture (Summit, bigsmp, ES7000, 
> default)"
> > -       depends on SMP
> > +       depends on SMP && ACPI
> >         help
> >            This option compiles in the Summit, bigsmp, 
> ES7000, default 
> > subarchitectures.
> >  	  It is intended for a generic binary kernel.
> >  
> >  config X86_ES7000
> >  	bool "Support for Unisys ES7000 IA32 series"
> > -	depends on SMP
> > +	depends on SMP && ACPI
> >  	help
> >  	  Support for Unisys ES7000 systems.  Say 'Y' here if 
> this kernel is
> >  	  supposed to run on an IA32-based Unisys ES7000 system.
> 
> 
> No, ES7000 doesn't have to depend on ACPI, it uses MPS for 
> testing/failsafe purposes a lot. I had a patch for the build 
> bix submitted 
> http://bugzilla.kernel.org/show_bug.cgi?id=5124, I think Len 
> was going to sort it out.

Peter, I'd have to take it back - no objections to ACPI dependency for
ES7000 (since the acpi=off switch will serve our needs just fine). The
patch I had is perhaps too elaborate :) and it's easier just do it as
you suggested. As long as no worries from other genapic entities (like
Summit? or someone out there with large configuration and no ACPI), the
patch is fine with me.
Thanks,
--Natalie 
