Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262298AbTIZBNn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 21:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262304AbTIZBNn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 21:13:43 -0400
Received: from fmr09.intel.com ([192.52.57.35]:39902 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S262298AbTIZBNc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 21:13:32 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: HT not working by default since 2.4.22
Date: Thu, 25 Sep 2003 18:13:26 -0700
Message-ID: <7F740D512C7C1046AB53446D3720017304AFAA@scsmsx402.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: HT not working by default since 2.4.22
Thread-Index: AcODwcqzNOlRVNpiR4GHeu3zvaMuiwACQbWg
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Jeff Garzik" <jgarzik@pobox.com>,
       <marcelo@parcelfarce.linux.theplanet.co.uk>
Cc: "Brown, Len" <len.brown@intel.com>,
       "Marcelo Tosatti" <marcelo.tosatti@cyclades.com.br>,
       <linux-kernel@vger.kernel.org>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>
X-OriginalArrivalTime: 26 Sep 2003 01:13:26.0773 (UTC) FILETIME=[63847250:01C383CB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> How about the more simple CONFIG_HYPERTHREAD or CONFIG_HT?
> 
> If enabled and CONFIG_SMP is set, then we will attempt to discover HT
> via ACPI tables, regardless of CONFIG_ACPI value.
>
Sounds good to me. 

Thanks,
Jun

> -----Original Message-----
> From: Jeff Garzik [mailto:jgarzik@pobox.com]
> Sent: Thursday, September 25, 2003 5:04 PM
> To: marcelo@parcelfarce.linux.theplanet.co.uk
> Cc: Brown, Len; Marcelo Tosatti; linux-kernel@vger.kernel.org; Alan
Cox;
> Nakajima, Jun
> Subject: Re: HT not working by default since 2.4.22
> 
> marcelo@parcelfarce.linux.theplanet.co.uk wrote:
> > On Wed, 24 Sep 2003, Brown, Len wrote:
> >
> >
> >>Okay, so what to do?
> >>
> >>We could make 2.4.23 like 2.4.21 where ACPI code for HT is included
in
> >>the kernel even when CONFIG_ACPI is not set.
> >>
> >>Or we could leave 2.4.23 like 2.4.22 where disabling CONFIG_ACPI
really
> >>does remove all ACPI code in the kernel; and when CONFIG_ACPI is
set,
> >>CONFIG_ACPI_HT_ONLY is available to limit ACPI to just the tables
part
> >>needed for HT.
> >
> >
> > CONFIG_ACPI_HT should be not dependant on CONFIG_ACPI. So
> >
> > 1) Please make it very clear on the configuration that for HT
> > CONFIG_ACPI_HT_ONLY is needed
> > 2) Move it outside CONFIG_ACPI.
> >
> > OK?
> 
> 
> Unfortunately CONFIG_ACPI_HT_ONLY outside and independent of
CONFIG_ACPI
> proved a bit confusing.
> 
> How about the more simple CONFIG_HYPERTHREAD or CONFIG_HT?
> 
> If enabled and CONFIG_SMP is set, then we will attempt to discover HT
> via ACPI tables, regardless of CONFIG_ACPI value.
> 
> Or... (I know multiple people will shoot me for saying this) we could
> resurrect acpitable.[ch], and build that when CONFIG_ACPI is disabled.
> 
> 	Jeff
> 
> 

