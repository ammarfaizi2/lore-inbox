Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286986AbRL1TJ3>; Fri, 28 Dec 2001 14:09:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286987AbRL1TJT>; Fri, 28 Dec 2001 14:09:19 -0500
Received: from cmailg4.svr.pol.co.uk ([195.92.195.174]:32579 "EHLO
	cmailg4.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S286986AbRL1TJH>; Fri, 28 Dec 2001 14:09:07 -0500
Posted-Date: Fri, 28 Dec 2001 19:08:54 GMT
Date: Fri, 28 Dec 2001 19:08:54 +0000 (GMT)
From: Riley Williams <rhw@MemAlpha.cx>
Reply-To: Riley Williams <rhw@MemAlpha.cx>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Legacy Fishtank <garzik@havoc.gtf.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: State of the new config & build system
In-Reply-To: <Pine.LNX.4.33.0112280948450.23339-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0112281901360.3044-100000@Consulate.UFP.CX>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus.

> [ Btw, Jeff, any reason why you changed your name to "Legacy
> Fishtank"? It took a few mails before I noticed that it also said
> "garzik" in the fine print;]

I had wondered where he'd gone to - Jeff was one of the few from who I
read every email, and it's been a while since I saw anything from him.

> One thing that this big flame-war has brought up is that different
> people like different things. There may be a simpler solution to
> this: have the core dependency files generated from some other file
> format.
> 
> My pet peeve is "centralized knowledge". I absolutely detested the
> first versions of cml2 for having a single config file, and quite
> frankly I don't think Eric has even _yet_ separated things out
> enough - why does the main "rules.cml" file have
> architecture-specific info, for example?
> 
> That's a big step backwards as far as I'm concerned - we didn't use
> to have those stupid global files, and each architecture could do
> it's own config rules. Eric never got the point that to me,
> modularity is _the_ most important thing for maintenance.
> 
> Something I also asked for the config system at least a year ago was
> to have Configure.help split up. Never happened. It's still one
> large ugly file. Driver or architecture maintainers still can't just
> change _their_ small fragment, they have to touch a global file that
> they don't "own".
> 
> So if somebody really wants to help this, make scripts that generate
> config files AND Configure.help files from a distributed set. And
> once you do that, you could even imagine creating the old-style
> config files (without the automatic checking and losing some
> information) from the information.

I offered to go through Configure.help and split it up a while back, and
I was drowned in several dozen emails saying that such was a BAD THING,
with absolutely zilch saying otherwise. I'm more than willing to have a
go at splitting it up into separate files by directory, but before I do,
I would need to know how you wished to deal with symbols that are
referenced all over the source tree rather than just in a single
directory.

Another thing I'd like to do is to introduce a "boilerplate" mechanism
whereby help text that's repeated in multiple options gets stored just
once and dragged in when it's needed. I've made a start on doing that
with the current Configure.help file and the `make config` and `make
menuconfig` commands, and have patches available against the 2.0.39,
2.2.20 and 2.4.17 trees to provide the base implementation for `make
config` but gather that such is pointless as those commands will soon be
extracted from the Linux kernel.

Best wishes from Riley.

