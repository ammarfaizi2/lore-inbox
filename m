Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750760AbWKBARh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbWKBARh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 19:17:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751003AbWKBARh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 19:17:37 -0500
Received: from smtp.osdl.org ([65.172.181.4]:2028 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750760AbWKBARg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 19:17:36 -0500
Date: Wed, 1 Nov 2006 16:17:23 -0800
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Gautham Shenoy <ego@in.ibm.com>
Subject: Re: Remove hotplug cpu crap from cpufreq.
Message-Id: <20061101161723.f132d208.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0611011507480.25218@g5.osdl.org>
References: <20061101225925.GA17363@redhat.com>
	<Pine.LNX.4.64.0611011507480.25218@g5.osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Nov 2006 15:09:52 -0800 (PST)
Linus Torvalds <torvalds@osdl.org> wrote:

> 
> 
> On Wed, 1 Nov 2006, Dave Jones wrote:
> >
> > I've had it with this stuff.  For months, we've had various warnings
> > popping up from this code (which was clearly half-baked at best when it
> > went in).
> > 
> > Until someone steps up who actually gives a damn about fixing it, can
> > we just rip this crap out so I stop getting mails from users who couldn't
> > care less about CPU hotplug anyway?
> 
> Hmm. People _have_ given a damn, and I think you were even cc'd.

I don't think Gautham cares about cpufreq-vs-hotplug per-se.  He cares
about the crappy cpufreq code and the warnings it emits.

> Did you take a look at the 5-patch (or was it 6?) series by Gautham R 
> Shenoy <ego@in.ibm.com>? I'm cc'ing him, in case you weren't on the 
> original list, and he should talk to you ;)

Gautham's work is "add lots of complex machinery so cpufreq's existing crap
works as it was supposed to".  We end up with complex machinery as well as
crappy cpufreq.

The alternative is to rip all that stuff out of cpufreq and then go back
and reimplement cpufreq cpu-hotplug safety from scratch.

> Right now, for 2.6.19, I'd prefer to not touch that mess unless there are 
> known conditions that actually cause more problems than just stupid 
> warnings..

afaik the warnings are the only symptom.
