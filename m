Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130152AbRBMAYR>; Mon, 12 Feb 2001 19:24:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130148AbRBMAX7>; Mon, 12 Feb 2001 19:23:59 -0500
Received: from mailgate.bridgetrading.com ([62.49.201.178]:1802 "EHLO 
	directcommunications.net") by vger.kernel.org with ESMTP
	id <S129752AbRBMAXs>; Mon, 12 Feb 2001 19:23:48 -0500
Date: Tue, 13 Feb 2001 00:25:28 +0000 (GMT)
From: Chris Funderburg <chris@Funderburg.com>
To: Scott Murray <scott@spiteful.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: opl3sa not detected anymore
In-Reply-To: <Pine.LNX.4.30.0102121846040.10962-100000@godzilla.spiteful.org>
Message-ID: <Pine.LNX.4.30.0102130019100.1412-100000@pikachu.bti.com>
X-Unexpected-Header: Hello!!!
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Feb 2001, Scott Murray wrote:

Thanks!

The isapnp=0 fixed it.  I don't actually have an isapnp.conf file.

On my next compile I'll just disable the ISA Pnp driver.
I don't actually need it, but it's something that I've never bothered to
turn off. :)

CF

> On Mon, 12 Feb 2001, Chris Funderburg wrote:
>
> >
> > After the updates to the opl3sa2 driver (2.4.2-pre3?) my card isn't being
> > detected anymore.  Are there further updates to come, or do I need to
> > change the settings?  The driver is being loaded as a module with the
> > following in /etc/modules.conf:
> [snip]
> > The midi works fine, but 'modprobe sound' reports:
> >
> > opl3sa2: No cards found
> > opl3sa2: 0 PnP card(s) found.
>
> If you've configured ISA PnP support into the kernel, then the driver
> ignores those settings unless you specify isapnp=0.  What I'd suggest
> is that you try disabling the configuration done by the isapnp tools,
> which can be done on RedHat and derived systems by renaming your
> /etc/isapnp.conf to something else.  There seem to be some issues
> with resetting the PnP configuration with isapnp after the in-kernel
> ISA PnP driver has done its stuff, as a couple of other people have
> mentioned similiar problems.
>
> Scott
>
>
>

-- 
... Any resemblance between the above views and those of my employer,
my terminal, or the view out my window are purely coincidental.  Any
resemblance between the above and my own views is non-deterministic.  The
question of the existence of views in the absence of anyone to hold them
is left as an exercise for the reader.  The question of the existence of
the reader is left as an exercise for the second god coefficient.  (A
discussion of non-orthogonal, non-integral polytheism is beyond the scope
of this article.)


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
