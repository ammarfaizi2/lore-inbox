Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262685AbSJHCbl>; Mon, 7 Oct 2002 22:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262713AbSJHCbl>; Mon, 7 Oct 2002 22:31:41 -0400
Received: from h24-87-160-169.vn.shawcable.net ([24.87.160.169]:53890 "EHLO
	oof.localnet") by vger.kernel.org with ESMTP id <S262685AbSJHCbk>;
	Mon, 7 Oct 2002 22:31:40 -0400
Date: Mon, 7 Oct 2002 19:36:54 -0700
From: Simon Kirby <sim@netnation.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Chris Friesen <cfriesen@nortelnetworks.com>,
       Daniel Phillips <phillips@arcor.de>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Oliver Neukum <oliver@neukum.name>, Rob Landley <landley@trommello.org>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: The reason to call it 3.0 is the desktop (was Re: [OT] 2.6 not 3.0 -  (NUMA))
Message-ID: <20021008023654.GA29076@netnation.com>
References: <m17yCIx-006hSwC@Mail.ZEDAT.FU-Berlin.DE> <1281002684.1033892373@[10.10.2.3]> <E17ybuZ-0003tz-00@starship> <3DA1D30E.B3255E7D@digeo.com> <3DA1D969.8050005@nortelnetworks.com> <3DA1E250.1C5F7220@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DA1E250.1C5F7220@digeo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2002 at 12:36:48PM -0700, Andrew Morton wrote:

> Block allocators are fertile grounds for academic papers.  It's
> complex.  There is a risk that you can do something which is
> cool in testing, but ends up exploding horridly after a year's
> use.  By which time we have ten million deployed systems running like
> dogs, damn all we can do about it.
> 
> The best solution is to use first-fit and online defrag to fix the
> long-term fragmentation.  It really is.  There has been no appreciable
> progress on this.
> 
> A *practical* solution is to keep a spare partition empty and do
> a `cp -a' from one partition onto another once per week and
> swizzle the mountpoints.  Because the big copy will unfragment
> everything.

Having seen fragmentation issues build up on (mbox) mail spools over
several years first hand, I can say that mail spools definitely show the
need for a defragmentation tool.  I remember actually doing the "cp -a"
trick just to restore the mail server to decent performance (which
worked amazingly well, for another few months).  (This was before we
switched to hashed directories and a POP3 server which caches mbox
messages offsets/UIDLs/states.)

Being able to defragment online would be very useful.  I've seen some
people talk about this every so often.  How far away is it?

Simon-

[        Simon Kirby        ][        Network Operations        ]
[     sim@netnation.com     ][     NetNation Communications     ]
[  Opinions expressed are not necessarily those of my employer. ]
