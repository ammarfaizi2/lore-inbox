Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263843AbTKKXwX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 18:52:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263848AbTKKXwX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 18:52:23 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:50132 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S263843AbTKKXwV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 18:52:21 -0500
Date: Tue, 11 Nov 2003 15:52:15 -0800
From: Larry McVoy <lm@bitmover.com>
To: Andrew Walrond <andrew@walrond.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel.bkbits.net off the air
Message-ID: <20031111235215.GA22314@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Andrew Walrond <andrew@walrond.org>, linux-kernel@vger.kernel.org
References: <fa.eto0cvm.1v20528@ifi.uio.no> <200311111438.47868.andrew@walrond.org> <bore48$ubl$1@cesium.transmeta.com> <200311112021.34631.andrew@walrond.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200311112021.34631.andrew@walrond.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 11, 2003 at 08:21:34PM +0000, Andrew Walrond wrote:
> On Tuesday 11 Nov 2003 7:43 pm, H. Peter Anvin wrote:
> >
> > OK... this still doesn't deal with how to get mirrors to pick stuff up
> > with a minimum of fuss.  The "minimum of fuss" bit is *extremely*
> > important... I still haven't managed to get all mirrors to use rsync.
> 
> 1. Don't bother with cvs.Just host a clone of the main bk repository

There's a good idea :)

> 2. Persuade Larry to release a 'clone/pull-only' version of bk which *anyone* 
> can use to  access open source software

As I've explained in the past, this doesn't make sense.  I'd be far more
likely to build a sort of CVS like client that could do checkouts and
updates of read only files.  That's a pretty straightforward thing to
do, in fact, nobody needs BK source to do that, it could all be done as
wrappers pretty trivially.  If someone wanted to code that up and make the
code available under a BSD license we'd take a good look at adding that
into the BK server side.  It doesn't need to be bundled in BK however.
Anyone could write a daemon that locally called BK to get the data and
a client that talked to the daemon.

The hard part is renames but even that can be handled reasonably easily.

> Seriously though; There isn't another way that I can see for mirroring cvs 
> repos coherently, unless cvsup does something clever? Anyone know?

I could make some comment about this being a good example of one of
the zillion little problems we've had to solve but if I go there it's
going to start a flame war.  So I won't.  I will note that none of the
solutions proposed come close to being acceptable, they all fail on NFS
and on SMB shares.  And they don't cascade properly as HPA has noted.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
