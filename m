Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262164AbVDWXBC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262164AbVDWXBC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 19:01:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262160AbVDWXBB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 19:01:01 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:31877 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262164AbVDWXAo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 19:00:44 -0400
Date: Sun, 24 Apr 2005 01:00:23 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Petr Baudis <pasky@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.12-rc3
Message-ID: <20050423230023.GA17388@elf.ucw.cz>
References: <Pine.LNX.4.58.0504201728110.2344@ppc970.osdl.org> <20050421112022.GB2160@elf.ucw.cz> <20050421120327.GA13834@elf.ucw.cz> <20050421162220.GD30991@pasky.ji.cz> <20050421232201.GD31207@elf.ucw.cz> <20050422002150.GY7443@pasky.ji.cz> <20050422231839.GC1789@elf.ucw.cz> <Pine.LNX.4.58.0504221718410.2344@ppc970.osdl.org> <20050423111900.GA2226@openzaurus.ucw.cz> <Pine.LNX.4.58.0504230654190.2344@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504230654190.2344@ppc970.osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Could we add some kind off "This-changeset-obsoletes: <sha1>" header?
> > That would  allow me to send patches by hand and still make the SCM do the
> > right thing during merge.
> 
> That doesn't really scale, plus I don't want to rely on that kind of hack
> since it's simply not reliable (the patch may have gotten edited on the
> way, so maybe the stuff I apply is 90% from your patch, but 10%
> different).

(Well, at that point I probably want to drop that 10% anyway :-).

> Also, it doesn't actually handle the generic case, which is that the other
> end used something else than git to maintain his patches (which in the end
> has the exact same issues).

Actually this one should not be a problem. "This-changeset-obsoletes:"
would probably be in changelog part, and remote end would just
propagate it.

> > Alternatively I should just get public rsync-able space somewhere...
> > Would kernel.org be willing to add people/pavel?
> 
> Now, that's actually something people are working on ("git.kernel.org"),
> so I don't think that would be a problem. People _are_ trying to set up
> things like a bkbits.net at least for the kernel. I know OSDL and OSL
> (http://osuosl.org/) are interested, and I think the current kernel.org
> works too.
> 
> A word of warning: in many ways it's easier to work with patches. In
> particular, if you want to have me merge from your tree, I require a
> certain amount of cleanliness in the trees I'm pulling from. All of the
> people who used to use BK to sync are already used to that, but for people
> who didn't historically use BK this is going to be a learning experience.
> 
> The reason patches are easier is that you can start out from a messy tree, 
> and then whittle down the patch to just the part you want to send me, so 
> it doesn't actually matter how messy your original tree is, you can always 
> make the end result look nice. 

I created three trees here (with git fork): one ("clean-git") to track
your changes, second ("linux-git") to do my development on and third
("linux-good") for good, nice, cleaned-up changes, for you to merge.

...unfortunately pasky's git just symlinked object/ directories...

...that means that if you pull from me using rsync, you'll get all my
"development" files, too. Not accessible in any normal way, but still
there.

That means that git fork can't be used for "good tree for
Linus"... not until we have something better than rsync :-(.

								Pavel

-- 
Boycott Kodak -- for their patent abuse against Java.
