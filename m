Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314684AbSDTSOe>; Sat, 20 Apr 2002 14:14:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314685AbSDTSOd>; Sat, 20 Apr 2002 14:14:33 -0400
Received: from ns.suse.de ([213.95.15.193]:51218 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S314684AbSDTSO3>;
	Sat, 20 Apr 2002 14:14:29 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove BK docs ... + x86-64 2.5.8 sync
In-Reply-To: <E16ycFR-0000Vg-00@starship.suse.lists.linux.kernel> <Pine.LNX.4.44.0204201039130.19512-100000@home.transmeta.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 20 Apr 2002 20:14:29 +0200
Message-ID: <p73u1q68cfu.fsf_-_@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> On Fri, 19 Apr 2002, Daniel Phillips wrote:
> > > > And some have a more difficult one.  So it goes.
> > >
> > > How?
> >
> > Those who now chose to carry out their development using the patch+email
> > method, and prefer to submit everything for discussion on lkml before it
> > gets included are now largely out of the loop.  Things just seem to *appear*
> > in the tree now, without much fanfare.  That's my impression.
> 
> I don't buy that - I'm not getting changes from any new magical BK "men in
> black". The patches are the same kind they always were, the last few
> entries in my changelog are now the x86-64 merge (which was half a meg,
> and yes it wasn't posted on linux-kernel, but no, it never was before BK
> either), and before that the extensively discussed SSE register content
> leak patch.

I didn't post the huge patch on l-k because the last time I sent large
patches to l-k I got flamed badly by people who still seem to use 9600
baud modems[1] to read mail.

One thing I am a bit concerned about though is that there seem to be
less pre patches since bitkeeper was introduced and in parallel lots of
patches from people working at the bk HEAD, making syncing more difficult.
I don't want to use BitKeeper because I don't like open logging. I hope
I can continue to maintain the x86-64 port even without being part
of the inner bitkeeper circle. It would be good if you did e.g.
a pre patch for every change that could require action from architecture
or other maintainers as sync point (i guess that could be made easy with
the appropiate script)

Back to the x86-64 merge:

If someone wants it it is at 

ftp.x86-64.org:/pub/linux/v2.5/2.5.8/*

(split in a big patch for arch/asm and separate bug fixes for other parts) 

Comment: 

Changes:

- Sync with 2.5.8
- SMP/APIC supported now. 
- Module loading works now. 
- Time keeping bugs fixed.
- entry.S streamlined and some bugs fixed.
- modify_ldt works now
- mostly rewritten FPU support (including FXRSTOR for initial FPU 
initialization based on the initial state) 
- 32bit emulation enhanced and bugs fixed.
- rewrote mm initialization and lots of cleanups in the page table handling
__PAGE_OFFSET is now moved to 0x10000000000 and some vmalloc/ioremap
problems have been fixed. They have an own PML4 slot now. 
- WCHAN reporting support for RIP (but not RSP) 
- Lots of various other bug fixes and cleanups. 


-Andi

[1] yes, I'm exaggerating, but it was nearly like that.
