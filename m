Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267180AbUJISBG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267180AbUJISBG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 14:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267259AbUJISBG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 14:01:06 -0400
Received: from pop.gmx.de ([213.165.64.20]:35733 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S267180AbUJISBC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 14:01:02 -0400
X-Authenticated: #4399952
Date: Sat, 9 Oct 2004 20:16:16 +0200
From: Florian Schmidt <mista.tapas@gmx.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       "K.R. Foley" <kr@cybsft.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@raytheon.com,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc3-mm3-T3
Message-ID: <20041009201616.5e0d2f8e@mango.fruits.de>
In-Reply-To: <20041007105230.GA17411@elte.hu>
References: <20040921071854.GA7604@elte.hu>
	<20040921074426.GA10477@elte.hu>
	<20040922103340.GA9683@elte.hu>
	<20040923122838.GA9252@elte.hu>
	<20040923211206.GA2366@elte.hu>
	<20040924074416.GA17924@elte.hu>
	<20040928000516.GA3096@elte.hu>
	<20041003210926.GA1267@elte.hu>
	<20041004215315.GA17707@elte.hu>
	<20041005134707.GA32033@elte.hu>
	<20041007105230.GA17411@elte.hu>
X-Mailer: Sylpheed-Claws 0.9.12a (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Oct 2004 12:52:30 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> 
> i've released the -T3 VP patch:
> 
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc3-mm3-T3

Hi,

i just wanted to report that audio usage has been become quite a bit worse
when compared to T1. I get more xruns (40 to 80 per night as opposed to 5 to
10 on T1), RT apps like ardour seem to be much more unstable with T3 than T1
(ardour gets kicked off the jack graph regularly at 64 frames on T3 which
doesn't happen with T1).

This goes together with a general increase of > 200us non preempt. crit.
sect. which were very seldom in T1 (at loeast for the work i do) but appear
rather regularly in T3.


Flo

P.S.: Are there tools available which can check the "correctness" of the
interplay of nptl libc and kernel wrt to threading? Especially when it comes
to wakeup order of blocking threads in different scheduler classes and with
different priorities.
