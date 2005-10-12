Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751480AbVJLSAB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751480AbVJLSAB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 14:00:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751482AbVJLSAB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 14:00:01 -0400
Received: from xproxy.gmail.com ([66.249.82.197]:10958 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751480AbVJLSAB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 14:00:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GDKS6hXG7bnijUb2BZH7R95yZ2S03SIYpdA3ICnHj/xmZn87pgMjWBypnB3nONuBkEM4YQDyz/qUF5FK4iUskBWRlQ574a7MWK42N3EwW6nW+jebqook23goklflV2GVRBiE3Nj1hueqFXF6EZNFotQ3BMsXNeQd7yzNbZN5qKo=
Message-ID: <5bdc1c8b0510121100o11e0e28ft4b532ba43e170774@mail.gmail.com>
Date: Wed, 12 Oct 2005 11:00:00 -0700
From: Mark Knecht <markknecht@gmail.com>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: 2.6.14-rc4-rt1
Cc: Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, dwalker@mvista.com,
       david singleton <dsingleton@mvista.com>
In-Reply-To: <1129139304.10599.15.camel@mindpipe>
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
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/05, Lee Revell <rlrevell@joe-job.com> wrote:
> On Wed, 2005-10-12 at 09:37 -0700, Mark Knecht wrote:
> > On 10/11/05, Lee Revell <rlrevell@joe-job.com> wrote:
> > > On Tue, 2005-10-11 at 14:13 -0700, Mark Knecht wrote:
> > > > The machine had been essentially 'User space idle' for the previous
> > > > two hours. The screen saver had kicked in. Audio was running and the
> > > > machine was busy. I woke it up, gave xscreensaver my password, read
> > > > email, sent the previous mail, then picked up the telephone to make a
> > > > call. Not 2 seconds later the xruns occurred!
> > >
> > > So what does /proc/latency_trace report?
> > >
> > > Lee
> >
> > Well, unfortunately it doesn't appear to report anythign helpful. The
> > maximum latency report did not change when the xrun occurred. This was
> > the last one reported and it happened long before the xrun:
>
> Sounds like an application bug (some JACK client doing something not RT
> safe).  Can you reproduce the xruns if you just run jackd with no
> clients?

I don't know. These xruns take hours to generate. I'd probably have to
dedicate a whole day of doing nothing on the machine to try, and then
if I didn't produce anything I'm not sure what it proves. If I do get
one then we get to see if there's data.

I'd really like to do the IRQ-off tests that you do before I go that
direction but unfortunately it's broken very badly since yesterday's
-rt1 release.

Maybe a better path to take would just be pushing the machine harder.
Do some real work in Ardour. Build up a big session and let it rip for
a while and see what that produces?

I don't know really.

- Mark
