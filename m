Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262660AbRFQTWI>; Sun, 17 Jun 2001 15:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262674AbRFQTV7>; Sun, 17 Jun 2001 15:21:59 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:12296
	"EHLO Opus.bloom.county") by vger.kernel.org with ESMTP
	id <S262660AbRFQTVu>; Sun, 17 Jun 2001 15:21:50 -0400
Date: Sun, 17 Jun 2001 12:20:33 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4 VM & swap question
Message-ID: <20010617122033.F11642@opus.bloom.county>
In-Reply-To: <20010617104836.B11642@opus.bloom.county> <20010617221239.B1027@spiral.extreme.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010617221239.B1027@spiral.extreme.ro>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 17, 2001 at 10:12:39PM +0300, Dan Podeanu wrote:
> On Sun, Jun 17, 2001 at 10:48:36AM -0700, Tom Rini wrote:
> > 'lo all.  I've got a question about swap and RAM requirements in 2.4.  Now,
> > when 2.4.0 was kicked out, the fact that you need swap=2xRAM was mentioned.
> > But what I'm wondering is what exactly are the limits on this.  Right now
> > I've got an x86 box w/ 128ram and currently 256swap.  When I had 128, I'd get
> > low on ram/swap after some time in X, and doing this seems to 'fix' it, in
> > 2.4.4.  However, I've also got 2 PPC boxes, both with 256:256 in 2.4.  One
> > of which never has X up, but lots of other activity, and swap usage seems
> > to be about the same as 2.2.x (right now 'free' says i'm ~40MB into swap,
> > 18day+ uptime).  The other box is a laptop and has X up when it's awake and
> > that too doesn't seem to have any problem.  So what exactly is the real
> > minium swap ammount?
> 
> I doubt there is a limit. I think 'it depends on what you're planning
> to do' is the correct answer. For a blank router, 32mb ram/64 swap can
> be enough, for a web/database server, you need more, etc.

Yes, I know there's no hard and fast rule for the exact ammount of ram/swap one
needs that will always work.  However, in 2.2 for a 'workstation' one could
usually quite happily get away with having 128:128 and never have much of a
problem.  with 2.4.0 and up this isn't the case.  This has been the cause
of many people complaining quite loudly about 2.4 VM sucking and having
lots of OOM kills going about.  It's also been called an 'aritificial limit'
since one of the VM people had a patch to 'fix' this.  What I'm trying to
figure out is if this problem exists linearly or just with 'lower' ammounts
of total physical ram.  ie if I jump up to 512mb and don't have a webserver
or database (ie I've got 512mb so I end up with a big disk cache) will I need
to have 1gb of swap just to keep the VM happy?  Will 256 be enough?  Could I
even live w/o swap?

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
