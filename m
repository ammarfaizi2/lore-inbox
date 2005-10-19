Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750827AbVJSL6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827AbVJSL6E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 07:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750832AbVJSL6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 07:58:04 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:64472 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750827AbVJSL6B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 07:58:01 -0400
Date: Wed, 19 Oct 2005 13:58:14 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Tim Bird <tim.bird@am.sony.com>, Andrew Morton <akpm@osdl.org>,
       tglx@linutronix.de, george@mvista.com, linux-kernel@vger.kernel.org,
       johnstul@us.ibm.com, paulmck@us.ibm.com, hch@infradead.org,
       oleg@tv-sign.ru
Subject: Re: [PATCH]  ktimers subsystem 2.6.14-rc2-kt5
Message-ID: <20051019115814.GB1580@elte.hu>
References: <Pine.LNX.4.61.0510171948040.1386@scrub.home> <4353F936.3090406@am.sony.com> <Pine.LNX.4.61.0510172138210.1386@scrub.home> <20051017201330.GB8590@elte.hu> <Pine.LNX.4.61.0510172227010.1386@scrub.home> <20051018084655.GA28933@elte.hu> <Pine.LNX.4.61.0510190311140.1386@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0510190311140.1386@scrub.home>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Roman Zippel <zippel@linux-m68k.org> wrote:

> > > > e.g. we dont want a watchdog from being 
> > > > overload-able via too many timeouts in the timer wheel ...
> > > 
> > > Please explain.
> > 
> > e.g. on busy networked servers (i.e. ones that do have a need for 
> > watchdogs) the timer wheel often includes large numbers of timeouts, 
> > 99.9% of which never expire. If they do expire en masse for whatever 
> > reason, then we can get into overload mode: a million timers might have 
> > to expire before we get to process the watchdog event and act upon it.  
> > This can delay the watchdog event significantly, which delay might (or 
> > might not) matter to the watchdog application.
> 
> I already mentioned earlier that it's possible to reduce the timer 
> load by using a watchdog timer to filter most of these events, so that 
> you get into the interesting situation that most kernel timer actually 
> do expire and suddenly you easily can have more "timers" than 
> "timeouts".

this sentence does not parse at all, for me. Here's the effort i did 
trying to decypher it:

Firstly, you mention 'watchdog' without clarifying whether it's the 
examplary watchdog we were talking about above, or whether it's some 
other, new mechanism. The former makes no sense (what does the watchdog 
timer in a random driver have to do with the millions of network timers 
i was talking about, and how could it be used to filter anything?), the 
later you dont explain.

Secondly, the above sentence is the first time in the ktimer discussion 
that you ever mentioned the word 'filter', and you never mentioned the 
word 'watchdog' outside of the example we were discussing, so i'm 
curious about the source of the above "I already mentioned earlier" 
statement. When earlier? Which email? Frankly, the whole paragraph reads 
as if from another planet, i see the words but the content seems totally 
out of context and makes no sense to me.

So i cannot even agree or disagree with anything you said in that 
sentence, because the sentence simply does not parse. Please enlighten 
me!

	Ingo
