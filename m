Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262783AbTAEDtk>; Sat, 4 Jan 2003 22:49:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262789AbTAEDtk>; Sat, 4 Jan 2003 22:49:40 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:40717 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262783AbTAEDth>; Sat, 4 Jan 2003 22:49:37 -0500
Date: Sat, 4 Jan 2003 19:52:55 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <akpm@digeo.com>
cc: Andi Kleen <ak@suse.de>, <davem@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] Lmbench 2.5.54-mm2 (impressive improvements)
In-Reply-To: <3E17AC67.43923E08@digeo.com>
Message-ID: <Pine.LNX.4.44.0301041952110.1651-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 4 Jan 2003, Andrew Morton wrote:
> > 
> > Hmm.. The backup patch doesn't handle single-stepping correctly: the
> > eflags cleanup singlestep patch later in the sysenter sequence _depends_
> > on the stack (and thus thread) being right on the very first in-kernel
> > instruction.
> 
> Well that's just a straight `patch -R' of the patch which added the wrmsr's.

Yes, but the breakage comes laterr when a subsequent patch in the 
2.5.53->54 stuff started depending on the stack location being stable even 
on the first instruction.

> > It doesn't show up on lmbench (insufficient precision), but your AIM9
> > numbers are quite interesting. Are they stable?
> 
> Seem to be, but more work is needed, including oprofiling.  Andi is doing
> some P4 testing at present.

Ok.

		Linus

