Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271351AbTHMDIi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 23:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271355AbTHMDIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 23:08:38 -0400
Received: from fmr05.intel.com ([134.134.136.6]:63683 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S271351AbTHMDI0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 23:08:26 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: [ACPI] device states supported by current drivers
Date: Wed, 13 Aug 2003 11:07:35 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F8401720AD6@pdsmsx403.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [ACPI] device states supported by current drivers
Thread-Index: AcNhKDIUvxqblm+XSB6EBPly0UG6twAHpDtA
From: "Yu, Luming" <luming.yu@intel.com>
To: "Pavel Machek" <pavel@ucw.cz>, "Bharata B Rao" <rao.bharata@samsung.com>
Cc: "Knut Neumann" <knut.neumann@uni-duesseldorf.de>,
       <acpi-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 13 Aug 2003 03:08:19.0382 (UTC) FILETIME=[25A81D60:01C36148]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think device states will not be supported in 2.4 kernel, And It could be found in 2.6 kernel. 
Who know the current status? 
Thanks,
Luming

-----Original Message-----
From: Pavel Machek [mailto:pavel@ucw.cz]
Sent: 2003?8?13? 6:58
To: Bharata B Rao
Cc: Knut Neumann; acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] device states supported by current drivers


Hi!

> >Am Mo, 2003-08-11 um 03.28 schrieb Bharata B Rao:
> >>
> >>Are there any device drivers in 2.4/2.6 kernels which actually support 
> >>different low power states as defined by ACPI ? The reason I ask is I 
> >>can't really see any device actually implementing the new driver model 
> >>suspend routine which is used by ACPI.
> >
> >
> >What about the e100 driver? See drivers/net/e100/e100_main.c
> >
> 
> Ok, I can see that now. Thanks.
> 
> Two more dumb questions (sorry for asking them here in devel list)
> 
> 1. When a particular sleep state (S1 - S5) is entered via 
> /proc/acpi/sleep, the devices are put to one of the D states (D0 - D3)
> From the code (device_suspend, e100_suspend, pci_set_power_state), it 
> looks like the sleep states (Sx) are directly translated to device 
> states (Dx) when it comes to device suspend. i,e., when I say enter S2, 
> it will lead to device entering to D2. Is this how it should be ?

I believe suspend() function parameters are expected to tell you *S*
state we are entering. I do not see code that enables drivers to enter
D0 vs. D1 vs. D2 vs D3. I guess it is not there.

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
_______________________________________________
Acpi-devel mailing list
Acpi-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/acpi-devel
