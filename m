Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267974AbUJLWIa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267974AbUJLWIa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 18:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267993AbUJLWI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 18:08:29 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:50080
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S267974AbUJLWII (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 18:08:08 -0400
Subject: Re: [Ext-rt-dev] Re: [ANNOUNCE] Linux 2.6 Real Time Kernel
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Bill Huey <bhuey@lnxw.com>
Cc: dwalker@mvista.com, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, amakarov@ru.mvista.com,
       ext-rt-dev@mvista.com, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20041012211201.GA28590@nietzsche.lynx.com>
References: <41677E4D.1030403@mvista.com> <20041010084633.GA13391@elte.hu>
	 <1097437314.17309.136.camel@dhcp153.mvista.com>
	 <20041010142000.667ec673.akpm@osdl.org> <20041010215906.GA19497@elte.hu>
	 <1097517191.28173.1.camel@dhcp153.mvista.com>
	 <20041011204959.GB16366@elte.hu>
	 <1097607049.9548.108.camel@dhcp153.mvista.com>
	 <1097610393.19549.69.camel@thomas>
	 <20041012211201.GA28590@nietzsche.lynx.com>
Content-Type: text/plain
Organization: linutronix
Message-Id: <1097618415.19549.190.camel@thomas>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 13 Oct 2004 00:00:16 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-12 at 23:12, Bill Huey wrote:
> My tree is stable. I was able to hammer this machine for 2-3 days straight
> (no networking, that's another major can of worms) with deadlocking
> using multipule mass "find / -exec egrep" of some sort that stress both
> process creation and all parts of the IO system.

He, a system without networking is a real measurement ? Ever heard of
hackbench in combination with ping -f ?

> That graph that I saw from Lee is consistent with my results in that a
> deadlock prone system will have phenomenal latency performance at the
> expense of being absolutely incorrect. It's just a flat out broken
> system at this point that they've released.

Thats a major problem caused by "dumb" priority inheritence. The goal is
not priority inheritence at the very end. It's proxy execution, where
priority inheritence is a subset.

> > This could be done in a first step and then it is clearly identifiable
> > and it gives us more flexibility to wrap different implementations and
> > lets us change particular points in a more clear way.
> 
> Yes, I agree, but the convention needs to be standardized.

That's all I was talking about.

> > I would be willing to provide some scripted conversion aid, if there is
> > enough interest to that. I started with some test files and the results
> > are quite encouraging.
> 
> No, all of this can only be manual at this time, either through static
> analysis by a compiler, like what Ingo did over the weekend or by hand
> with runtime sleep violation checks.

I'm not talking about automatic conversion of rules. I'm talking about
automatic conversion of different concurrency controls into a
equivillance function, which lets you better identify the neccecary
manual changes and leaves room for simple and non intrusive replacement
implementations.

> Give me a bit of time to upload those files. I was just given permission
> to talk about this openly now. But I can definitely tell you that I had
> this running months before Monta Vista's announcement over the weekend.

There are a bunch of other efforts underway around the world, which
might be concentrated now into one.

tglx


