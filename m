Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267455AbTBUOhT>; Fri, 21 Feb 2003 09:37:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267456AbTBUOhT>; Fri, 21 Feb 2003 09:37:19 -0500
Received: from meryl.it.uu.se ([130.238.12.42]:48071 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id <S267455AbTBUOhS>;
	Fri, 21 Feb 2003 09:37:18 -0500
From: Mikael Pettersson <mikpe@user.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15958.15349.873243.599197@gargle.gargle.HOWL>
Date: Fri, 21 Feb 2003 15:47:17 +0100
To: Ion Badulescu <ionut@badula.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: UP local APIC is deadly on SMP Athlon
In-Reply-To: <Pine.LNX.4.44.0302202058140.16982-100000@moisil.badula.org>
References: <3E556F00.30201@pobox.com>
	<Pine.LNX.4.44.0302202058140.16982-100000@moisil.badula.org>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ion Badulescu writes:
 > On Thu, 20 Feb 2003, Jeff Garzik wrote:
 > 
 > > Ion Badulescu wrote:
 > > > A UP kernel compiled with CONFIG_X86_LOCAL_APIC=y dies a very horrible
 > > > death on an SMP Athlon motherboard (Tyan S2462 and S2468), flooding the
 > > > console with the following messages:
 > > 
 > > IMO just assume this option is just broken, unless you absolutely need it.
 > 
 > My only boxes on which this is a problem are the SMP athlons, and only 
 > with UP kernels...

Chipset?
Is the second CPU installed or not?
If the second CPU is installed, has it been disabled in BIOS?

Relevant config? What combinations of UP_APIC and UP_IOAPIC have
you been using? Has ACPI been enabled or not?

A plain kernel with UP_APIC but no SMP or UP_IOAPIC shouldn't
provoke the kinds of APIC errors you mentioned, unless the APIC
bus is noisy due to a missing second CPU (just a theory).

 > Anyway, I'd like to get to the bottom of this, since I've narrowed it down 
 > so much. Anyone know who submitted the APIC changes in 2.4.10-pre12?

Ingo Molnar, Maciej W. Rozycki, and myself.

 > debug it myself, but I know next to nothing about the APIC. If you know 
 > where to get some documentation, I'm more than willing to give it a shot.

Intel's IA32 manual set, Volume 3, is required reading.

/Mikael
