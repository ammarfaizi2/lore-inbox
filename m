Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264178AbTE0UeB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 16:34:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264126AbTE0Ucm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 16:32:42 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:34459
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264146AbTE0UcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 16:32:08 -0400
Date: Tue, 27 May 2003 22:45:19 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       manish <manish@storadinc.com>,
       Christian Klose <christian.klose@freenet.de>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
Message-ID: <20030527204519.GQ3767@dualathlon.random>
References: <3ED2DE86.2070406@storadinc.com> <200305272032.03645.m.c.p@wolk-project.de> <20030527201028.GJ3767@dualathlon.random> <200305272224.22567.m.c.p@wolk-project.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305272224.22567.m.c.p@wolk-project.de>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 27, 2003 at 10:24:22PM +0200, Marc-Christian Petersen wrote:
> I try to backport BIO and then AS for quite over 2 weeks now, but it seems, at 
> least for me, that it's an impossible mission ;(

bio breaks all drivers, not a good idea to backport ;)

note that the anticipatory scheduler generates very bad results with the
winmark. it certainly has merits but it has large downsides too.

I would be also curious if you could compare anticipatory with CFQ. The
CFQ was designed to provide the highest possible degree of fariness.

> > I'll try to find what's the precise reason of the interactivity drop
> cool. Thanks.
> 
> > with the 2.4.18->2.4.19 blkdev changes on Thu. I think I shortly looked
> > into it once but there was no definitive answer, or anyways going back
> > to the 2.4.18 code didn't appeal or make much sense.
> Yeah, that's not an option. The throughput has been increased in 2.4.19 
> compared to 2.4.18.

agreed.

> 
> > However I suspect this responsiveness issue could be storage hardware
> > dependent.
> Hmm, I am quite sure that it isn't. I have ton's of mostly totally different 
> hardware in my company, also test machines for WOLK at freenet.de (the 
> biggest I had was a QUAD Xeon 1GHz with 16GB memory and hardware RAID (Compaq 
> ML570 to be exact (f*cking nice machine btw. ;) and I even hit it on that 
> machine. Friends of mine having also different hardware then me, also hitting 
> that bug. _If_ it's the case of storage hardware, then many storage hardware 
> is affected ;)

;)

> > The sentence by Linus in the last few days while talking with Jens,
> > about storage that reorders stuff and starve requests at the two ends of
> > the platter was very scary, maybe you're really bitten by something like
> > that. Linux does the right thing but your hardware keeps posting stuff
> > under the os and mine doesn't.
> Oh, did I miss something at lkml or was it privately?

I read it on l-k yesterday a few days ago, search emails from Linus with
Jens somewhere in CC and you should find it.

Andrea
