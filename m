Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318658AbSHAIGp>; Thu, 1 Aug 2002 04:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318661AbSHAIGp>; Thu, 1 Aug 2002 04:06:45 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:29162 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S318658AbSHAIGo>;
	Thu, 1 Aug 2002 04:06:44 -0400
Date: Thu, 1 Aug 2002 10:10:10 +0200
From: Jens Axboe <axboe@suse.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@zip.com.au>
Subject: Re: Linux v2.4.19-rc5
Message-ID: <20020801081010.GA1096@suse.de>
References: <20020801074953.GJ1644@suse.de> <Pine.LNX.4.44.0208010406230.1728-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208010406230.1728-100000@freak.distro.conectiva>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01 2002, Marcelo Tosatti wrote:
> 
> On Thu, 1 Aug 2002, Jens Axboe wrote:
> 
> > On Thu, Aug 01 2002, Marcelo Tosatti wrote:
> > > <akpm@zip.com.au> (02/08/01 1.663)
> > > 	[PATCH] disable READA
> >
> > Since -rc5 is not to be found yet, I don't know what version of this
> > made it in. Is READA just being disabled on SMP, or was it the general
> > #if 0 change that got included?
> 
> Its being disabled on UP and SMP. I dont like having such readahead IO
> mode working only for UP.

You are right, that would be ugly. Should only be the last resort.

> > I'm asking since plain disabling READA might have nasty performance
> > effects. Andrew, I bet you did some numbers on this, care to share?
> 
> If thats true (the performance effects) I'll release -final with IMO not
> very coherent READA semantics :)
> 
> Anyway, lets wait for the numbers.

It just 'feels' like the sort of change that might have odd side
effects.

-- 
Jens Axboe

