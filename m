Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289655AbSA2MZ1>; Tue, 29 Jan 2002 07:25:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289645AbSA2MYF>; Tue, 29 Jan 2002 07:24:05 -0500
Received: from ns.suse.de ([213.95.15.193]:20742 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S289631AbSA2MWa>;
	Tue, 29 Jan 2002 07:22:30 -0500
Date: Tue, 29 Jan 2002 13:22:28 +0100
From: Dave Jones <davej@suse.de>
To: Rob Landley <landley@trommello.org>
Cc: Francesco Munda <syylk@libero.it>, linux-kernel@vger.kernel.org
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <20020129132228.A9149@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Rob Landley <landley@trommello.org>,
	Francesco Munda <syylk@libero.it>, linux-kernel@vger.kernel.org
In-Reply-To: <200201282213.g0SMDcU25653@snark.thyrsus.com> <200201290137.g0T1bwB24120@karis.localdomain> <200201290341.g0T3fNU30909@snark.thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200201290341.g0T3fNU30909@snark.thyrsus.com>; from landley@trommello.org on Mon, Jan 28, 2002 at 10:42:19PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2002 at 10:42:19PM -0500, Rob Landley wrote:
 
 > probably diminish as new development shifts over to 2.5.  Right now, the 
 > patch constipation we've been seeing is, in my opinion, directing development 
 > to occur against 2.4 that should at the very least be eyeing 2.5.  (Alan is 
 > probably NOT interested in integrating patches that Marcelo has no intention 
 > of eventually integrating into 2.5.  So he's not taking the new development 
 > integration pressure off, that's DJ's job.)
 > 
 > I think DJ could definitely use a clearer mandate.

 * Initially, -dj was "pick up fixes from 2.4".

 * Then when Linus broke various other parts of 2.5, I took fixes
   for various bits. (Some of those went back his way, others didn't,
   others are still in the process)
   (I'm a believer in the 'eat your own dogfood' thing, and run my
   tree on several testboxes -- being able to compile/boot/test
   this tree became more important at the cost of the tree growing
   a little further away from -linus)

 * Some developers also wanting to develop against 2.5 found the
   quickest way to get a compilable, workable 2.5 tree was to
   grab my snapshot, and work against my tree until Linus gets his
   together.  And hence, the input layer & fb layer changes.
   This was one I had to think about a bit before deciding if
   I was going to start accepting such patches.
   In theory, as we're now in 2.5, there should be no need for this,
   but whilst Linus is busy focusing on the block layer, scheduler
   or other flavour of the week, James, Vojtech etc can at least
   get some extra testers before their code hits -linus.
   By the time that the new input/fb stuff is ready for Linus' tree
   hopefully a lot of the more obvious problems will be shaken out,
   and Linus can have a set of patches for a "new xxx layer" that
   works for at least everyone who's been testing it in -dj.

 Where to go from here? More of the same. It's a fulltime job
 keeping up with Marcelo & Linus, and reviewing, merging, and
 chasing down the right people.  One thing I'm not entirely 
 enthusiastic about doing, is making policy decisions.
 I've had questions from people asking me if I'll merge xxx's
 implementation of ACLs for example. Without knowing which way
 Linus is going to turn on such an issue, I'm naturally hesitant.

 Another thing of note is that the merge process with Linus
 isn't as straightforward as running splitdiff, and pushing the
 chunks to Linus. Some bits require a timing (although this is
 sometimes hard to get right) so I can push him filesystem
 changes when Al isn't turning the VFS upside down for eg.
 Other bits I won't push because maintainers have mailed me
 asking me not to.  And other bits, because the maintainers
 can do a better job of splitting,pushing and describing than
 I can (typical example: the fbdev/input stuff)
 
 > Dave didn't seem to have any major objections but raised a lot technical 
 > points to the effect of "I'm already doing this bit".  Both of them gave me 
 > permission to post most of our conversation to the list, but seem unwilling 
 > to do it themselves. :)

 Time, Headcold, time, blah, excuses 8)
 But to reiterate, yes. Most of what you described is exactly whats
 taking place, although a lot of it happens behind the scenes, not
 on Linux-kernel, not on irc, but me being a pita chasing maintainers
 "Hey xxx sent me a patch, aren't you working on this? You two should
  talk..". It's like being a switchboard operator at times, plugging
 in the right cables, connecting the right people.
 
 > As for attracting Linus's attention, there's a penguin and egg problem here: 
 > without an integration lieutenant Linus is largely too swamped to reliably be 
 > aware of this kind of thread on the list

 Linus' concern that people don't scale is perhaps not unfounded.
 Since I started doing this, the number of hours involved has increased
 on a day by day basis. If there comes a time where >I'm< not scaling
 and start dropping patches, then maybe an extra tier is needed. *shrug*
 For now at least, things seem to be working out quite well on the whole.
 I'm not aware of any particularly important fix/cleanup that has been 
 dropped on the floor since I started scooping them up.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
