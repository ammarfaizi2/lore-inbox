Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261293AbTCLPAs>; Wed, 12 Mar 2003 10:00:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261458AbTCLPAs>; Wed, 12 Mar 2003 10:00:48 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:37077 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261293AbTCLPAr>;
	Wed, 12 Mar 2003 10:00:47 -0500
Date: Wed, 12 Mar 2003 16:11:17 +0100
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andre Hedrick <andre@linux-ide.org>,
       scott thomason <scott-kernel@thomasons.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bio too big device
Message-ID: <20030312151117.GH834@suse.de>
References: <20030312085145.GJ811@suse.de> <Pine.LNX.4.10.10303120100490.391-100000@master.linux-ide.org> <20030312090943.GA3298@suse.de> <1047485697.22696.23.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1047485697.22696.23.camel@irongate.swansea.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 12 2003, Alan Cox wrote:
> On Wed, 2003-03-12 at 09:09, Jens Axboe wrote:
> > On Wed, Mar 12 2003, Andre Hedrick wrote:
> > > 
> > > So lets dirty list the one drive by Paul G. and be done.
> > > Can we do that?
> > 
> > Who cares, really? There's not much point in doing it, we're talking 248
> > vs 256 sectors in reality. I think it's a _bad_ idea, lets just keep it
> > at 255 and avoid silly drive bugs there.
> 
> 255 trashes your performance, 128 will perform far better with most
> setups. This is especially true with raid setups. I'd much rather we

Then go with 128. I'd like to stress again that _if_ you get worse
performance it's not due to the request being a bit smaller, but indeed
because 248 can cause badly aligned requests.

> got the IDE layer using 256 block writes even if we have to limit it
> to more modern drives by some handwaving (8Gb+ say)

Does Windows use 256 sector requests or not? If not, then I'd sure don't
want to do it in Linux, the handwaving doesn't mean anything then.

-- 
Jens Axboe

