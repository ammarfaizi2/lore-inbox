Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267672AbRGPTFG>; Mon, 16 Jul 2001 15:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267673AbRGPTE4>; Mon, 16 Jul 2001 15:04:56 -0400
Received: from mookie.cis.brown.edu ([128.148.177.11]:16009 "EHLO
	mookie.cis.brown.edu") by vger.kernel.org with ESMTP
	id <S267672AbRGPTEn>; Mon, 16 Jul 2001 15:04:43 -0400
Date: Mon, 16 Jul 2001 15:04:47 -0400
From: Dave Johnson <ddj@cascv.brown.edu>
To: linux-kernel@vger.kernel.org
Subject: Unexpected IO-APIC messages
Message-ID: <20010716150447.A13358@mookie.cis.brown.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When booting up 2.4.2-2smp (RH 7.1) on a new system here, the kernel
complains about the IO-APIC register contents, and asks that mail be
sent to linux-smp@vger.kernel.org.

It appears that the linux-smp list is defunct; at least there have been
no new messages archived on geocrawler since August 2000.  It also
appears that the new IO APIC reg01.version of 0x20 was reported about
a year ago on the linux-smp list, and reg_01.__reserved_2 of 0x80 was
reported on this list around February 2001.  

The relevant dmesg info from our machine follows:
----
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 00178020
.......     : max redirection entries: 0017
.......     : IO APIC version: 0020
 WARNING: unexpected IO-APIC, please mail
          to linux-smp@vger.kernel.org
 WARNING: unexpected IO-APIC, please mail
          to linux-smp@vger.kernel.org
.... register #02: 00000000
.......     : arbitration: 00
----

The APIC information from lspci -v follows:
----
03:00.0 PIC: Intel Corporation 82806AA PCI64 Hub Advanced Programmable Interrupt
 Controller (rev 01) (prog-if 20 [IO(X)-APIC])
        Subsystem: Intel Corporation 82806AA PCI64 Hub Advanced Programmable Int
errupt Controller
        Flags: fast devsel
        Memory at fe400000 (32-bit, non-prefetchable) [disabled] [size=4K]
----


If anyone is planning to do anything about new IO-APIC versions and stuff,
at least the mailing list address should be corrected.

If nobody cares until a bug comes along, perhaps the message should be
changed to say "unrecognized" or "unknown" rather than unexpected, so
the d**n users don't pee in their pants when they see the boot log
scrolling by.

Or maybe just parse and print out the values and refer the user to
linux/Documentation/i386/IO-APIC.txt (which also still refers to the
linux-smp mailing list) for further information.

Thanks,


	-- ddj

	Dave Johnson
	ddj@cascv.brown.edu
