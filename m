Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261517AbUC0AY5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 19:24:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261516AbUC0AY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 19:24:57 -0500
Received: from fmr06.intel.com ([134.134.136.7]:1243 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S261517AbUC0AYy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 19:24:54 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [ACPI] AE_NOT_ACQUIRED, ACPI: Unable to start the ACPI Interpreter
Date: Fri, 26 Mar 2004 16:24:24 -0800
Message-ID: <37F890616C995246BE76B3E6B2DBE055201D8C@orsmsx403.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [ACPI] AE_NOT_ACQUIRED, ACPI: Unable to start the ACPI Interpreter
Thread-Index: AcQTkX7byywGQMh6SZOtSuO1itWKGQAAEBeA
From: "Moore, Robert" <robert.moore@intel.com>
To: "Brown, Len" <len.brown@intel.com>,
       "Marc-Christian Petersen" <m.c.p@wolk-project.de>, <15444@t-link.de>,
       <gigerstyle@gmx.ch>, <trond.myklebust@fys.uio.no>
Cc: "Marcel Holtmann" <marcel@holtmann.org>,
       "lkml" <linux-kernel@vger.kernel.org>, "Andrew Morton" <akpm@osdl.org>,
       "Linus Torvalds" <torvalds@osdl.org>,
       "Rik van Ballegooijen" <sleightofmind@xs4all.nl>,
       "ACPI Developers" <acpi-devel@lists.sourceforge.net>,
       "Grover, Andrew" <andrew.grover@intel.com>
X-OriginalArrivalTime: 27 Mar 2004 00:24:25.0407 (UTC) FILETIME=[DBEBDCF0:01C41391]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This error has to come from inside this call:

    Status = AcpiOsInstallInterruptHandler ((UINT32)
AcpiGbl_FADT->SciInt,
                        AcpiEvSciXruptHandler,
AcpiGbl_GpeXruptListHead);



-----Original Message-----
From: acpi-devel-admin@lists.sourceforge.net
[mailto:acpi-devel-admin@lists.sourceforge.net] On Behalf Of Brown, Len
Sent: Friday, March 26, 2004 4:20 PM
To: Marc-Christian Petersen; 15444@t-link.de; gigerstyle@gmx.ch;
trond.myklebust@fys.uio.no
Cc: Marcel Holtmann; lkml; Andrew Morton; Linus Torvalds; Rik van
Ballegooijen; ACPI Developers
Subject: [ACPI] AE_NOT_ACQUIRED, ACPI: Unable to start the ACPI
Interpreter

On Fri, 2004-03-26 at 00:26, Len Brown wrote:
> > > ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 22 low level)
> > 
> > > ACPI: SCI (IRQ22) allocation failed
> > >  ACPI-0133: *** Error: Unable to install System Control Interrupt
> > Handler, AE_NOT_ACQUIRED
> > > ACPI: Unable to start the ACPI Interpreter

If you encounter this issue on your hardware, can you help me fix it by
testing the latest patch at the URL below?  Either attach your dmesg and
/proc/interrupts to the bug report or send it to me, and let me know if
your power button works?

thanks,
-Len

> > http://bugzilla.kernel.org/show_bug.cgi?id=2366




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Acpi-devel mailing list
Acpi-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/acpi-devel
