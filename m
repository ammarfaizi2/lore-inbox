Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292575AbSBPW37>; Sat, 16 Feb 2002 17:29:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292580AbSBPW3u>; Sat, 16 Feb 2002 17:29:50 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15882 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292575AbSBPW3d>;
	Sat, 16 Feb 2002 17:29:33 -0500
Date: Sat, 16 Feb 2002 22:29:25 +0000
From: Joel Becker <jlbec@evilplan.org>
To: "Eric S. Raymond" <esr@thyrsus.com>, Nicolas Pitre <nico@cam.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        That Linux Guy <thatlinuxguy@hotmail.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Disgusted with kbuild developers
Message-ID: <20020216222924.N2092@parcelfarce.linux.theplanet.co.uk>
Mail-Followup-To: Joel Becker <jlbec@evilplan.org>,
	"Eric S. Raymond" <esr@thyrsus.com>, Nicolas Pitre <nico@cam.org>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	That Linux Guy <thatlinuxguy@hotmail.com>,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20020216095039.L23546@thyrsus.com> <Pine.LNX.4.44.0202161055030.16872-100000@xanadu.home> <20020216110857.B32129@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020216110857.B32129@thyrsus.com>; from esr@thyrsus.com on Sat, Feb 16, 2002 at 11:08:57AM -0500
X-Burt-Line: Trees are cool.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 16, 2002 at 11:08:57AM -0500, Eric S. Raymond wrote:
> Nicolas Pitre <nico@cam.org>:
> > Make the whole thing ___***IDENTICAL***___ to CML1.
> > Do a formal translation of CML1 into CML2.
> 
> Would you ask someone designing a new VM to make it crash and hang exactly
> the same way the old one did?

	Eric, that's a slippery-slope argument.  You are bright enough
to know that is not what they meant.
	I like to stay out of flamewars, so I'm going to be nice,
simple, and to the point.  I hack kernels.  I build a lot of them.  I
use only make config and make oldconfig.  Here is what I want from a
config system (be it CML1 or CML2):
	make config goes through and asks me all the questions it needs
to.  The order can be different.  The slight format of the prompts can
be different.  The backend can be wildly different.  I don't CARE.  What
I do care about is that it only asks me relevant questions.  No "How old
is your computer?"  Never a "Do you like the color blue?"  None of that.
if it wants to know my CPU, it asks "What is your cpu? [386 486
Pentium/K6 ...]"  If it wants to know if I want sound support it asks
"Configure sound support?"  That's it.  I use make config because it
asks me every question, and I'm sure I haven't missed any.  When it is
done, I even know the macros it has set in config.h so I can peruse them
in the source.
	make oldconfig has to work like make old config.  Again, trivial
differences in the output layout don't matter.  Totally different logic
dont matter.  All that matters is that configuration questions I have
answered already don't get asked, and questions that are new to this
kernel do.
	The configuration metadata should be as close to the actual item
as possible.  I think everyone has come to this agreement.  You know,
drivers/scsi/aic_7xxx/aic_7xxx.cml or the like.  Fine.  I'm not even
sure that I care all that much about this.  So if everyone can come to a
level of agreement on this, I'm sure I'll be fine.
	The last thing I require is that it doesn't affect my build
time.  The kernel takes a while to build right now, even on my
dual-GHz machines with >GB RAM.  I've not played with CML2 much, but the
rumours of it taking twice as long for a build are scary.  CML2 should
have completed all of its work when make *config exited.  All of the
logic after the completion of make *config and make dep should be in the
Makefiles, just like it does in CML1.  Now, if I've got that wrong, let
me know.  I sure hope you aren't executing CML2 programs during make
bzImage.
	Until CML2 can come to do this, I'm going to stay perfectly
happy with CML1.  mconfig just makes it easier.

Joel


-- 

"The first requisite of a good citizen in this republic of ours
 is that he shall be able and willing to pull his weight."
	- Theodore Roosevelt

			http://www.jlbec.org/
			jlbec@evilplan.org
