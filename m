Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261833AbTCPAqG>; Sat, 15 Mar 2003 19:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261851AbTCPAqG>; Sat, 15 Mar 2003 19:46:06 -0500
Received: from murphys.services.quay.plus.net ([212.159.14.225]:61429 "HELO
	murphys.services.quay.plus.net") by vger.kernel.org with SMTP
	id <S261833AbTCPAqD>; Sat, 15 Mar 2003 19:46:03 -0500
Date: Sun, 16 Mar 2003 00:55:13 +0000
From: Stig Brautaset <arch@brautaset.org>
To: arch <arch-users@lists.fifthvision.net>
Cc: Robert Anderson <rwa@alumni.princeton.edu>,
       Daniel Phillips <phillips@arcor.de>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [arch-users] Re: BitBucket: GPL-ed KitBeeper clone
Message-ID: <20030316005513.GA1405@brautaset.org>
References: <200303151621.h2FGLgaD003246@eeyore.valparaiso.cl> <20030315212205.CDE923D979@mx01.nexgo.de> <1047765218.9619.124.camel@lan1> <20030316001840.GB11761@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030316001840.GB11761@pasky.ji.cz>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 16 2003, Petr wrote:
> > I think the arch-users@lists.fifthvision.net list would be happy to host
> > continuing discussion in this vein.  Considering Larry's repeated
> > attempts to get people to look at arch as a "better fit," it seems
> > particularly appropriate.
> > 
> > Of course, you'd have to tolerate "arch community" views on a lot of
> > these issues, but I suspect that might help focus the discussion.
> 
> I'm not sure if arch is the right thing to base on. Its concepts are surely
> interesting, however there are several problems (some of them may be
> subjective):
> 
> * Terrible interface. Work with arch involves much more typing out of long
> commands (and sequences of these), subcommands and parameters to get
> functionality equivalent to the one provided much simpler by other SCMs. I see
> it is in sake of genericity and sometimes more sophisticated usage scheme, but
> I fear it can be PITA in practice for daily work.

Someone made a script not long ago to create four-letter aliases of all
arch commands. Instead of `larch star-merge' you type `lstm'. Does that
sound more like what you want?

> * Awful revision names (just unique ids format). Again, it involves much more
> typing and after some hours of work, the dashes will start to dance around and
> regroup at random places in front of your eyes. The concepts behind (like
> seamless division to multiple archives; I can't say I see sense in categories)
> are intriguing, but the result again doesn't seem very practical.

Chose shorter names ;p

> * Evil directory naming. {arch} seems much more visible than CVS/ and SCCS/,
> particularly as it gets sorted as last in a directory, thus you see it at the
> bottom of ls output.

echo "alias ls='ls --ignore {arch}'" >> .bashrc

Funnily enough, {arch} lists _first_ in ls output here. That was the
idea behind the curly braces in the first place too afaik.

> Also it's a PITA with bash, as the stuff starting by '=' (arch likes
> to spawn that as well) is. 

No it doesn't. Tom, the main author of arch, likes files starting with
`='. The rest of us are not so sure ;) Off the top of my head I cannot
think of any file users should have to touch wich have a name starting
with `='. 


> The files starting by '+' are problem for vi, which is kind of flaw
> when they are probably the only arch files dedicated for editting by
> user (they are supposed to contain log messages).

This is a known issue and is being looked into afaik.
I for one agree completely with this point.

> * Cloud of shell scripts. It poses a lot of limitations which are pain to work
> around (including speed, two-fields version numbers [eek] and I can imagine
> several others; I'm not sure about these though, so I won't name further; you
> can possibly imagine something by yourself).

Arch being a bunch of shell scripts:

	http://arch.fifthvision.net/bin/view/Main/ArchMyths

Three-fields version names is being worked at IIRC.

> Also, history is not preserved during merging, which is quite fatal.

Not true. Any merge will include patch logs for the merged-in patches.

> And it looks to me at least from the documentation that arch is still
> in the update-before-commit stage.

have you looked at the --out-of-date-ok flag to commit? (not that I
understand why you would want to use that...)

> rewritten sooner or later anyway. The backend history format doesn't appear to
> be particularily great as well. Dunno. What's so special about arch then?

This say it so much better than I can:

	http://arch.fifthvision.net/bin/view/Main/WhyArch


Stig
-- 
brautaset.org
