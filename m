Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262723AbRE3K4t>; Wed, 30 May 2001 06:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262724AbRE3K4j>; Wed, 30 May 2001 06:56:39 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:61831 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S262723AbRE3K4a>;
	Wed, 30 May 2001 06:56:30 -0400
Date: Wed, 30 May 2001 12:56:28 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200105301056.MAA07359@harpo.it.uu.se>
To: linux-kernel@vger.kernel.org, shag-linux-kernel@booyaka.com
Subject: Re: Hard lockup debugging suggestions?  APIC enabling suggestions?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 May 2001 18:22:57 -0500 (CDT), Paul Walmsley wrote:

>I have an 700Mhz Pentium III HP Omnibook 6000 that has been locking up
>...
>In the hopes of getting an oops from the NMI watchdog, I attempted to
>enable the NMI watchdog with both 'nmi_watchdog=1' and 'nmi_watchdog=2'.
>Neither seems to work.  (Support for APIC and IO-APIC is compiled into the
>kernel, although /proc/interrupts reveals that all interrupts are still
>being routed through the XT-PIC)
>
>It would seem that Linux is having trouble enabling the CPU's local APIC.
>>From the boot messages:
>
>	Local APIC disabled by BIOS -- reenabling.
>	Could not enable APIC!

Unfortunately Intel removed the local APIC from their Mobile P6 range,
so you won't be able to use the NMI watchdog on your Omnibook.
This is actually documented (for the Mobile PII at least) in some
obscure place, probably in the spec update.

Oh, and remove IO_APIC support too. Your machine doesn't have one.

/Mikael
