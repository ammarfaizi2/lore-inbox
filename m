Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267966AbTAKSj6>; Sat, 11 Jan 2003 13:39:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267972AbTAKSj6>; Sat, 11 Jan 2003 13:39:58 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:518 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267966AbTAKSj5>; Sat, 11 Jan 2003 13:39:57 -0500
Date: Sat, 11 Jan 2003 10:43:50 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Christoph Hellwig <hch@infradead.org>
cc: davidm@hpl.hp.com, <linux-kernel@vger.kernel.org>
Subject: Re: make AT_SYSINFO platform-independent
In-Reply-To: <20030111110717.A24094@infradead.org>
Message-ID: <Pine.LNX.4.44.0301111042120.10073-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 11 Jan 2003, Christoph Hellwig wrote:
>
> On Fri, Jan 10, 2003 at 10:45:26PM -0800, David Mosberger wrote:
> > How about moving the AT_SYSINFO macro from asm-i386/elf.h to
> > linux/elf.h?  Several architectures can benefit from it (certainly
> > pa-risc and ia64) and since glibc also defines it in a
> > non-platformspecific fashion, there really is no point not doing the
> > same in the kernel.  I suppose it would be nice if we could renumber
> > it from 32 to 18, but that would require updating glibc, which is
> > probably too painful.
> 
> I think it should be updated.  There is no released glibc or stable kernel
> with that number yet.

Sounds like an uncommonly bad idea to me, since the range 19-22 is already 
used at least by PPC.

Yeah, 18 itself may be free (although I wonder _why_? Maybe it's some old 
value that is no longer used by the kernel but old binaries may know 
about?) but the fact is that there just isn't room in the low numbers, 
which was why I put it up higher.

		Linus

