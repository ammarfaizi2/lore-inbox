Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262215AbRE3VCI>; Wed, 30 May 2001 17:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262239AbRE3VB6>; Wed, 30 May 2001 17:01:58 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:55303 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S262215AbRE3VBv>; Wed, 30 May 2001 17:01:51 -0400
Date: Wed, 30 May 2001 16:25:31 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: Rik van Riel <riel@conectiva.com.br>,
        Jonathan Morton <chromi@cyberspace.org>,
        Craig Kulesa <ckulesa@as.arizona.edu>, linux-kernel@vger.kernel.org
Subject: Re: Plain 2.4.5 VM
In-Reply-To: <Pine.LNX.4.33.0105302225010.418-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.21.0105301612570.5231-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 30 May 2001, Mike Galbraith wrote:

> On Wed, 30 May 2001, Rik van Riel wrote:
> 
> > On Wed, 30 May 2001, Marcelo Tosatti wrote:
> >
> > > The problem is that we allow _every_ task to age pages on the system
> > > at the same time --- this is one of the things which is fucking up.
> >
> > This should not have any effect on the ratio of cache
> > reclaiming vs. swapout use, though...
> 
> It shouldn't.. but when many tasks are aging, it does. 

What Rik means is that they are independant problems.

> Excluding these guys certainly seems to make a difference.  

Sure, those guys are going to "help" kswapd to unmap pte's and allocate
swap space.

Now even if only kswapd does this job (meaning a sane amount of cache
reclaims/swapouts), you still have to deal with the reclaim/swapout
tradeoff.

See? 

