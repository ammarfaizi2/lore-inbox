Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750743AbWKAWRU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbWKAWRU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 17:17:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbWKAWRU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 17:17:20 -0500
Received: from rs02.intra2net.com ([81.169.173.116]:21518 "EHLO
	rs02.intra2net.com") by vger.kernel.org with ESMTP id S1750743AbWKAWRT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 17:17:19 -0500
From: "Gerd v. Egidy" <lists@egidy.de>
To: Andi Kleen <ak@suse.de>
Subject: Re: lspci output needed was Re: Frustrated with Linux, Asus, and nVidia, and AMD
Date: Wed, 1 Nov 2006 23:17:13 +0100
User-Agent: KMail/1.9.5
Cc: Robert Hancock <hancockr@shaw.ca>, Bill Davidsen <davidsen@tmr.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <fa.nWSYbiDM13Z4b2OlxoSzmqud/lI@ifi.uio.no> <454432DC.9030006@shaw.ca> <200610311528.20013.ak@suse.de>
In-Reply-To: <200610311528.20013.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611012317.13963.lists@egidy.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Can people who use a Nvidia based AM2/SocketF board (especially when they
> have timer troubles but otherwise would be useful too) please report their
> lspcis in private mail to me?

I'll send the lspci in private as requested in a minute.

I have a ASUS M2N-SLI Deluxe (nForce 570) with a Athlon64 X2 4600+ (AM2) and 
Bios version 0307 or 0402 beta. The problem with this board seems to be a 
little different than the problem the others posting here are experiencing. 
Maybe it's a different bug but it seems to be timer-related too.

Booting 2.6.18.1 (or some other 2.6er I tried) stops with

[...]
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=0 apci2=-1 pin2=-1
..MP-BIOS bug: 8254 timer not connected to IO-APIC
....trying to set up timer (IRQ0) through the 8259A ...  failed.
....trying to set up timer as Virtual Wire IRQ... failed.
....trying to set up timer as ExtINT IRQ... failed :(.
Kernel panic - not syncing: IO-APIC + timer doesn't work! Boot with apic=debug
and send a report.  Then try booting with the 'noapic' option

All kernels were SMP and i386 (not x86_64).

I tried to use the acpi_skip_timer_override=0 patch that helped the other 
posters but it did not help - same error. Of course I patched the 
corresponding code for i386 in arch/i386/kernel/acpi/earlyquirk.c. Booting 
with the no_timer_check boot parameter as some people suggested does not help 
too.

Booting with apic=debug does not reveal any additional info. Only booting with 
noapic makes the machine boot.

Kind regards,

Gerd
