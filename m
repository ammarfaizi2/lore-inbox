Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129421AbRBXPz3>; Sat, 24 Feb 2001 10:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129419AbRBXPzT>; Sat, 24 Feb 2001 10:55:19 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:38930 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S129418AbRBXPzG>; Sat, 24 Feb 2001 10:55:06 -0500
Date: Sat, 24 Feb 2001 09:54:47 -0600
From: Philipp Rumpf <prumpf@mandrakesoft.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jeff Lessem <Jeff.Lessem@Colorado.EDU>, linux-kernel@vger.kernel.org
Subject: Re: PCI oddities on Dell Inspiron 5000e w/ 2.4.x
Message-ID: <20010224095447.A28983@mandrakesoft.mandrakesoft.com>
In-Reply-To: <200102240941.CAA09708@ibg.colorado.edu> <Pine.LNX.4.10.10102240532030.30331-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <Pine.LNX.4.10.10102240532030.30331-100000@penguin.transmeta.com>; from Linus Torvalds on Sat, Feb 24, 2001 at 05:36:47AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 24, 2001 at 05:36:47AM -0800, Linus Torvalds wrote:
> On Sat, 24 Feb 2001, Jeff Lessem wrote:
> > 
> > >Also, how much memory does this machine have? That "13ff0000" does worry
> > >me a bit..
> > 
> > The comptuer has 320MB.  At this point I am ready to conclude that the
> > computer is broken in some way, because nobody else with an Inspiron
> > 5000e that I have heard from has anything like this problem.

> I didn't believe that you'd have 320MB just because it's such an odd
> number, but the problem is that Linux apparently starts allocating the PCI
> address space just _under_ the 320MB mark (you probably have some memory
> reserved for ACPI that doesn't show up in the e820 memory map).

Jeff, are you using the e820 memory map at all ?  In particular, are you
using grub or some other buggy bootloader that insists on specifying a
mem= option on the kernel command line ?  There should be a kernel command
line message very early on, what does that say ?

Also, can you give us the E820 memory map (kernel messages starting with
BIOS-e820) ?
