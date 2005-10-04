Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964969AbVJDUtM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964969AbVJDUtM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 16:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964970AbVJDUtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 16:49:11 -0400
Received: from xproxy.gmail.com ([66.249.82.206]:51888 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964969AbVJDUtK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 16:49:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MXnTQ25wHEzHR8jl8HkAjIuq4E3m+1tQHFIgEWm5GEDJqsnIXNXAoEKbIwzDKtZu16HOgq9BvfDJRll8R1S7b535HGTLwMW+xdgdIoO6P4x9SZPMOp3J5h9jABHbg11ydUMBc9Bs74SGJB3FneB7H1pZsmTn3JObwCtNx4kpBvc=
Message-ID: <5bdc1c8b0510041349g1a4f2484qd17a11812c8ccac3@mail.gmail.com>
Date: Tue, 4 Oct 2005 13:49:09 -0700
From: Mark Knecht <markknecht@gmail.com>
Reply-To: Mark Knecht <markknecht@gmail.com>
To: tglx@linutronix.de
Subject: Re: 2.6.14-rc3-rt2
Cc: Steven Rostedt <rostedt@kihontech.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1128458707.13057.68.camel@tglx.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051004084405.GA24296@elte.hu> <43427AD9.9060104@cybsft.com>
	 <20051004130009.GB31466@elte.hu>
	 <5bdc1c8b0510040944q233f14e6g17d53963a4496c1f@mail.gmail.com>
	 <5bdc1c8b0510041111n188b8e14lf5a1398406d30ec4@mail.gmail.com>
	 <1128450029.13057.60.camel@tglx.tec.linutronix.de>
	 <5bdc1c8b0510041158m3620f5dcy2dafda545ad3cd5e@mail.gmail.com>
	 <1128458707.13057.68.camel@tglx.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/05, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Tue, 2005-10-04 at 11:58 -0700, Mark Knecht wrote:
> > > I guess its related to the priority leak I'm tracking down right now.
> > > Can you please set following config options and check if you get a bug
> > > similar to this ?
> > >
> > > BUG: init/1: leaked RT prio 98 (116)?
> > >
> > > Steven, it goes away when deadlock detection is enabled. Any pointers
>
> Thats actually a red hering caused by asymetric accounting which only
> happens when
>
> CONFIG_DEBUG_PREEMPT=y
> and
> # CONFIG_RT_DEADLOCK_DETECT is not set

OK. I'll keep testing then.

Are you asking me to apply the code you sent or is that for someone else?

Thanks,
Mark
