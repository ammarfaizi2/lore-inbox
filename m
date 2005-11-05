Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751187AbVKEDqZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbVKEDqZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 22:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbVKEDqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 22:46:25 -0500
Received: from xproxy.gmail.com ([66.249.82.196]:39315 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751187AbVKEDqY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 22:46:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=S6BKN7GJxgDQaONICWt9suSMUAFwu0LCd7BHBF34PswLvfJoz979sEqV5I/Qn6fI8HqlLii2EILjN+lcxk+7u8K6aq2winHONWrrRhuxH0AYA5C+kxuE/XQ/T8rhef+EncC/mY+g2h3dJ97hU5PDXn4ev8n/z4+zfJ3VfEfDRIM=
Message-ID: <5bdc1c8b0511041946m542d9ff0o9b405ad87f90761d@mail.gmail.com>
Date: Fri, 4 Nov 2005 19:46:23 -0800
From: Mark Knecht <markknecht@gmail.com>
To: Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>
Subject: Re: 2.6.14-rt1 (now rt6)
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, john stultz <johnstul@us.ibm.com>,
       Florian Schmidt <mista.tapas@gmx.net>, "K.R. Foley" <kr@cybsft.com>,
       Rui Nuno Capela <rncbc@rncbc.org>
In-Reply-To: <1131158124.4834.24.camel@cmn3.stanford.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051017160536.GA2107@elte.hu> <20051020195432.GA21903@elte.hu>
	 <20051030133316.GA11225@elte.hu>
	 <1131158124.4834.24.camel@cmn3.stanford.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/4/05, Fernando Lopez-Lezcano <nando@ccrma.stanford.edu> wrote:
> On Sun, 2005-10-30 at 14:33 +0100, Ingo Molnar wrote:
> > i have released the 2.6.14-rt1 tree, which can be downloaded from the
> > usual place:
> >
> >    http://redhat.com/~mingo/realtime-preempt/
> >
> > this release is mainly about ktimer fixes: it updates to the latest
> > ktimer tree from Thomas Gleixner (which includes John Stultz's latest
> > GTOD tree), it fixes TSC synchronization problems on HT systems, and
> > updates the ktimers debugging code.
> >
> > These together could fix most of the timer warnings and annoyances
> > reported for 2.6.14-rc5-rt kernels. In particular the new
> > TSC-synchronization code could fix SMP systems: the upstream TSC
> > synchronization method is fine for 1 usec resolution, but it was not
> > good enough for 1 nsec resolution and likely caused the SMP bugs
> > reported by Fernando Lopez-Lezcano and Rui Nuno Capela.
> >
> > Please re-report any bugs that remain.
>
> I've been running 2.6.14-rt6 fine in my smp system the whole day and
> suddenly, just a moment ago, I suddenly started getting key repeats and
> screensaver bliiiinks [not my typo]. No HIGH_RES_TIMERS, with
> PREEMPT_RT. No messages in the logs or dmesg.

This sounds so familiar and similar to me, but with such a different
presentation. I ran about 15 hours yesterday with no xruns. Suddenly
at the end of the day I get about 8. I start up again this morning,
get two almost immediately, and then run the rest of the day with
none.

No HIGH_RES_TIMERS, with RT_PREEMPT.

Very strange.

Yesterday was 2.6.14-rt4. Today was -rt6.

- Mark
