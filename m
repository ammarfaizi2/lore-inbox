Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289725AbSAOW5h>; Tue, 15 Jan 2002 17:57:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289728AbSAOW5b>; Tue, 15 Jan 2002 17:57:31 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:56192
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S289725AbSAOW5S>; Tue, 15 Jan 2002 17:57:18 -0500
Date: Tue, 15 Jan 2002 15:56:52 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Cc: Justin Carlson <justincarlson@cmu.edu>, esr@thyrsus.com,
        linux-kernel@vger.kernel.org
Subject: Re: Aunt Tillie builds a kernel (was Re: ISA hardware discovery -- the elegant solution)
Message-ID: <20020115225652.GB5220@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <20020115013025.GA3814@cpe-24-221-152-185.az.sprintbbd.net> <197055869.1011134770@[195.224.237.69]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <197055869.1011134770@[195.224.237.69]>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2002 at 10:46:11PM -0000, Alex Bligh - linux-kernel wrote:
> >>From the other side, how does having the ability to probe local hardware
> >>hurt?  It should be cleanly seperable from the classical build process
> >>for the purists, and helpful to some (I think) significant portion of
> >>the userbase, particularly those folks who like to test bleeding edge
> >>stuff on a variety of hardware.  I don't really understand the
> >>resistance to the idea of someone going out and implementing this.
> >
> >Right, and this is 95% possible even.  Doing PCI stuff is rather easy
> >(since we've got it all mapped out even).  The problem is the 100%
> >point-click-run goal that Eric has.
> >
> >The original sticking point was doing ISA (and other buses that are
> >_not_ autodetect friendly in a safe way).
> 
> & this has a seemingly obvious solution,
[snip]

> those, which when loaded on a system not containing the relevant
> card, can cause a hangup; thus deferring the autoprobing until
> boot time.

If everything worked before as a module, this works still.  If not, you
need to have a for loop or something that attempts to load every XXX
subsystem driver.

But the point I was getting at is the 100% solution isn't possible.
Even if we narrow the scope of the problem to just x86 hardware, theres
still things which can't be solved.  Talking to random memory locations
will bite you at somepoint on some hw.  Old busses weren't designed with
any sort of autoconfig in mind.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
