Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <154181-8093>; Tue, 19 Jan 1999 00:47:32 -0500
Received: by vger.rutgers.edu id <153990-8100>; Tue, 19 Jan 1999 00:47:23 -0500
Received: from naughty.monkey.org ([152.160.231.194]:18242 "HELO naughty.monkey.org" ident: "extracurriculum") by vger.rutgers.edu with SMTP id <154141-8100>; Tue, 19 Jan 1999 00:46:57 -0500
Date: Tue, 19 Jan 1999 00:49:32 -0500 (EST)
From: Chuck Lever <cel@monkey.org>
To: lk@winux.com
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.rutgers.edu
Subject: Re: TCP Splice alleviates proxy bottleneck
In-Reply-To: <13988.3004.758570.281457@wander.auton.org>
Message-ID: <Pine.BSF.3.96.990119004333.23449B-100000@naughty.monkey.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu

On Mon, 18 Jan 1999 lk@winux.com wrote:

> Date: Mon, 18 Jan 1999 23:36:12 -0500 (EST)
> From: lk@winux.com
> To: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Cc: linux-kernel@vger.rutgers.edu
> Subject: Re: TCP Splice alleviates proxy bottleneck
> 
> Alan Cox writes:
> > From:	alan@lxorguk.ukuu.org.uk (Alan Cox)
> > To:	lk@winux.com
> > Cc:	alan@lxorguk.ukuu.org.uk, linux-kernel@vger.rutgers.edu
> > Subject: Re: TCP Splice alleviates proxy bottleneck
> > Date:	Mon, 18 Jan 1999 14:53:14 +0000 (GMT)
> > 
> >> Their work on TCP Splice gives the efficiency of IP masquerading, yea, 
> >> even that of simple IP forwarding, to processes with the capabilities
> >> of application level proxies.
> > 
> > Their ? Having looked at the reference I'd like Larry McVoy's opinion on
> > its originality 8)
> 
> I'm not sure what you mean by this.  Are you referring to Larry McVoy's
> paper "Splice - a push pull I/O model for Unix" dated 6/24/98 [1]?
> 
> If so, the model he presents is a bit different than theirs. A cursory
> reading of his paper indicates to me that his model is intended to be
> more general, i.e. not intended purely for TCP/IP, and as such it (rightly)
> glosses over most of the TCP/IP-specific issues that Pravin and Maltz
> address in their paper dated 3/17/98 [2].  They also have the advantage of
> having implemented their ideas.

Druschel and Pai *have* implemented IO-Lite, which seems similar in spirit
to McVoy's ideas.  see:

  http://www.cs.rice.edu/~vivek/IO-Lite/TR97-294.ps

i think this would be a great starting place for what you have in mind.  a
combination of the general zero-copy I/O semantics and the TCP-specific
improvements could be very slick.

> References:
> 
> [1] http://www.bitmover.com/lm/papers/splice.ps
> [2] http://www.cs.umd.edu/users/pravin/TR-21139.ps.gz

	- Chuck Lever
--
corporate:	<chuckl@netscape.com>
personal:	<chucklever@netscape.net> or <cel@monkey.org>


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
