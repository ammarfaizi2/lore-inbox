Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423137AbWCXFCL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423137AbWCXFCL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 00:02:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423133AbWCXFCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 00:02:11 -0500
Received: from mail.gmx.net ([213.165.64.20]:59319 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1423137AbWCXFCJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 00:02:09 -0500
X-Authenticated: #14349625
Subject: Re: [interbench numbers] Re: interactive task starvation
From: Mike Galbraith <efault@gmx.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Willy Tarreau <willy@w.ods.org>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       bugsplatter@gmail.com, Peter Williams <pwil3058@bigpond.net.au>
In-Reply-To: <200603241121.02868.kernel@kolivas.org>
References: <1142592375.7895.43.camel@homer> <1143093229.9303.1.camel@homer>
	 <1143112045.9065.15.camel@homer>  <200603241121.02868.kernel@kolivas.org>
Content-Type: text/plain
Date: Fri, 24 Mar 2006 06:02:30 +0100
Message-Id: <1143176550.7713.23.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-24 at 11:21 +1100, Con Kolivas wrote:
> On Thursday 23 March 2006 22:07, Mike Galbraith wrote:
> > Nothing conclusive.  Some of the difference may be because interbench
> > has a dependency on the idle sleep path popping tasks in a prio 16
> > instead of 18.  Some of it may be because I'm not restricting IO, doing
> > that makes a bit of difference.  Some of it is definitely plain old
> > jitter.
> 
> Thanks for those! Just a clarification please
> 
> > virgin
> 
> I assume 2.6.16-rc6-mm2 ?

Yes.

> 
> > throttle patches with throttling disabled
> 
> With your full patchset but no throttling enabled?

Yes.

> 
> > minus idle sleep
> 
> Full patchset -throttling-idlesleep ?

Yes, using stock idle sleep bits.

> 
> > minus don't restrict IO
> 
> Full patchset -throttling-idlesleep-restrictio ?
> 

Yes.

> Can you please email the latest separate patches so we can see them in 
> isolation? I promise I won't ask for any more interbench numbers any time 
> soon :)

I've separated the buglet fix parts from the rest, so there are four
patches instead of two.  I've also hidden the knobs, though for the
testing phase at least, I personally think it would be better to leave
the knobs there for people to twiddle.  Something Willy said indicated
to me that 'credit' would be more palatable than 'grace', so I've
renamed and updated comments to match.  I think it might look better,
but can't know since 'grace' was perfectly fine for my taste buds ;-)

I'll post as soon as I do some more cleanup pondering and verification.

	-Mike

