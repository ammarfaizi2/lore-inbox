Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262186AbUKWFK3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262186AbUKWFK3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 00:10:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262161AbUKWFG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 00:06:59 -0500
Received: from fmr16.intel.com ([192.55.52.70]:2708 "EHLO
	fmsfmr006.fm.intel.com") by vger.kernel.org with ESMTP
	id S262205AbUKWFFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 00:05:05 -0500
Subject: Re: system slow since ~ 2.6.7
From: Len Brown <len.brown@intel.com>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-kernel@vger.kernel.org,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.60.0411180115490.941@poirot.grange>
References: <Pine.LNX.4.60.0411180115490.941@poirot.grange>
Content-Type: text/plain
Organization: 
Message-Id: <1101186291.20008.247.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 23 Nov 2004 00:04:52 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-11-17 at 19:25, Guennadi Liakhovetski wrote:
> "Slow" means just running top alone in a vt it takes 1.6% CPU. Under
> 2.6.3 it takes 0.2% (Duron 900MHz). Another peculiarity with 2.6.7 and
> 2.6.9 is that the power LED is blinking with about 1Hz frequency. It's
> an ASUS A7VI-VM motherboard. In the manual there's nothing about
> error-codes. I played with various APIC settings - no change. Related
> or not - if running with LAPIC enabled (2.6.7), I get quite a few ERR
> in /proc/interrupts.

PCI: Disabling Via external APIC routing

Curiously, this line appears in 2.6.3, but not in 2.6.7 or 2.6.9 dmesg
-- even though all the configs build in IOAPIC support.

Can you forward the /proc/interrupts from 2.6.3, and from 2.6.9 with and
without acpi=off?  do you see a significant change in /proc/interrupts
before and after the sensor-provoked slowness starts?

if you build 2.6.9 w/o the CONFIG_ACPI_PROCESSOR and boot w/o cmdline
params, do you still see slowness?

if you boot 2.6.9 with these parameters, do you see any additional dmesg
lines?

acpi_dbg_level=0xF acpi_dbg_layer=0xFFFF3FFF


thanks,
-Len


