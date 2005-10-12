Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932417AbVJLTLc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932417AbVJLTLc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 15:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932435AbVJLTLb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 15:11:31 -0400
Received: from xproxy.gmail.com ([66.249.82.200]:33257 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932417AbVJLTLb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 15:11:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=o46PilsneIEXjXRxgm9UNwEKGyYHiB8SGi1dVoXq3LmD1V1UvlMrqo/s/n2CLB/Fbi5Mi8K8zqze+4pzK1GBVO3x/SQKwcEyLkki4uILSjeogWV+8jUvxOWsz2+WJsgOZcuoefJyPiiFcyYbjv5DgORyW1H1dLDmgUpoHlxJvzQ=
Message-ID: <5bdc1c8b0510121211g5a46282fm2e34188875261bb7@mail.gmail.com>
Date: Wed, 12 Oct 2005 12:11:30 -0700
From: Mark Knecht <markknecht@gmail.com>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: 2.6.14-rc4-rt1
Cc: Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, dwalker@mvista.com,
       david singleton <dsingleton@mvista.com>
In-Reply-To: <1129142282.11410.7.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051011111454.GA15504@elte.hu>
	 <1129064151.5324.6.camel@cmn3.stanford.edu>
	 <5bdc1c8b0510111408n4ef45eadv1e12ec4d1271d971@mail.gmail.com>
	 <5bdc1c8b0510111413q7b1ea391n3bc27924d928b963@mail.gmail.com>
	 <1129065696.4718.10.camel@mindpipe>
	 <5bdc1c8b0510120937r45bbd26fr6f45b6e3a9895d3f@mail.gmail.com>
	 <1129139304.10599.15.camel@mindpipe>
	 <5bdc1c8b0510121100o11e0e28ft4b532ba43e170774@mail.gmail.com>
	 <1129141547.11297.4.camel@mindpipe>
	 <1129142282.11410.7.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/05, Lee Revell <rlrevell@joe-job.com> wrote:
> On Wed, 2005-10-12 at 14:25 -0400, Lee Revell wrote:
> > On Wed, 2005-10-12 at 11:00 -0700, Mark Knecht wrote:
> > > On 10/12/05, Lee Revell <rlrevell@joe-job.com> wrote:
> > > > Sounds like an application bug (some JACK client doing something not RT
> > > > safe).  Can you reproduce the xruns if you just run jackd with no
> > > > clients?
> > >
> > > I don't know. These xruns take hours to generate. I'd probably have to
> > > dedicate a whole day of doing nothing on the machine to try, and then
> > > if I didn't produce anything I'm not sure what it proves. If I do get
> > > one then we get to see if there's data.
> >
> > A much easier solution is to recompile JACK with the
> > --enable-preemption-check option.  This activates the in-kernel
> > debugging mechanism that causes a stack dump when an RT task schedules.
> > It has been used to find tricky bugs in Hydrogen and Freqtweak already.
>
> I should also remind you that if you pursue the
> --enable-preemption-check option, then we'll be well outside of kernel
> land so you might want to take it up on the JACK list.
>
Good point.

I've just built with this feature. I'll try it out for a while and ask
questions on that list while I'm configured this way.

Thanks for the idea.

Cheers,
Mark
