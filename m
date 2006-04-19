Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750797AbWDSIh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbWDSIh2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 04:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbWDSIh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 04:37:27 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:8098 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1750797AbWDSIh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 04:37:26 -0400
Date: Wed, 19 Apr 2006 10:37:24 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: Al Boldi <a1426z@gawab.com>, ck list <ck@vds.kolivas.org>,
       Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: [ck] Re: [patch][rfc] quell interactive feeding frenzy
Message-ID: <20060419083724.GA7329@rhlx01.fht-esslingen.de>
References: <200604112100.28725.kernel@kolivas.org> <200604160923.00047.kernel@kolivas.org> <20060416184426.GA15642@rhlx01.fht-esslingen.de> <200604171008.10067.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604171008.10067.kernel@kolivas.org>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Apr 17, 2006 at 10:08:08AM +1000, Con Kolivas wrote:
> On Monday 17 April 2006 04:44, Andreas Mohr wrote:
> > Hi,
> >
> > On Sun, Apr 16, 2006 at 09:22:59AM +1000, Con Kolivas wrote:
> > > The current value, 6ms at 1000HZ, is chosen because it's the largest
> > > value that can schedule a task in less than normal human perceptible
> > > range when two competing heavily cpu bound tasks are the same priority.
> > > At 250HZ it works out to 7.5ms and 10ms at 100HZ. Ironically in my
> > > experimenting I found the cpu cache improvements become much less
> > > significant above 7ms so I'm very happy with this compromise.
> >
> > Heh, this part is *EXACTLY* a fully sufficient explanation of what I was
> > wondering about myself just these days ;)
> > (I'm experimenting with different timeslice values on my P3/450 to verify
> > what performance impact exactly it has)
> > However with a measly 256kB cache it probably doesn't matter too much,
> > I think.
> >
> > But I think it's still important to mention that your perception might be
> > twisted by your P4 limitation (no testing with slower and really slow
> > machines).
> 
> You underestimate me. Those cpu cache effects were performance effects 
> measured down to a PII 233, but all were i386 architecture. As for 
> "perception" this isn't my testing I'm talking about; these are 
> neuropsychiatric tests that have nothing to do with pcs or what processor you 
> use ;)

OK, but I was not worrying about the interactivity aspects, rather the
performance aspects (GUI updates of KDE 3.5.2 on P3/450/256MB on Ubuntu are
about as slow as medium-hot lava). While of course it's mostly KDE (and
probably also the S3 Savage driver/card) which is to blame here,
I'm trying to first do as much as possible at kernel level before eventually
going higher up the chain...

Andreas
