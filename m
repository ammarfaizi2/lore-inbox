Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293755AbSCFTKS>; Wed, 6 Mar 2002 14:10:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310123AbSCFTKG>; Wed, 6 Mar 2002 14:10:06 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:45062 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S293755AbSCFTJ6>; Wed, 6 Mar 2002 14:09:58 -0500
Date: Wed, 6 Mar 2002 14:08:19 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Tim Waugh <twaugh@redhat.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] 2.4.18-pre/rc broke PLIP
In-Reply-To: <20020305220359.B8959@redhat.com>
Message-ID: <Pine.LNX.3.96.1020306135913.386C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Mar 2002, Tim Waugh wrote:

> On Tue, Mar 05, 2002 at 04:20:25PM -0500, Bill Davidsen wrote:
> 
> > 1 - didn't try, I checked that the patch had not been reverted, and
> >     assumed that if it was broken and not changed it was broken still.
> >     And I only looked in pre2-ac2, if it was fixed and Alan patched it
> >     back broken.
> 
> Well, try it.  The correct patch is in there.

  Interesting, doesn't work for me, and I have a note from Alan Cox which
seems to indicate it doesn't work for him, either.
 
> > 2 - understanding vast stretches of uncommented code you may need to
> >     change is worthwhile reading. The corolary is that comments are worthwhile
> >     typing.
> 
> (You must have missed the ChangeLog.)

I have looked in the changelog in the driver directory, for ac2, and for
19-pre2, and find nothing about the bits used in the control registers.
Nor would I expect it to, this is in the chip spec sheets, and if I had
written the code would be in very terse form in the definition of the data
structure as well.

I'm still looking for the spec sheets, somewhat limited by time. I found
only the definition of the 0x20 bit in the writable mask, and the problem
seems to stem from the change in init from "0xff" to "~0x10" at least on
one machine. Before I go offering that as a solution I want to understand
what the bits are doing (or at least intended to do). I try very hard not
to offer "this works for me but I don't know why" fixes.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

