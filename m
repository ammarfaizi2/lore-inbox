Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129040AbRBAOHH>; Thu, 1 Feb 2001 09:07:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129377AbRBAOHC>; Thu, 1 Feb 2001 09:07:02 -0500
Received: from [206.11.178.253] ([206.11.178.253]:50957 "EHLO
	wind.enjellic.com") by vger.kernel.org with ESMTP
	id <S129040AbRBAOGn>; Thu, 1 Feb 2001 09:06:43 -0500
Message-Id: <200102011406.f11E6cO30025@wind.enjellic.com>
From: greg@wind.enjellic.com (G.W. Wettstein)
Date: Thu, 1 Feb 2001 08:06:37 -0600
Reply-To: greg@enjellic.com
X-Mailer: Mail User's Shell (7.2.5 10/14/92)
To: linux-kernel@vger.kernel.org
Subject: Multiple hamachi instances.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good day to everyone who isn't in New York at Linux Expo or otherwise
travelling around the world.

We recently upgraded the kernels on our computational cluster.  All of
the machines are Gigabit ethernet attached using the GNIC-II Packet
Engine cards.  The kernel is 2.2.18 patches with Ingo's software raid.
The machines are dual PII-450's with 440BX motherboards, pretty
vanilla setup all in all.

The anomalous behavior we are noting is that the GNIC-II cards are
showing up 7 different times, all with identical statistics.  The
first instance is the configured interface and seems to function
fine.  When the driver is loaded as a module it presents only as a
single instance.  The following excerpt is the from the system probe
at boot time with a statically compiled kernel:

---------------------------------------------------------------------------
Jan 29 12:53:01 heifer01 kernel: Found Hamachi GNIC-II at PCI address 0xfedfb004, IRQ 11.
Jan 29 12:53:01 heifer01 kernel: eth1: Hamachi GNIC-II type 10911 at 0xe0802000, 00:e0:b1:04:19:b3, IRQ 11.
Jan 29 12:53:01 heifer01 kernel: eth1:  32-bit 33 Mhz PCI bus (60), Virtual Jumpers 30, LPA 0000.
Jan 29 12:53:01 heifer01 kernel: Found Hamachi GNIC-II at PCI address 0xfedfb004, IRQ 11.
Jan 29 12:53:01 heifer01 kernel: eth2: Hamachi GNIC-II type 10911 at 0xe0804000, 00:e0:b1:04:19:b3, IRQ 11.
Jan 29 12:53:01 heifer01 kernel: eth2:  32-bit 33 Mhz PCI bus (60), Virtual Jumpers 30, LPA 0000.
Jan 29 12:53:01 heifer01 kernel: Found Hamachi GNIC-II at PCI address 0xfedfb004, IRQ 11.
Jan 29 12:53:01 heifer01 kernel: eth3: Hamachi GNIC-II type 10911 at 0xe0806000, 00:e0:b1:04:19:b3, IRQ 11.
Jan 29 12:53:01 heifer01 kernel: eth3:  32-bit 33 Mhz PCI bus (60), Virtual Jumpers 30, LPA 0000.
Jan 29 12:53:01 heifer01 kernel: Found Hamachi GNIC-II at PCI address 0xfedfb004, IRQ 11.
Jan 29 12:53:01 heifer01 kernel: eth4: Hamachi GNIC-II type 10911 at 0xe0808000, 00:e0:b1:04:19:b3, IRQ 11.
Jan 29 12:53:01 heifer01 kernel: eth4:  32-bit 33 Mhz PCI bus (60), Virtual Jumpers 30, LPA 0000.
Jan 29 12:53:01 heifer01 kernel: Found Hamachi GNIC-II at PCI address 0xfedfb004, IRQ 11.
Jan 29 12:53:01 heifer01 kernel: eth5: Hamachi GNIC-II type 10911 at 0xe080a000, 00:e0:b1:04:19:b3, IRQ 11.
Jan 29 12:53:01 heifer01 kernel: eth5:  32-bit 33 Mhz PCI bus (60), Virtual Jumpers 30, LPA 0000.
Jan 29 12:53:01 heifer01 kernel: Found Hamachi GNIC-II at PCI address 0xfedfb004, IRQ 11.
Jan 29 12:53:01 heifer01 kernel: eth6: Hamachi GNIC-II type 10911 at 0xe080c000, 00:e0:b1:04:19:b3, IRQ 11.
Jan 29 12:53:01 heifer01 kernel: eth6:  32-bit 33 Mhz PCI bus (60), Virtual Jumpers 30, LPA 0000.
Jan 29 12:53:01 heifer01 kernel: Found Hamachi GNIC-II at PCI address 0xfedfb004, IRQ 11.
Jan 29 12:53:01 heifer01 kernel: eth7: Hamachi GNIC-II type 10911 at 0xe080e000, 00:e0:b1:04:19:b3, IRQ 11.
Jan 29 12:53:01 heifer01 kernel: eth7:  32-bit 33 Mhz PCI bus (60), Virtual Jumpers 30, LPA 0000.
---------------------------------------------------------------------------

Any thoughts?

Have a pleasant end of the week.

As always,
Dr. G.W. Wettstein, Ph.D.   Enjellic Systems Development, LLC.
4206 N. 19th Ave.           Specializing in information infra-structure
Fargo, ND  58102            development.
PH: 701-281-4950            WWW: http://www.enjellic.com
FAX: 701-281-3949           EMAIL: greg@enjellic.com
------------------------------------------------------------------------------
"One of the reporters asked if the could "see" the INTERNET worm.
They tried to explain that it wasn't something that you could actually
see but is was merely a program that was running in the background.
One of the reporters asked, 'What if you had a color monitor?'"
                                -- UNKNOWN
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
