Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263742AbTLOTkO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 14:40:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263832AbTLOTkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 14:40:14 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:45714
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263742AbTLOTkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 14:40:09 -0500
Date: Mon, 15 Dec 2003 20:40:57 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Larry McVoy <lm@work.bitmover.com>, Sergey Vlasov <vsu@altlinux.ru>,
       linux-kernel@vger.kernel.org
Subject: Re: RFC - tarball/patch server in BitKeeper
Message-ID: <20031215194057.GL6730@dualathlon.random>
References: <20031214172156.GA16554@work.bitmover.com> <2259130000.1071469863@[10.10.2.4]> <20031215151126.3fe6e97a.vsu@altlinux.ru> <20031215132720.GX7308@phunnypharm.org> <20031215192402.528ce066.vsu@altlinux.ru> <20031215183138.GJ6730@dualathlon.random> <20031215185839.GA8130@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031215185839.GA8130@work.bitmover.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 15, 2003 at 10:58:39AM -0800, Larry McVoy wrote:
> On Mon, Dec 15, 2003 at 07:31:38PM +0100, Andrea Arcangeli wrote:
> > you get the 2.4 branch linear history via bkcvs. Though there you lose
> > all the granular xfs development changesets instead, the xfs merge
> > becames a huge monolithic patch see below.  Either way or another you
> > lose information compared to true BK. From my part I'm fine with the
> > info provided in bkcvs, I'm only correcting Larry statement about him
> > providing lots of way to get at the data in a interoperable protocol,
> > he's only providing _partial_ data in a interoperable way. I'm stating
> > facts, no whining intendend.
> 
> You can get at the full patch level granularity via BK/Web, on bkbits,
> complete with checkin comments, diffs, whatever you want.  There isn't
> any more information to give you that is not internal BK information
> which is covered by trade secret.  We have every right to not provide
> you with information about how BitKeeper works and we've already provided
> the data in multiple ways.
> 
> - You have an open export of the data into bkcvs, this addressed the "I'm not
>   using BK so I'm at a disadvantage" problem

the open export lacks some granular information this is a fact. that's
fine with me though.

> - You have patch by patch access to the data at bkbits.net for all
>   repositories, this addressed the "I want the fine granularity of
>   individual patches" problem.

I think it's reasonable to write an automated tool that generates all
the granular info for the big merges by doing a lookup on the web for
every single bkcvs changeset, I did something similar already but I
missed the linearization of bkcvs, not maybe it could have a chance to
work. But the last time I attempted to use the web as a "fetch" tool,
not as a "browsing tool with a browser with an human behind" you said if
we would use it that way you would shut it down, that doesn't match my
definition of interoperability or availability very well.

> - I've offered up the tarball+patch update protocol to address the "I'm
>   not
>  using BK so I can't easily track the latest version of J Random tree"
>  problem.

that's an enterely different issue, don't mix things up. That loses
*tons* of information, much more than bkcvs, I'm not even considering
it. that's only useful to projects where the developers don't even
supply tarballs and patches anymore if I understood correctly. On the
kernel we've the bkcvs that doesn't lose that much of information, so I
don't see any use for this tool on the kernel side.
