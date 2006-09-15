Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932131AbWIOSSt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131AbWIOSSt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 14:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932136AbWIOSSt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 14:18:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51403 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932131AbWIOSSs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 14:18:48 -0400
Date: Fri, 15 Sep 2006 11:16:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: tglx@linutronix.de
Cc: karim@opersys.com, Paul Mundt <lethal@linux-sh.org>,
       Jes Sorensen <jes@sgi.com>, Roman Zippel <zippel@linux-m68k.org>,
       Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Tom Zanussi <zanussi@us.ibm.com>, ltt-dev@shafik.org,
       Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-Id: <20060915111644.c857b2cf.akpm@osdl.org>
In-Reply-To: <1158332447.5724.423.camel@localhost.localdomain>
References: <20060914181557.GA22469@elte.hu>
	<4509A54C.1050905@opersys.com>
	<yq08xkleb9h.fsf@jaguar.mkp.net>
	<450A9EC9.9080307@opersys.com>
	<20060915132052.GA7843@localhost.usen.ad.jp>
	<Pine.LNX.4.64.0609151535030.6761@scrub.home>
	<20060915135709.GB8723@localhost.usen.ad.jp>
	<450AB5F9.8040501@opersys.com>
	<450AB506.30802@sgi.com>
	<450AB957.2050206@opersys.com>
	<20060915142836.GA9288@localhost.usen.ad.jp>
	<450ABE08.2060107@opersys.com>
	<1158332447.5724.423.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sep 2006 17:00:47 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Fri, 2006-09-15 at 10:51 -0400, Karim Yaghmour wrote:
> > And what I did is "b". I wasn't going to defend anybody else's
> > choice of tracepoints. Those who were using ltt for its designated
> > purpose -- allowing normal users and developers to get an accurate
> > view of the behavior of their system -- were very happy with it.
> > 
> > You want to know who was unhappy with using it: kernel developers.
> > It just wasn't geared for them. Which goes back to my earlier
> > arguments ...
> 
> What do you want to prove with this rant ? Simply the fact that your
> view of tracing is not matching the view of others. Nothing else.

What Karim is sharing with us here (yet again) is the real in-field
experience of real users (ie: not kernel developers).

I mean, on one hand we have people explaining what they think a tracing
facility should and shouldn't do, and on the other hand we have a guy who
has been maintaining and shipping exactly that thing to (paying!) customers
for many years.

Me thinks our time would be best spent trying to benefit from his
experience..


Me, I'm not particularly averse to some 50-100 static tracepoints if
experience tells us that we need such things.  And both Karim's and Frank's
experience does indicate that such things are needed, which carries weight.

What I _am_ concerned about with this patchset is all the infrastructural
goop which backs up those tracepoints.  I'd have thought that a better
approach would be to make those explicit tracepoints be "helpers" for the
existing kprobe code.

Of course, it they are properly designed, the one set of tracepoints could
be used by different tracing backends - that allows us to separate the
concepts of "tracepoints" and "tracing backends".
