Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261766AbTCLP66>; Wed, 12 Mar 2003 10:58:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261765AbTCLP6j>; Wed, 12 Mar 2003 10:58:39 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:63467 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261766AbTCLP40>;
	Wed, 12 Mar 2003 10:56:26 -0500
Date: Wed, 12 Mar 2003 17:06:59 +0100
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andre Hedrick <andre@linux-ide.org>,
       scott thomason <scott-kernel@thomasons.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bio too big device
Message-ID: <20030312160658.GM834@suse.de>
References: <20030312085145.GJ811@suse.de> <Pine.LNX.4.10.10303120100490.391-100000@master.linux-ide.org> <20030312090943.GA3298@suse.de> <1047485697.22696.23.camel@irongate.swansea.linux.org.uk> <20030312151117.GH834@suse.de> <1047489166.22694.44.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1047489166.22694.44.camel@irongate.swansea.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 12 2003, Alan Cox wrote:
> On Wed, 2003-03-12 at 15:11, Jens Axboe wrote:
> > Then go with 128. I'd like to stress again that _if_ you get worse
> > performance it's not due to the request being a bit smaller, but indeed
> > because 248 can cause badly aligned requests.
> > 
> > > got the IDE layer using 256 block writes even if we have to limit it
> > > to more modern drives by some handwaving (8Gb+ say)
> > 
> > Does Windows use 256 sector requests or not? If not, then I'd sure don't
> > want to do it in Linux, the handwaving doesn't mean anything then.
> 
> I am told it does, Andre can you confirm this either way. If not then its
> time to ask vendors to confirm and any vendor who says "our drives are fine"
> we put on the ok list.

Well I can hook an analyzer to such a bastard and verify it for sure,
that's one way :)

If Windows does, then we have nothing to worry about.

-- 
Jens Axboe

