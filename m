Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286962AbRL1SFB>; Fri, 28 Dec 2001 13:05:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286956AbRL1SEv>; Fri, 28 Dec 2001 13:04:51 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:38150 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S286948AbRL1SEi>; Fri, 28 Dec 2001 13:04:38 -0500
Date: Fri, 28 Dec 2001 10:02:01 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Legacy Fishtank <garzik@havoc.gtf.org>
cc: Dave Jones <davej@suse.de>, "Eric S. Raymond" <esr@snark.thyrsus.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        <linux-kernel@vger.kernel.org>, <kbuild-devel@lists.sourceforge.net>
Subject: Re: State of the new config & build system
In-Reply-To: <20011228042648.A7943@havoc.gtf.org>
Message-ID: <Pine.LNX.4.33.0112280948450.23339-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ Btw, Jeff, any reason why you changed your name to "Legacy Fishtank"? It
  took a few mails before I noticed that it also said "garzik" in the
  fine print;]

One thing that this big flame-war has brought up is that different people
like different things. There may be a simpler solution to this: have the
core dependency files generated from some other file format.

My pet peeve is "centralized knowledge". I absolutely detested the first
versions of cml2 for having a single config file, and quite frankly I
don't think Eric has even _yet_ separated things out enough - why does the
main "rules.cml" file have architecture-specific info, for example?

That's a big step backwards as far as I'm concerned - we didn't use to
have those stupid global files, and each architecture could do it's own
config rules. Eric never got the point that to me, modularity is _the_
most important thing for maintenance.

Something I also asked for the config system at least a year ago was to
have Configure.help split up. Never happened. It's still one large ugly
file. Driver or architecture maintainers still can't just change _their_
small fragment, they have to touch a global file that they don't "own".

So if somebody really wants to help this, make scripts that generate
config files AND Configure.help files from a distributed set. And once you
do that, you could even imagine creating the old-style config files
(without the automatic checking and losing some information) from the
information.

		Linus

