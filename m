Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261650AbUKWXlm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261650AbUKWXlm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 18:41:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbUKWXiw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 18:38:52 -0500
Received: from pop.gmx.net ([213.165.64.20]:54667 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261631AbUKWXgO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 18:36:14 -0500
X-Authenticated: #20450766
Date: Wed, 24 Nov 2004 00:35:25 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Len Brown <len.brown@intel.com>
cc: linux-kernel@vger.kernel.org,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
Subject: Re: system slow since ~ 2.6.7
In-Reply-To: <1101186291.20008.247.camel@d845pe>
Message-ID: <Pine.LNX.4.60.0411240026360.6361@poirot.grange>
References: <Pine.LNX.4.60.0411180115490.941@poirot.grange>
 <1101186291.20008.247.camel@d845pe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the reply

On Tue, 23 Nov 2004, Len Brown wrote:

> On Wed, 2004-11-17 at 19:25, Guennadi Liakhovetski wrote:
> > "Slow" means just running top alone in a vt it takes 1.6% CPU. Under
> > 2.6.3 it takes 0.2% (Duron 900MHz). Another peculiarity with 2.6.7 and
> > 2.6.9 is that the power LED is blinking with about 1Hz frequency. It's
> > an ASUS A7VI-VM motherboard. In the manual there's nothing about
> > error-codes. I played with various APIC settings - no change. Related
> > or not - if running with LAPIC enabled (2.6.7), I get quite a few ERR
> > in /proc/interrupts.
> 
> PCI: Disabling Via external APIC routing
> 
> Curiously, this line appears in 2.6.3, but not in 2.6.7 or 2.6.9 dmesg
> -- even though all the configs build in IOAPIC support.

Well, I think, there's just a local APIC on the system, and that is 
disabled in BIOS (there's no way to enable it). 2.6.3 disables VIA 
external APIC routing, as you noticed, whereas 2.6.7 sais 

Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!

2.6.9 respects BIOS decision (I think, there was a thread on LKML on 
this?):

No local APIC present or hardware disabled

> Can you forward the /proc/interrupts from 2.6.3, and from 2.6.9 with and
> without acpi=off?  do you see a significant change in /proc/interrupts
> before and after the sensor-provoked slowness starts?
> 
> if you build 2.6.9 w/o the CONFIG_ACPI_PROCESSOR and boot w/o cmdline
> params, do you still see slowness?
> 
> if you boot 2.6.9 with these parameters, do you see any additional dmesg
> lines?
> 
> acpi_dbg_level=0xF acpi_dbg_layer=0xFFFF3FFF

I'll try to do all this tomorrow and report results.

Thanks
Guennadi
---
Guennadi Liakhovetski

