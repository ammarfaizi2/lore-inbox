Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261855AbTCPAIG>; Sat, 15 Mar 2003 19:08:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261857AbTCPAIG>; Sat, 15 Mar 2003 19:08:06 -0500
Received: from pasky.ji.cz ([62.44.12.54]:46077 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id <S261855AbTCPAIE>;
	Sat, 15 Mar 2003 19:08:04 -0500
Date: Sun, 16 Mar 2003 01:18:40 +0100
From: Petr Baudis <pasky@ucw.cz>
To: Robert Anderson <rwa@alumni.princeton.edu>
Cc: Daniel Phillips <phillips@arcor.de>, lkml <linux-kernel@vger.kernel.org>,
       arch <arch-users@lists.fifthvision.net>
Subject: Re: BitBucket: GPL-ed KitBeeper clone
Message-ID: <20030316001840.GB11761@pasky.ji.cz>
Mail-Followup-To: Robert Anderson <rwa@alumni.princeton.edu>,
	Daniel Phillips <phillips@arcor.de>,
	lkml <linux-kernel@vger.kernel.org>,
	arch <arch-users@lists.fifthvision.net>
References: <200303151621.h2FGLgaD003246@eeyore.valparaiso.cl> <20030315212205.CDE923D979@mx01.nexgo.de> <1047765218.9619.124.camel@lan1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1047765218.9619.124.camel@lan1>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Sat, Mar 15, 2003 at 10:53:34PM CET, I got a letter,
where Robert Anderson <rwa@alumni.princeton.edu> told me, that...
> On Sat, 2003-03-15 at 13:25, Daniel Phillips wrote:
> > On Sat 15 Mar 03 17:21, Horst von Brand wrote:
> > > Daniel Phillips <phillips@arcor.de> said:
> > > > On Thu 13 Mar 03 01:52, Horst von Brand wrote:
..snip..
> > > > Does anybody have a convenient mailing list for this design discussion?
> > >
> > > Good idea to move this off LKML
> > 
> > Yup, but nobody has offered one yet, so...
> 
> I think the arch-users@lists.fifthvision.net list would be happy to host
> continuing discussion in this vein.  Considering Larry's repeated
> attempts to get people to look at arch as a "better fit," it seems
> particularly appropriate.
> 
> Of course, you'd have to tolerate "arch community" views on a lot of
> these issues, but I suspect that might help focus the discussion.

I'm not sure if arch is the right thing to base on. Its concepts are surely
interesting, however there are several problems (some of them may be
subjective):

* Terrible interface. Work with arch involves much more typing out of long
commands (and sequences of these), subcommands and parameters to get
functionality equivalent to the one provided much simpler by other SCMs. I see
it is in sake of genericity and sometimes more sophisticated usage scheme, but
I fear it can be PITA in practice for daily work.

* Awful revision names (just unique ids format). Again, it involves much more
typing and after some hours of work, the dashes will start to dance around and
regroup at random places in front of your eyes. The concepts behind (like
seamless division to multiple archives; I can't say I see sense in categories)
are intriguing, but the result again doesn't seem very practical.

* Evil directory naming. {arch} seems much more visible than CVS/ and SCCS/,
particularly as it gets sorted as last in a directory, thus you see it at the
bottom of ls output. Also it's a PITA with bash, as the stuff starting by '='
(arch likes to spawn that as well) is. The files starting by '+' are problem
for vi, which is kind of flaw when they are probably the only arch files
dedicated for editting by user (they are supposed to contain log messages).

* Cloud of shell scripts. It poses a lot of limitations which are pain to work
around (including speed, two-fields version numbers [eek] and I can imagine
several others; I'm not sure about these though, so I won't name further; you
can possibly imagine something by yourself).

* Absence of sufficient merging ability, at least impression I got from the
documentation. Merging on the *.rej files level I cannot call sufficient ;-).
Also, history is not preserved during merging, which is quite fatal.  And it
looks to me at least from the documentation that arch is still in the
update-before-commit stage.

* Absence of checkin/commit distinction. File revisions and changesets seem to
be tied together, losing some of the cute flexibility BK has.

I must have missed terribly something in the documentation given how arch is
being recommended, please feel encouraged to correct me. But as I see it, most
of the juicy stuff is missing (altough I really like the concept of
configurations and especially the concept of caching --- mainly that you do not
_have_ to pull all the stuff from the clonee repository, which can be a pain
with more poor internet connection; then also if you aren't doing any that big
changes and you're confident that the remote repository is going to stay there,
it is less expensive to talk with the repository over network) and the existing
stuff is mostly in the form of shell scripts, which it has to leave and be
rewritten sooner or later anyway. The backend history format doesn't appear to
be particularily great as well. Dunno. What's so special about arch then?

Kind regards,

-- 
 
				Petr "Pasky" Baudis
.
The pure and simple truth is rarely pure and never simple.
		-- Oscar Wilde
.
Stuff: http://pasky.ji.cz/
