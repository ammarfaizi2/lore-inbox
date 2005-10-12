Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751494AbVJLSZx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751494AbVJLSZx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 14:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751490AbVJLSZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 14:25:53 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:65509 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751494AbVJLSZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 14:25:52 -0400
Subject: Re: 2.6.14-rc4-rt1
From: Lee Revell <rlrevell@joe-job.com>
To: Mark Knecht <markknecht@gmail.com>
Cc: Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, dwalker@mvista.com,
       david singleton <dsingleton@mvista.com>
In-Reply-To: <5bdc1c8b0510121100o11e0e28ft4b532ba43e170774@mail.gmail.com>
References: <20051011111454.GA15504@elte.hu>
	 <1129064151.5324.6.camel@cmn3.stanford.edu>
	 <5bdc1c8b0510111408n4ef45eadv1e12ec4d1271d971@mail.gmail.com>
	 <5bdc1c8b0510111413q7b1ea391n3bc27924d928b963@mail.gmail.com>
	 <1129065696.4718.10.camel@mindpipe>
	 <5bdc1c8b0510120937r45bbd26fr6f45b6e3a9895d3f@mail.gmail.com>
	 <1129139304.10599.15.camel@mindpipe>
	 <5bdc1c8b0510121100o11e0e28ft4b532ba43e170774@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 12 Oct 2005 14:25:47 -0400
Message-Id: <1129141547.11297.4.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-10-12 at 11:00 -0700, Mark Knecht wrote:
> On 10/12/05, Lee Revell <rlrevell@joe-job.com> wrote:
> > Sounds like an application bug (some JACK client doing something not RT
> > safe).  Can you reproduce the xruns if you just run jackd with no
> > clients?
> 
> I don't know. These xruns take hours to generate. I'd probably have to
> dedicate a whole day of doing nothing on the machine to try, and then
> if I didn't produce anything I'm not sure what it proves. If I do get
> one then we get to see if there's data.

A much easier solution is to recompile JACK with the
--enable-preemption-check option.  This activates the in-kernel
debugging mechanism that causes a stack dump when an RT task schedules.
It has been used to find tricky bugs in Hydrogen and Freqtweak already.

Lee

