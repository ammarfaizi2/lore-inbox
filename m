Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264842AbTFQQ4P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 12:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264847AbTFQQ4P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 12:56:15 -0400
Received: from fmr05.intel.com ([134.134.136.6]:7636 "EHLO hermes.jf.intel.com")
	by vger.kernel.org with ESMTP id S264842AbTFQQ4N convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 12:56:13 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: ACPI broken... again!
Date: Tue, 17 Jun 2003 10:10:06 -0700
Message-ID: <F760B14C9561B941B89469F59BA3A84725A2F1@orsmsx401.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: ACPI broken... again!
Thread-Index: AcM03zgCBZ0OqxLBSqWpvXAIkwivggADywow
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "Felix von Leitner" <felix-kernel@fefe.de>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 17 Jun 2003 17:10:07.0464 (UTC) FILETIME=[4D460E80:01C334F3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Felix von Leitner [mailto:felix-kernel@fefe.de] 
> Linux 2.5.70 and above have broken ACPI.  Again.  This is my fifth
> machine on which I try ACPI, two notebooks and three 
> desktops, chipsets
> from Intel, VIA and SiS, no matter, ACPI still breaks 'em all.

"Again." Are you saying it used to work on these machines and then it
stopped? If so I think we have a fix to try in the next ACPI release
(which may or may not make it into the next kernel release.)

> The symptom is that eth0 does not see the others.  
> /proc/interrupts has
> the correct interrupt listed, so it took me a while to suspect ACPI.
> agpgart also crashes, and firewire and USB didn't find any devices.
> 
> Why oh why is ACPI so horrendously broken?

Do I hear violins playing? Poor, poor you! :)

The ACPI PCI routing code still isn't 100% correct. Have you tried
pci=noacpi? Have you diagnosed exactly what is going wrong on your
system? Have you checked bugzilla for similar bugs? Have you sent a
patch fixing the problem on your system?

> And more to the point: if it _is_ this broken, why ship it at all?  I
> don't recall a single moment where ACPI did anything good for me, only
> crashes, data loss and general brokenness.  This may be a technology
> fitting Microsoft and Intel PCs, but why give it even more leverage by
> supporting it in Linux?  I say rip this abomination right out of the
> kernel and be done with it.

So don't compile it in for now. When you buy a system in a few years
that won't work properly without ACPI, and it *works* because of the
work everyone on acpi-devel is doing, then you'll change your tune.

Regards -- Andy
