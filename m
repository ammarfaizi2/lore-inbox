Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274664AbRITVf3>; Thu, 20 Sep 2001 17:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274662AbRITVfT>; Thu, 20 Sep 2001 17:35:19 -0400
Received: from paloma13.e0k.nbg-hannover.de ([62.159.219.13]:20157 "HELO
	paloma13.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S274657AbRITVfA>; Thu, 20 Sep 2001 17:35:00 -0400
Content-Type: text/plain; charset=US-ASCII
From: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Robert Love <rml@tech9.net>, Andrea Arcangeli <andrea@suse.de>
Subject: Re: [PATCH] Preemption Latency Measurement Tool
Date: Thu, 20 Sep 2001 23:35:18 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Roger Larsson <roger.larsson@norran.net>, linux-kernel@vger.kernel.org,
        ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <1000939458.3853.17.camel@phantasy> <20010920102139.G729@athlon.random> <1001020249.6048.152.camel@phantasy>
In-Reply-To: <1001020249.6048.152.camel@phantasy>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010920213510Z274657-760+14618@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 20. September 2001 23:10 schrieb Robert Love:
> On Thu, 2001-09-20 at 04:21, Andrea Arcangeli wrote:
> > > You've forgotten a one liner.
> > >
> > >   #include <linux/locks.h>
> > > +#include <linux/compiler.h>
> >
> > woops, didn't trapped it because of gcc 3.0.2. thanks.
> >
> > > But this is not enough. Even with reniced artsd (-20).
> > > Some shorter hiccups (0.5~1 sec).
> >
> > I'm not familiar with the output of the latency bench, but I actually
> > read "4617" usec as the worst latency, that means 4msec, not 500/1000
> > msec.
>
> Right, the patch is returning the length preemption was unavailable
> (which is when a lock is held) in us. So it is indded 4ms.
>
> But, I think Dieter is saying he _sees_ 0.5~1s latencies (in the form of
> audio skips).  This is despite the 4ms locks being held.

Yes, that's the case. During dbench 16,32,40,48, etc...

-Dieter
