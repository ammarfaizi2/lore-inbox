Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261166AbVDBSUW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261166AbVDBSUW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 13:20:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261162AbVDBSUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 13:20:22 -0500
Received: from hammer.engin.umich.edu ([141.213.40.79]:37353 "EHLO
	hammer.engin.umich.edu") by vger.kernel.org with ESMTP
	id S261244AbVDBSTt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 13:19:49 -0500
Date: Sat, 2 Apr 2005 13:19:44 -0500 (EST)
From: Christopher Allen Wing <wingc@engin.umich.edu>
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: linux-kernel@vger.kernel.org
Subject: Re: clock runs at double speed on x86_64 system w/ATI RS200 chipset
In-Reply-To: <200504021105.j32B5eN2018794@harpo.it.uu.se>
Message-ID: <Pine.LNX.4.58.0504021246550.13028@hammer.engin.umich.edu>
References: <200504021105.j32B5eN2018794@harpo.it.uu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 2 Apr 2005, Mikael Pettersson wrote:

> >	APIC error on CPU0: 00(40)
> >	APIC error on CPU0: 40(40)
>
> Those are "received illegal vector" errors, and they
> typically indicate hardware flakiness or BIOS issues.
>
> Could be inadequate power supply, inadequate cooling,
> a BIOS bug (please check for updates), a too new CPU
> (again, check for a BIOS update), or simply a poorly-
> designed mainboard.


Thanks. I tried the latest BIOS for the board but that did not resolve the
problem. The clock still runs at double speed (2000 timer
interrupts/second instead of 1000) and I still get the APIC errors.

I'll enter a support request with the manufacturer.



I was able to get the problem to go away by using a BIOS option to
"disable APIC mode". When I do this the kernel outputs at boot:

	ACPI: Using PIC for interrupt routing

and the output of /proc/interrupts reads 'XT-PIC' for everything.


If anyone has a suggestion for debugging the clock problem in APIC mode
I'd be interested. I'm guessing that something is causing the timer
interrupt to be mapped twice- are there any tools for looking at the ACPI
tables that may help, or are there kernel boot options to give more detail
about how the interrupt routing is being set up?


Thanks,

Chris Wing
wingc@engin.umich.edu
