Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284220AbRL1W67>; Fri, 28 Dec 2001 17:58:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284239AbRL1W6t>; Fri, 28 Dec 2001 17:58:49 -0500
Received: from [195.63.194.11] ([195.63.194.11]:53515 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S284220AbRL1W6g>; Fri, 28 Dec 2001 17:58:36 -0500
Message-ID: <3C2CF688.5010503@evision-ventures.com>
Date: Fri, 28 Dec 2001 23:47:36 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Legacy Fishtank <garzik@havoc.gtf.org>, Dave Jones <davej@suse.de>,
        "Eric S. Raymond" <esr@snark.thyrsus.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: State of the new config & build system
In-Reply-To: <Pine.LNX.4.33.0112280948450.23339-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>[ Btw, Jeff, any reason why you changed your name to "Legacy Fishtank"? It
>  took a few mails before I noticed that it also said "garzik" in the
>  fine print;]
>
>One thing that this big flame-war has brought up is that different people
>like different things. There may be a simpler solution to this: have the
>core dependency files generated from some other file format.
>
>My pet peeve is "centralized knowledge". I absolutely detested the first
>versions of cml2 for having a single config file, and quite frankly I
>don't think Eric has even _yet_ separated things out enough - why does the
>main "rules.cml" file have architecture-specific info, for example?
>
>That's a big step backwards as far as I'm concerned - we didn't use to
>have those stupid global files, and each architecture could do it's own
>config rules. Eric never got the point that to me, modularity is _the_
>most important thing for maintenance.
>
>Something I also asked for the config system at least a year ago was to
>have Configure.help split up. Never happened. It's still one large ugly
>file. Driver or architecture maintainers still can't just change _their_
>small fragment, they have to touch a global file that they don't "own".
>
>So if somebody really wants to help this, make scripts that generate
>config files AND Configure.help files from a distributed set. And once you
>do that, you could even imagine creating the old-style config files
>(without the automatic checking and losing some information) from the
>information.
>
If you go thus far... then I think, that the Configure.help stuff should 
be embedded inside the driver source code
itself. Like for example the postfix MTA code is embedding whole *man* 
pages there. And  *man* pages would be
anyway a more appriopriate and classical place where the current 
Configure.help information should be.

Just lift the code over from there (The extraction is even proper awk 
insead of some perl crap...) and be nearly done.



