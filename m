Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292804AbSCIQqW>; Sat, 9 Mar 2002 11:46:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292811AbSCIQqM>; Sat, 9 Mar 2002 11:46:12 -0500
Received: from tartarus.telenet-ops.be ([195.130.132.34]:30854 "EHLO
	tartarus.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S292804AbSCIQp5>; Sat, 9 Mar 2002 11:45:57 -0500
Date: Sat, 9 Mar 2002 17:45:46 +0100
From: Kurt Roeckx <Q@ping.be>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Cort Dougan <cort@fsmlabs.com>, Rik van Riel <riel@conectiva.com.br>,
        "Jonathan A. George" <JGeorge@greshamstorage.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Kernel SCM: When does CVS fall down where it REALLY matters?
Message-ID: <20020309174546.A389@ping.be>
In-Reply-To: <3C87FD12.8060800@greshamstorage.com> <Pine.LNX.4.44L.0203072057510.2181-100000@imladris.surriel.com> <20020307170334.D5423@host110.fsmlabs.com> <3C89EF33.B0CB77BD@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C89EF33.B0CB77BD@linux-m68k.org>; from zippel@linux-m68k.org on Sat, Mar 09, 2002 at 12:17:07PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 09, 2002 at 12:17:07PM +0100, Roman Zippel wrote:
> 
> Cort Dougan wrote:
> 
> > Only doing a given merge once is great.  That's a big time-saver over the
> > long term.
> 
> Could someone explain me, how this "merge once" works? How is this
> different from cvs? I mean, cvs is capable of doing merges, if new
> changes are not at the same position.

The way I currently work is I do a cvs diff, store it in a file,
and reverse apply it to my cvs tree, so I have a clean tree
again.  You do this with several things you're working on.

Then someone changes something, so you do a cvs update, you apply
the patches, deal with conflicts if any, and make a new patch of it.

What I would like to see, and think that they mean is, I tag
those change as a "patch" in the tree, probably localy, and I
just do a cvs update, and if there are no conflicts, I'm done.

If you only have 1 thing you're working on (per tree), cvs update
should work, but I don't want to copy the tree several times.


Kurt

