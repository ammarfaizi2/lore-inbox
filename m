Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263849AbTHWBpZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 21:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264272AbTHWBpZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 21:45:25 -0400
Received: from hermes.py.intel.com ([146.152.216.3]:7918 "EHLO
	hermes.py.intel.com") by vger.kernel.org with ESMTP id S263849AbTHWBpJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 21:45:09 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: [patch] noapic should depend on ioapic config not local
Date: Fri, 22 Aug 2003 18:45:06 -0700
Message-ID: <7F740D512C7C1046AB53446D3720017304AEC7@scsmsx402.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch] noapic should depend on ioapic config not local
Thread-Index: AcNo2p/2jhQmPEtHSt+WB0BsnWaZdgAJ1OywAAJhBIAAAtg8cA==
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Brown, Len" <len.brown@intel.com>, "Jeff Garzik" <jgarzik@pobox.com>,
       "Ingo Oeser" <ingo.oeser@informatik.tu-chemnitz.de>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 23 Aug 2003 01:45:06.0978 (UTC) FILETIME=[2E153820:01C36918]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actually, it was a typo, "noapci" vs. "noacpi" :-<

"noapic" was recognized there ("noacpi" was not, we need to specify like
"pci=noacpi"), and I/O APIC(s) were correctly ignored (w/ ACPI or w/o
ACPI).

Thanks,
Jun

> -----Original Message-----
> From: Brown, Len
> Sent: Friday, August 22, 2003 6:26 PM
> To: Nakajima, Jun; Jeff Garzik; Ingo Oeser
> Cc: linux-kernel@vger.kernel.org
> Subject: RE: [patch] noapic should depend on ioapic config not local
> 
> Yes, Marcelo pulled the fix for this into 2.4.22 from the acpi tree
this
> morning.
> Let me know if you have any problems with it going forward.
> 
> Thanks,
> -Len
> 
> 
> > -----Original Message-----
> > From: Nakajima, Jun
> > Sent: Friday, August 22, 2003 7:12 PM
> > To: Jeff Garzik; Ingo Oeser
> > Cc: linux-kernel@vger.kernel.org
> > Subject: RE: [patch] noapic should depend on ioapic config not local
> >
> >
> > Looks like it's still ignored there (in BK). We did not realize the
> > problem we worked on ACPI problems. We'll look at the problem.
> >
> > Thanks,
> > Jun
> >
> > > -----Original Message-----
> > > From: Jeff Garzik [mailto:jgarzik@pobox.com]
> > > Sent: Friday, August 22, 2003 8:27 AM
> > > To: Ingo Oeser
> > > Cc: linux-kernel@vger.kernel.org
> > > Subject: Re: [patch] noapic should depend on ioapic config not
local
> > >
> > > On Fri, Aug 22, 2003 at 11:09:20AM +0200, Ingo Oeser wrote:
> > > > On Thu, Aug 21, 2003 at 01:21:40AM -0400, Jeff Garzik wrote:
> > > > > Zwane's comment was correct, it needs to be
CONFIG_X86_IO_APIC.
> > > >
> > > > Does this also apply to 2.4.22-rc2?
> > > >
> > > > I must use noapic on my system and 2.4.22 does ignore it, while
> > > > 2.4.21 doesn't.
> > >
> > > Marcelo just pulled a bunch of ACPI fixes, so I would check
> > the latest
> > > BK, or wait for tonight's BK snapshot.
> > >
> > > So, yes, it does apply to 2.4.22-rc2, but the Intel guys may have
> > taken
> > > care of it already.
> > >
> > > 	Jeff
> > >
> > >
> > >
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe
> > linux-kernel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > Please read the FAQ at  http://www.tux.org/lkml/
> > -
> > To unsubscribe from this list: send the line "unsubscribe
> > linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
> -
> To unsubscribe from this list: send the line "unsubscribe
linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
