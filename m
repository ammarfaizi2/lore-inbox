Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279968AbRJaKiZ>; Wed, 31 Oct 2001 05:38:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278842AbRJaKiG>; Wed, 31 Oct 2001 05:38:06 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:31757 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S279961AbRJaKh7>; Wed, 31 Oct 2001 05:37:59 -0500
Subject: Re: Local APIC option (CONFIG_X86_UP_APIC) locks up Inspiron 8100
To: stevie@qrpff.net (Stevie O)
Date: Wed, 31 Oct 2001 10:44:54 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <5.1.0.14.2.20011030235723.022818d8@whisper.qrpff.net> from "Stevie O" at Oct 31, 2001 12:06:57 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15ysre-0003FD-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 2) Anytime I change the plugged-in status of the AC adapter (if it wasn't 
> plugged in, if I plug it in; if it was plugged in, if I unplug it), the 
> machine locks up completely.

Not all BIOS firmware can cope when we switch to UP-APIC. Some laptops 
really don't like it one bit.

> One other thing: how would the kernel react to the "SpeedStep" feature of 
> changing the CPU speed while things are still running?

Depends on the laptop. Speedstop is not documented by intel so either it
works because the APM bios did the right thing, or it doesn't work because
it didn't. The only kernel issue is delay loops. We calibrate them at boot
and assume the base clock is constant. In practice this isnt showing up as
a real problem, although we do need to switch to the ACPI timers on later
laptops
