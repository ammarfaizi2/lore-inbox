Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750900AbWBCIrX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750900AbWBCIrX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 03:47:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750967AbWBCIrX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 03:47:23 -0500
Received: from fmr17.intel.com ([134.134.136.16]:51945 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750893AbWBCIrW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 03:47:22 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH] amd76x_pm: C3 powersaving for AMD K7
Date: Fri, 3 Feb 2006 03:45:59 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3005EFE84D@hdsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] amd76x_pm: C3 powersaving for AMD K7
Thread-Index: AcYokAcFOHR3sb/OQjqjJj1PHgntswACx2Pg
From: "Brown, Len" <len.brown@intel.com>
To: "Joerg Sommrey" <jo@sommrey.de>, "Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
       <tony@atomide.com>, <erik@slagter.name>, <alan@lxorguk.ukuu.org.uk>
X-OriginalArrivalTime: 03 Feb 2006 08:46:02.0868 (UTC) FILETIME=[437A7340:01C6289E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
>... I disagree with Len in two points:
>- I cannot see a problem witch cache snooping.
>  The AMD-768 docs clearly
>  states that trying to snoop the cache while in C3 is a resume event.

Certainly the BIOS writer also had access to that document, plus
documents we do not see, yet they decided NOT to enable C2/C3.

>- Enabling C2/C3 in the BIOS would be a very bad thing IMHO.
>  From all he testing with amd76x_pm I found that is very tricky
>  to go into C2/C3 "the right way".

Who defines the "right way"?  Is it guaranteed to work on all
models and all configurations?  Exactly what is the reward
for the cost we'd be paying and the risk we'd be taking?

>  Simply reading the PM register without a
>  suitable logic around leads to all kinds of instabilities.  You need
>  to implement this logic and then enable the hardware.  The BIOS cannot
>  do this.

How about if we put it this way...
If the ACPI maintainer were an AMD employee,
and he accepted a patch like this specific to Intel hardware --
a patch that rejects whatever validation Intel, the BIOS
vendor and the board vendor have put into the product --
I'd call for his expulsion for ineptitude.

If somebody from AMD steps forth and says that hey, their hardware
is broken if used in the standard way, but that this "logic around"
is a valid model-specific workaround -- then we have something
that MAYBE we can work with.  Otherwise, do whatever works for your
own system, but it would be reckless of us to put stuff like this
in the upstream kernel and then ask distros to support it.

-Len
