Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279750AbRJYKUr>; Thu, 25 Oct 2001 06:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279756AbRJYKUh>; Thu, 25 Oct 2001 06:20:37 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:7383 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S279750AbRJYKUZ>;
	Thu, 25 Oct 2001 06:20:25 -0400
Date: Thu, 25 Oct 2001 12:20:58 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200110251020.MAA13431@harpo.it.uu.se>
To: R.E.Wolff@BitWizard.nl
Subject: Re: APIC and "ISA" interrupts.
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Oct 2001 23:32:45 +0200 (MEST), Rogier Wolff wrote:
>After upgrading our fileserver to 2.4, I can't seem to get the ISDN
>card to work. I think that's because the kernel is using the APIC to
>route interrupts, such that my BIOS configuration "used-by-Legacy-ISA" 
>is no longer in effect. 
>
>I tried disabling the APIC with the following results: 
>
>Local APIC disabled by BIOS -- reenabling.
>Found and enabled local APIC!
>Kernel command line: auto BOOT_IMAGE=linux ro root=302 BOOT_FILE=/boot/vmlinuz disableapic
>
>as far as I can see, the code to print "local apci disabled by bios"
>is not called if "disableapic" is on the commandline.
>
>This is linux-2.4.10 that I got with SuSE 7.3

"disableapic" is not in 2.4.13 vanilla. Some SuSE hack?
Anyway, try "noapic" instead. That should disable the kernel's use of
the IO-APIC. The local APIC is a completely different beast, and it is
unlikely to have anything to do with your interrupt routing problems.

Failing that, recompile with CONFIG_X86_UP_IOAPIC=n and CONFIG_SMP=n.

/Mikael
(. local APIC on UP caretaker .)
