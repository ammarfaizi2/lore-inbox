Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751711AbWIOUO1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751711AbWIOUO1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 16:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751703AbWIOUO1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 16:14:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23018 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751699AbWIOUO0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 16:14:26 -0400
Date: Fri, 15 Sep 2006 13:13:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: tglx@linutronix.de, karim@opersys.com, Paul Mundt <lethal@linux-sh.org>,
       Jes Sorensen <jes@sgi.com>, Roman Zippel <zippel@linux-m68k.org>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Tom Zanussi <zanussi@us.ibm.com>, ltt-dev@shafik.org,
       Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-Id: <20060915131317.aaadf568.akpm@osdl.org>
In-Reply-To: <20060915181907.GB17581@elte.hu>
References: <20060915132052.GA7843@localhost.usen.ad.jp>
	<Pine.LNX.4.64.0609151535030.6761@scrub.home>
	<20060915135709.GB8723@localhost.usen.ad.jp>
	<450AB5F9.8040501@opersys.com>
	<450AB506.30802@sgi.com>
	<450AB957.2050206@opersys.com>
	<20060915142836.GA9288@localhost.usen.ad.jp>
	<450ABE08.2060107@opersys.com>
	<1158332447.5724.423.camel@localhost.localdomain>
	<20060915111644.c857b2cf.akpm@osdl.org>
	<20060915181907.GB17581@elte.hu>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sep 2006 20:19:07 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Andrew Morton <akpm@osdl.org> wrote:
> 
> > What Karim is sharing with us here (yet again) is the real in-field 
> > experience of real users (ie: not kernel developers).
> 
> well, Jes has that experience and Thomas too.

systemtap and ltt are the only full-scale tracing tools which target
sysadmins and applciation developers of which I am aware..

> > I mean, on one hand we have people explaining what they think a 
> > tracing facility should and shouldn't do, and on the other hand we 
> > have a guy who has been maintaining and shipping exactly that thing to 
> > (paying!) customers for many years.
> 
> so does Thomas and Jes. So what's the point?

My point is that I respect Karim and Frank's experience.  I in fact
disagree with them (or at least, I want to).  But they've been there, and I
haven't.  So I listen.

> i judge LTT by its current code quality, not by its proponents shouting 
> volume - and that quality is still quite poor at the moment. (and then 
> there are the conceptual problems too, outlined numerous times) I have 
> quoted specific example(s) for that in this thread. Furthermore, LTT 
> does this:
> 
>  246 files changed, 26207 insertions(+), 71 deletions(-)
> 
> and this gives me the shivers, for all the reasons i outlined.
> 

In the bit of text which you snipped I was agreeing with this...

Look, if Karim and Frank (who I assume is a systemtap developer) think that
we need static tracepoints then I have no reason to disagree with them. 
What I would propose is that:

a) Those tracepoints be integrated one at a time on well-understood
   grounds of necessity.  Tracepoints _should_ be added dynamically.  But
   if there are instances where that's not working and cannot be made to
   work then OK, in we go.

b) Saying "we need the static tracepoints because the line numbers keep
   on changing" is not, repeat not a justification for static tracepoints. 
   It's a SMOP to develop tracepoint-adding code which can handle line
   numbers changing.  lwall did it.

c) Any static tracepoints should be seen as corner-case augmentation of
   existing dynamic tracing framework(s).  IOW: I see no justification at
   this time for adding complete new second set of backend
   accumulation/reporting/management infrastructure (ie: LTT core).


Shorter version: I agree with Frank.
