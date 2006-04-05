Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750945AbWDEARt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbWDEARt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 20:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751024AbWDEARt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 20:17:49 -0400
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:38296 "EHLO
	adelphi.physics.adelaide.edu.au") by vger.kernel.org with ESMTP
	id S1750945AbWDEARs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 20:17:48 -0400
From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Message-Id: <200604050021.k350LnVF029703@auster.physics.adelaide.edu.au>
Subject: Re: 2.6.16-rt11: Hires timer makes sleep wait far too long
To: tglx@linutronix.de
Date: Wed, 5 Apr 2006 09:51:49 +0930 (CST)
Cc: jwoithe@physics.adelaide.edu.au (Jonathan Woithe),
       linux-kernel@vger.kernel.org
In-Reply-To: <1144124783.5344.396.camel@localhost.localdomain> from "Thomas Gleixner" at Apr 04, 2006 06:26:22 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas

> On Tue, 2006-04-04 at 13:10 +0930, Jonathan Woithe wrote:
> > The actual amount of time waited by a "sleep 1" call from bash was tested
> > at least twice for each timer source:
> > 
> >   pit: 12 seconds, 29 seconds, 28 seconds
> >   tsc: 45 seconds, 45 seconds
> >   acpi_pm: 45 seconds, 29 seconds
> >   jiffies: 45 seconds, 32 seconds
> 
> Hmm, can you please send me your .config and the bootlog of the
> machine ?

Because of the size of the files I've posted this privately.  The following
are extracts from the files in case others are interested.

Selected boot messages with hr-timers enabled:
  ACPI: PM-Timer IO Port: 0x1008
  ACPI: Local APIC address 0xfee00000
  ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
  Processor #0 6:13 APIC version 20
  :
  Detected 1995.072 MHz processor.
  Real-Time Preemption Support (C) 2004-2006 Ingo Molnar
  :
  CPU: Intel(R) Pentium(R) M processor 2.00GHz stepping 08
  :
  ENABLING IO-APIC IRQs
  ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
  Event source pit new caps set: 05
  Event source lapic installed with caps set: 02
  :
  Time: tsc clocksource has been installed.
  hrtimers: Switched to high resolution mode CPU 0
  :
  Time: acpi_pm clocksource has been installed.
  hrtimers: Switched to high resolution mode CPU 0

Config options related to timers:
  CONFIG_HPET_TIMER=y
  CONFIG_HPET_EMULATE_RTC=y
  CONFIG_HIGH_RES_TIMERS=y
  CONFIG_HIGH_RES_RESOLUTION=10000
  :
  CONFIG_X86_PM_TIMER=y

Regards
  jonathan
