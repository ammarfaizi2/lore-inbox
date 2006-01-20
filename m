Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161391AbWATFj4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161391AbWATFj4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 00:39:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161503AbWATFj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 00:39:56 -0500
Received: from fmr13.intel.com ([192.55.52.67]:229 "EHLO
	fmsfmr001.fm.intel.com") by vger.kernel.org with ESMTP
	id S1161391AbWATFj4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 00:39:56 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: 2.6.16-rc1-mm1 usb hub problems
Date: Fri, 20 Jan 2006 00:39:37 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3005C6CEE4@hdsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.16-rc1-mm1 usb hub problems
Thread-Index: AcYcgGsqgyBMwMBdQ2a8ncpiwMpu2ABAlqMg
From: "Brown, Len" <len.brown@intel.com>
To: "Pavel Machek" <pavel@ucw.cz>, "Andrew Morton" <akpm@osdl.org>
Cc: <greg@kroah.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 20 Jan 2006 05:39:45.0157 (UTC) FILETIME=[EB429B50:01C61D83]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>--- /tmp/rc1.mesg	2006-01-18 23:24:01.000000000 +0100
>+++ /tmp/rc1-mm1.mesg	2006-01-18 23:32:24.000000000 +0100
>@@ -1,4 +1,4 @@
>-Linux version 2.6.15-dirty (pavel@amd) (gcc version 4.0.3 
>20051201 (prerelease) (Debian 4.0.2-5)) #190 SMP PREEMPT Mon 
>Jan 16 13:48:34 CET 2006
>+Linux version 2.6.16-rc1-mm1 (pavel@amd) (gcc version 4.0.3 
>20051201 (prerelease) (Debian 4.0.2-5)) #6 Wed Jan 18 20:48:34 CET 2006

>-68 Devices found containing: 68 _STA, 11 _INI methods
>+68 Devices found containing: 3 _STA, 11 _INI methods

Expected and unrelated.  They're not missing, now we're
a little smarter about not brute-force looking for methods
that we can tell by context are not there.

> ACPI: Interpreter enabled
> ACPI: Using PIC for interrupt routing
> ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11)
>@@ -93,11 +88,13 @@
> PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
> Boot video device is 0000:01:00.0
> PCI: Transparent bridge - 0000:00:1e.0

This is new:

>+PCI: Found IBM Dock II Cardbus Bridge applying quirk
>+PCI: Found IBM Dock II Cardbus Bridge applying quirk

cheers,
-Len
