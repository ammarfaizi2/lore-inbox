Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269289AbUJKWSp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269289AbUJKWSp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 18:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269299AbUJKWSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 18:18:44 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:6615 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S269289AbUJKWRo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 18:17:44 -0400
Subject: Re: [Lse-tech] Re: [PATCH] cpusets - big numa cpu and memory
	placement
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Paul Jackson <pj@sgi.com>
Cc: frankeh@watson.ibm.com, Rick Lindsley <ricklind@us.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Simon.Derr@bull.net,
       pwil3058@bigpond.net.au, dipankar@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, ckrm-tech@lists.sourceforge.net,
       efocht@hpce.nec.com, LSE Tech <lse-tech@lists.sourceforge.net>,
       hch@infradead.org, steiner@sgi.com, Jesse Barnes <jbarnes@sgi.com>,
       sylvain.jeaugey@bull.net, djh@sgi.com,
       LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       sivanich@sgi.com
In-Reply-To: <20041009130808.70c56ea3.pj@sgi.com>
References: <20041007015107.53d191d4.pj@sgi.com>
	 <200410071053.i97ArLnQ011548@owlet.beaverton.ibm.com>
	 <20041007072842.2bafc320.pj@sgi.com> <4165A31E.4070905@watson.ibm.com>
	 <20041008061426.6a84748c.pj@sgi.com> <4166B569.60408@watson.ibm.com>
	 <20041008112319.63b694de.pj@sgi.com> <1097283613.6470.146.camel@arrakis>
	 <20041009130808.70c56ea3.pj@sgi.com>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1097532989.4038.61.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 11 Oct 2004 15:16:29 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-10-09 at 13:08, Paul Jackson wrote:
> Matthew, responding to Paul:
> > > If for whatever reason, you don't think it is worth the effort to morph
> > > the virtual resouce manager that is currently embedded within CKRM into
> > > an independent, neutral framework, then don't expect the rest of us to
> > > embrace it.  Do you think Reiser would have gladly used vfs to plug in
> > > his file system if it had been called "ext"?  In my personal opinion, it
> > > would be foolhardy for SGI, NEC, Bull, Platform (LSF) or Altair (PBS) to
> > > rely on critical technology so clearly biased toward and dominated by a
> > > natural competitor.
> > 
> > I don't think that is terribly fair.  I can honestly say that I'm not
> > opposing your implementation because of who you work for. 
> 
> Good point.  I was painting with too wide a brush (hmmm ... someday I
> should see if I can get through an entire post without an analogy ...)

Doubtful.  I've read too many of your posts to think that it's very
likely! ;)


> My suggestion to separate the virtual resource management framework
> (which I named 'vrm') from CKRM's other elements, such as fair share
> scheduling, was an attempt to establish such a minimum verifiable
> deliverable.  That suggestion was clearly dead on arrival.

My (completely uninformed) guess is that the CKRM folks thought it would
be extremely unlikely to be able to get the 'vrm' into the kernel
without something to use it.  Linus, and the rest of the community, has
been understandably reluctant to pick up large chunks of code on the
assurance that "someone, someday will use these hooks".  The fair share
scheduler is thus both a proof of concept that the 'vrm' works and a
user of the 'vrm'.  The 'vrm' and the fair share scheduler, should be
logically separate pieces of code, though.  I should *really* read
through the CKRM code before I continue any further as I am purely
speculating now...


> My apologies for implicating everyone whose email ends in "ibm.com" in
> my earlier comment.  IBM is a big place, and all manner and variety
> of people work there.  It's a pleasure working with yourself, Matthew,
> and many others from IBM.

Apology accepted, Paul.  IBM is a large company, and this thread in
particular has had many @ibm.com posters.  It can seem there is some
large IBM conspiracy to block your efforts, but I can assure you that
isn't the case.  Unless the small, painless chips on the backs of our
necks are working far better than I think they do.... :)

-Matt

