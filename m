Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277014AbRJDTkN>; Thu, 4 Oct 2001 15:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277215AbRJDTkD>; Thu, 4 Oct 2001 15:40:03 -0400
Received: from [209.237.5.66] ([209.237.5.66]:9933 "EHLO clyde.stargateip.com")
	by vger.kernel.org with ESMTP id <S276984AbRJDTjo>;
	Thu, 4 Oct 2001 15:39:44 -0400
From: "Ian Thompson" <ithompso@stargateip.com>
To: "Helge Hafting" <helgehaf@idb.hist.no>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: How can I jump to non-linux address space?
Date: Thu, 4 Oct 2001 12:40:01 -0700
Message-ID: <NFBBIBIEHMPDJNKCIKOBEEIACAAA.ithompso@stargateip.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <3BBC2603.7C1327AC@idb.hist.no>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge,

Thanks for your advice!  It's brought up a couple of other question, if you
don't mind:

> The kernel can get to know - all you need is code that maps the
> ROM address range into some available virtual address range.
> Look at device driver code - they do such mapping for ROM and/or
> memory-based io regions.

I've seen the mapping of the single RAM address range, but I don't see where
it is possible to add in another range for ROM.  What functions should I
look for that do this mapping?

> Do that ROM code work when the MMU has remapped its adresses so it
> appears at some adress completely different from the bus address?  (only
> if it contains relative jumps only - no absolute addresses.) Does
> it work with 4G segments?  Does it work at all in protected mode,
> with all interrupts routed to the linux kernel instead of the bios?
> Does this code expect to find something (data, device interfaces,
> vga memory) at certain addresses?  If so, this must be mapped too.

I've run this code (in ROM) successfully before starting the kernel.  I
believe the cache is disabled, and interrupts are not needed (and are off).
The code does not refer to anything within the kernel.  I've tried turning
off the MMU completely before branching, but this seems to hang the system.
=(

Any ideas of what I should look for to turn off, aside from just shutting
down the MMU?  If I map the ROM address range into a virtual addr range,
won't I run into problems once I'm running the code, such as physical
addresses being interpreted by virtual ones?

btw, this is running on an XScale (strongARM).

Thanks again,
-ian

