Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265801AbRGPUQP>; Mon, 16 Jul 2001 16:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267585AbRGPUQG>; Mon, 16 Jul 2001 16:16:06 -0400
Received: from archive.osdlab.org ([65.201.151.11]:34184 "EHLO fire.osdlab.org")
	by vger.kernel.org with ESMTP id <S265801AbRGPUPz>;
	Mon, 16 Jul 2001 16:15:55 -0400
Message-ID: <3B534B36.3A69DBF@osdlab.org>
Date: Mon, 16 Jul 2001 13:14:46 -0700
From: "Randy.Dunlap" <rddunlap@osdlab.org>
Organization: OSDL
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-20mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Johnson <ddj@cascv.brown.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: Unexpected IO-APIC messages
In-Reply-To: <20010716150447.A13358@mookie.cis.brown.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi-

The linux-smp mailing list is still alive (I won't say Active,
although some emails there do get replies).

The geocrawler archive isn't a good one to check.
Try this one instead:
http://marc.theaimsgroup.com/?l=linux-smp

You are right about the noisy message(s).  The newer
IO APICs aren't in the kernel's known devices list yet.
There was a patch submitted about 2 months ago for this.
It hasn't been added to the kernel tree yet, but it
does need to be added IMO.

~Randy

Dave Johnson wrote:
> 
> When booting up 2.4.2-2smp (RH 7.1) on a new system here, the kernel
> complains about the IO-APIC register contents, and asks that mail be
> sent to linux-smp@vger.kernel.org.
> 
> It appears that the linux-smp list is defunct; at least there have been
> no new messages archived on geocrawler since August 2000.  It also
> appears that the new IO APIC reg01.version of 0x20 was reported about
> a year ago on the linux-smp list, and reg_01.__reserved_2 of 0x80 was
> reported on this list around February 2001.
> 
> The relevant dmesg info from our machine follows:
> ----
> testing the IO APIC.......................
> 
> IO APIC #2......
> .... register #00: 02000000
> .......    : physical APIC id: 02
> .... register #01: 00178020
> .......     : max redirection entries: 0017
> .......     : IO APIC version: 0020
>  WARNING: unexpected IO-APIC, please mail
>           to linux-smp@vger.kernel.org
>  WARNING: unexpected IO-APIC, please mail
>           to linux-smp@vger.kernel.org
> .... register #02: 00000000
> .......     : arbitration: 00
> ----
> 
> The APIC information from lspci -v follows:
> ----
> 03:00.0 PIC: Intel Corporation 82806AA PCI64 Hub Advanced Programmable Interrupt
>  Controller (rev 01) (prog-if 20 [IO(X)-APIC])
>         Subsystem: Intel Corporation 82806AA PCI64 Hub Advanced Programmable Int
> errupt Controller
>         Flags: fast devsel
>         Memory at fe400000 (32-bit, non-prefetchable) [disabled] [size=4K]
> ----
> 
> If anyone is planning to do anything about new IO-APIC versions and stuff,
> at least the mailing list address should be corrected.
> 
> If nobody cares until a bug comes along, perhaps the message should be
> changed to say "unrecognized" or "unknown" rather than unexpected, so
> the d**n users don't pee in their pants when they see the boot log
> scrolling by.
> 
> Or maybe just parse and print out the values and refer the user to
> linux/Documentation/i386/IO-APIC.txt (which also still refers to the
> linux-smp mailing list) for further information.
