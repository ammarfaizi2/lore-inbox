Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261787AbSJEBIy>; Fri, 4 Oct 2002 21:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261790AbSJEBIy>; Fri, 4 Oct 2002 21:08:54 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:16560 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261787AbSJEBIw>;
	Fri, 4 Oct 2002 21:08:52 -0400
Date: Fri, 4 Oct 2002 21:14:25 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: oops in bk pull (oct 03)
In-Reply-To: <Pine.LNX.4.44.0210041755310.2993-100000@home.transmeta.com>
Message-ID: <Pine.GSO.4.21.0210042103340.21250-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 4 Oct 2002, Linus Torvalds wrote:

> 
> On Fri, 4 Oct 2002, Alexander Viro wrote:
> > 
> > Hell knows.  The only explanation I see (and that's not worth much) is that
> > we somehow confuse the chipset and get crapped on something like next cache
> > miss.
> 
> I don't see any better explanation right now, so I guess we just revert 
> that thing.
> 
> The only other notion I might come up with is stack corruption, ie the
> code in pci_read_bases() might corrupt the return stack subtly (it does
> add another local variable whose address is taken), causing a jump to a
> random address on return. Compiler bug?

I doubt it.  I've read through the objdump output and code looks OK.
Diff between old and new _definitely_ looks sane.  FWIW, chipset is
Via 686A, gcc is from debian-stable (2.95.4-11woody1).  I'll try to
find some RH box and build with the same .config, but I would be
surprised if it changes anything.

