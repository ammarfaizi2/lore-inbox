Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274652AbRITVLI>; Thu, 20 Sep 2001 17:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274649AbRITVK7>; Thu, 20 Sep 2001 17:10:59 -0400
Received: from smtp10.atl.mindspring.net ([207.69.200.246]:7691 "EHLO
	smtp10.atl.mindspring.net") by vger.kernel.org with ESMTP
	id <S274654AbRITVKy>; Thu, 20 Sep 2001 17:10:54 -0400
Subject: Re: [PATCH] Preemption Latency Measurement Tool
From: Robert Love <rml@tech9.net>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Dieter =?ISO-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Roger Larsson <roger.larsson@norran.net>, linux-kernel@vger.kernel.org,
        ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <20010920102139.G729@athlon.random>
In-Reply-To: <1000939458.3853.17.camel@phantasy>
	<20010920063143.424BD1E41A@Cantor.suse.de>
	<20010920084131.C1629@athlon.random>
	<20010920075751.6CA791E6B2@Cantor.suse.de> 
	<20010920102139.G729@athlon.random>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Evolution-Format: text/plain
X-Mailer: Evolution/0.13.99+cvs.2001.09.19.21.54 (Preview Release)
Date: 20 Sep 2001 17:10:48 -0400
Message-Id: <1001020249.6048.152.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2001-09-20 at 04:21, Andrea Arcangeli wrote:
> > You've forgotten a one liner.
> > 
> >   #include <linux/locks.h>
> > +#include <linux/compiler.h>
> 
> woops, didn't trapped it because of gcc 3.0.2. thanks.
> 
> > But this is not enough. Even with reniced artsd (-20).
> > Some shorter hiccups (0.5~1 sec).
> 
> I'm not familiar with the output of the latency bench, but I actually
> read "4617" usec as the worst latency, that means 4msec, not 500/1000
> msec.

Right, the patch is returning the length preemption was unavailable
(which is when a lock is held) in us. So it is indded 4ms.

But, I think Dieter is saying he _sees_ 0.5~1s latencies (in the form of
audio skips).  This is despite the 4ms locks being held.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

