Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265764AbSKAUbM>; Fri, 1 Nov 2002 15:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265769AbSKAUbL>; Fri, 1 Nov 2002 15:31:11 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:17469 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id <S265764AbSKAUag>; Fri, 1 Nov 2002 15:30:36 -0500
Date: Fri, 1 Nov 2002 20:37:56 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Linus Torvalds <torvalds@transmeta.com>
cc: Joel Becker <Joel.Becker@oracle.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Bill Davidsen <davidsen@tmr.com>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <lkcd-general@lists.sourceforge.net>,
       <lkcd-devel@lists.sourceforge.net>
Subject: Re: What's left over.
In-Reply-To: <Pine.LNX.4.44.0211011107470.4673-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.44.0211012003290.2206-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Nov 2002, Linus Torvalds wrote:
> On Fri, 1 Nov 2002, Joel Becker wrote:
> > 
> > 	I always liked the AIX dumper choices.  You could either dump to
> > the swap area (and startup detects the dump and moves it to the
> > filesystem before swapon) or provide a dedicated dump partition.  The
> > latter was prefered.
> 
> Ehh.. That was on closed hardware that was largely designed with and for
> the OS.
>... 
> In other words: it's a huge risk to play with the disk when the system is
> already known to be unstable. The disk drivers tend to be one of the main
> issues even when everything else is _stable_, for chrissake!
> 
> To add insult to injury, you will not be able to actually _test_ any of 
> the real error paths in real life. Sure, you will be able to test forced 
> dumps on _your_ hardware, but while that is fine in the AIX model ("we 
> control the hardware, and charge the user five times what it is worth"), 
> again that doesn't mean _squat_ in the PC hardware space.

I dealt with crash dumps quite a lot over 10 years with SCO UNIX,
OpenServer and UnixWare: which were addressing the PC market, not
own hardware.

It's a real worry that writing a crash dump to disk might stomp in the
wrong place, but I don't recall it ever happening in practice.  But
occasionally, yes, a dump was not generated at all, or not completed.

Of course, you could argue that SCO's disk drivers were more stable :-)
which might or might not be a compliment to them.

Hugh

