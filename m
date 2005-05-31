Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261791AbVEaCFC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261791AbVEaCFC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 22:05:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261821AbVEaCFC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 22:05:02 -0400
Received: from smtp.lnxw.com ([207.21.185.24]:51473 "EHLO smtp.lnxw.com")
	by vger.kernel.org with ESMTP id S261791AbVEaCE6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 22:04:58 -0400
Date: Mon, 30 May 2005 19:09:57 -0700
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: "Bill Huey (hui)" <bhuey@lnxw.com>, James Bruce <bruce@andrew.cmu.edu>,
       Andi Kleen <ak@muc.de>, Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
Message-ID: <20050531020957.GA10814@nietzsche.lynx.com>
References: <20050527233645.GA2283@nietzsche.lynx.com> <4297EB57.5090902@yahoo.com.au> <20050528054503.GA2958@nietzsche.lynx.com> <42981467.6020409@yahoo.com.au> <4299A98D.1080805@andrew.cmu.edu> <429ADEDD.4020805@yahoo.com.au> <429B1898.8040805@andrew.cmu.edu> <429B2160.7010005@yahoo.com.au> <20050530222747.GB9972@nietzsche.lynx.com> <429BBC2D.70406@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <429BBC2D.70406@yahoo.com.au>
User-Agent: Mutt/1.5.9i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2005 at 11:21:49AM +1000, Nick Piggin wrote:
> Bill Huey (hui) wrote:
> >That's an RT begineer's question. You have to at least be up to speed
> >in that one to have the conversation at hand and folks have discussed
> >this repeatedly. It's not our end that failing and clearly you not
> >understanding this only reenforces this point..
...
> Bill, you can belittle me to your heart's content. It really
> doesn't bother me in the slightest.

It's not belittling, but venting my frustration at you not
understanding what I'm saying with an escalating ramp of force, jerk. :)

> Whenever you or anyone else try to complicate the Linux kernel
> with hard-RT stuff, I'm going to ask exactly the same questions
> because I don't think you know how a nanokernel solution would
> work, or even what kind of services a hard-RT Linux would need
> to provide.

Well, depends on the scope of the thing we're talking about. If
you mean pervasively throughout the kernel for every system, then
no at first if ever. If you mean for what the nanokernels are
commonly used for then, yes.  We're quite close to that already
to be hard real time if you just trust eyeballing the core kernel
code. The remaining problems have been pretty much partitioned to
fringe file system logic, some networking code and things outside
of the core kernel (kernel/ generally). They'll have to be surveyed
and hammered manually. All other points, if you trust eyeballing,
should run within an interrupt plus a thread to enable if assuming
you're not runing within an interrupt/preempt off section.

Theorem proven kernels are another matter altogether, but in all
practicality we're very close to hard real time. Calling it soft
real time isn't exactly accurate too, but the thrust to get
theorem proven RT kernels recently has made the definitions more
rigid in this discussion, probably overly so. Linux will probably
never be submitted to any prover to do attain that. Very few,
(only one product of ours that I know of LynxOS 178) have taking
on that provability track. This is a highly competitive field.

There's many things being discussed. The original examples I've
given probably clouded things for you when I ment it to be clear
problem by setting the most extreme examples. Really, the problems
are more complicated than that and really are quite varied. But
the first step is to get at CPU resources in a deterministic
manner at first, the rest, in what ever form, comes later.

Food time :)

bill

