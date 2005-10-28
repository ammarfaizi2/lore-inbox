Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965075AbVJ1E1R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965075AbVJ1E1R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 00:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965077AbVJ1E1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 00:27:17 -0400
Received: from mail06.syd.optusnet.com.au ([211.29.132.187]:38889 "EHLO
	mail06.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S965075AbVJ1E1Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 00:27:16 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
Subject: Re: The "best" value of HZ
Date: Fri, 28 Oct 2005 14:29:39 +1000
User-Agent: KMail/1.8.3
Cc: Lee Revell <rlrevell@joe-job.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Claudio Scordino <cloud.of.andor@gmail.com>,
       linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
References: <200510280118.42731.cloud.of.andor@gmail.com> <1130471136.4363.29.camel@mindpipe> <9a8748490510272100u453e73e3mc957a673eeb8498e@mail.gmail.com>
In-Reply-To: <9a8748490510272100u453e73e3mc957a673eeb8498e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510281429.39532.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Oct 2005 02:00 pm, Jesper Juhl wrote:
> On 10/28/05, Lee Revell <rlrevell@joe-job.com> wrote:
> > On Fri, 2005-10-28 at 03:31 +0100, Alistair John Strachan wrote:
> > > On Friday 28 October 2005 00:18, Claudio Scordino wrote:
> > > > Hi,
> > > >
> > > >     during the last years there has been a lot of discussion about
> > > > the "best" value of HZ... On i386 was 100, then became 1000, and
> > > > finally was set to 250. I'm thinking to do an evaluation of this
> > > > parameter using different architectures.
> > > >
> > > > Has anybody thought to give the possibility to modify the value of HZ
> > > > at boot time instead of at compile time ? This would allow to easily
> > > > test different values on different machines and create a table
> > > > containing the "best" value for each architecture...  At this moment,
> > > > instead, we have to recompile the kernel for each different value :(
> > > >
> > > > Do you think there would be much work to do that ?
> > > > Do you think it would be a desired feature the knowledge of the best
> > > > value for each architecture with more precision ?
> > >
> > > Google for "dynticks". There's obviously an overhead associated with HZ
> > > not being a constant (the compiler cannot optimise many expressions),
> > > but the feature is being worked on nonetheless.
> >
> > Well Linus had the best idea in that thread (as usual) which was to
> > implement "dynamic ticks" by leaving HZ a constant, setting it to a high
> > value, and skipping ticks when idle.  Has there been any work in that
> > direction?
>
> i did a bit of work in that area, but the stuff I came up with never
> seemed to work right, so I dropped it.

It's all still in development at the moment but not far from being available 
again. We stood back a bit to make some structural changes before trying to 
make it ready for prime time.

Cheers,
Con
