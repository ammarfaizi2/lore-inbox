Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281587AbRKVTrv>; Thu, 22 Nov 2001 14:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281578AbRKVTrk>; Thu, 22 Nov 2001 14:47:40 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:61843
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S281560AbRKVTrZ>; Thu, 22 Nov 2001 14:47:25 -0500
Date: Thu, 22 Nov 2001 12:46:52 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Anuradha Ratnaweera <anuradha@gnu.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.15-pre9
Message-ID: <20011122124652.Z3436@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <Pine.LNX.4.33.0111221046170.1479-100000@penguin.transmeta.com> <Pine.GSO.4.21.0111221422040.29272-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0111221422040.29272-100000@weyl.math.psu.edu>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2001 at 02:34:46PM -0500, Alexander Viro wrote:
> 
> 
> On Thu, 22 Nov 2001, Linus Torvalds wrote:
> 
> > Quite frankly, right now I'm in "handle only bugs that can crash the
> > system mode". Anything that takes 497 days to see is fairly low on my
> > priority list. My highest priority, in fact, is to get 2.4.15 out without
> > any embarrassment.
> 
> Umm...
> 	a) /proc/interrupts has buffer overflows.
> 	b) I have a patch that should fix them (conversion to seq_file,
> done for all architectures)
> 	c) while completely straightforward, it's large (every subarchitecture
> of m68k and mips seems to have its own get_irq_list()) and may contain typos
> in architectures I've no access to.
> 	d) holes had been there for quite a while and it's either
> "cat /proc/interrupts always causes memory corruption" or "everything OK"
> 
> I'm not quite sure where it is - if we were in -pre<small> I'd definitely
> say that it's worth merging, so that trivial typos could be caught before
> the release; the hole obviously deserves fixing.  OTOH, merging that in -final
> means that we are risking "2.4.15 doesn't compile on <architecture>"...

If I understand things right, at least a few arches (PPC, MIPS, m68k,
others) needs to implement show_trace_task anyhow, so we're already at
2.4.15 doesn't compile on <architecture>.  I'd vote for a quick typo
check and submit. :)

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
