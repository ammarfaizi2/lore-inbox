Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129319AbRBXNhT>; Sat, 24 Feb 2001 08:37:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129326AbRBXNhJ>; Sat, 24 Feb 2001 08:37:09 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:16393 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129319AbRBXNgy>; Sat, 24 Feb 2001 08:36:54 -0500
Date: Sat, 24 Feb 2001 05:36:47 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeff Lessem <Jeff.Lessem@Colorado.EDU>
cc: linux-kernel@vger.kernel.org
Subject: Re: PCI oddities on Dell Inspiron 5000e w/ 2.4.x 
In-Reply-To: <200102240941.CAA09708@ibg.colorado.edu>
Message-ID: <Pine.LNX.4.10.10102240532030.30331-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 24 Feb 2001, Jeff Lessem wrote:
> 
> >Also, how much memory does this machine have? That "13ff0000" does worry
> >me a bit..
> 
> The comptuer has 320MB.  At this point I am ready to conclude that the
> computer is broken in some way, because nobody else with an Inspiron
> 5000e that I have heard from has anything like this problem.

The machine isn't broken. It's Linux.

I didn't believe that you'd have 320MB just because it's such an odd
number, but the problem is that Linux apparently starts allocating the PCI
address space just _under_ the 320MB mark (you probably have some memory
reserved for ACPI that doesn't show up in the e820 memory map).

The PCI allocation needs to be fixed, but I'm off for two days in
Finland..

		Linus

