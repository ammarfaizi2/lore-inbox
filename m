Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265206AbTFYX23 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 19:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265178AbTFYX1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 19:27:18 -0400
Received: from 82-43-130-207.cable.ubr03.mort.blueyonder.co.uk ([82.43.130.207]:16862
	"EHLO efix.biz") by vger.kernel.org with ESMTP id S265188AbTFYX0C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 19:26:02 -0400
Subject: Re: AMD MP, SMP, Tyan 2466
From: Edward Tandi <ed@efix.biz>
To: Timothy Miller <miller@techsource.com>
Cc: joe briggs <jbriggs@briggsmedia.com>,
       Artur Jasowicz <kernel@mousebusiness.com>,
       Brian Jackson <brian@brianandsara.net>,
       Bart SCHELSTRAETE <Bart.SCHELSTRAETE@dhl.com>,
       Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <3EFA2F97.5000705@techsource.com>
References: <BB1F47F5.17533%kernel@mousebusiness.com>
	 <200306251501.14207.jbriggs@briggsmedia.com>
	 <1056567378.31260.9.camel@wires.home.biz> <3EFA2939.2060005@techsource.com>
	 <1056583075.31265.22.camel@wires.home.biz>
	 <3EFA2F97.5000705@techsource.com>
Content-Type: text/plain
Message-Id: <1056584440.10295.32.camel@wires.home.biz>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 26 Jun 2003 00:40:41 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-06-26 at 00:26, Timothy Miller wrote:
> Edward Tandi wrote:
> > On Wed, 2003-06-25 at 23:59, Timothy Miller wrote:
> >>
> >>DDR memory works very much like single data rate, except that data is 
> >>transferred (in whichever direction it's going) on both edges of the 
> >>clock, thus doubling the transfer rate.  The memory does not switch 
> >>between reading and writing as you describe it.
> >>
> >>I believe registering is for reliability.  Data is transferred one clock 
> >>cycle later but reduces signal loading.
> > 
> > 
> > Thanks for the clarification. I do not profess to be an expert in the
> > technology. Two writes or a read+write per clock cycle is close enough
> > for the purpose of the discussion.
> > 
> > The point I was trying to make is that the registers are there to deal
> > with an SMP race condition of some sort. Athlon MP motherboards fitted
> > with two processors will not work properly without 'registered' RAM. I
> > have hard experience of this and it this experience I am sharing with
> > someone who is seeing the same symptoms.
> 
> 
> It is my understanding that the registered memory requirement has 
> nothing to do with SMP but instead with the amount of memory you have.

Except if you go to the beginning of this thread, you will see that the
machine appears to be running fine in Uniprocessor mode. This concurs
with my experience. The only difference is that Artur switched the
kernel whereas I pulled a CPU (and kept the SMP kernel).

> The more memory chips you have, the greater the signal loading on the 
> memory bus.  More input drivers means more capacitance which means you 
> need your output drivers to put out data sooner (relative to the clock 
> edge, so registered delays by one clock) and stronger (greater drive 
> strength).

I only have 2 x 256MB in the box.

> In an SMP system (besides NUMA), multiple processors will talk to the 
> same memory through a shared memory controller (like in a Northbridge), 
> so although there are multiple processors, there is still only one 
> memory bus.  Pulling off one CPU isn't going to change that situation.

It appears to do the trick in practise though. How strange.

Ed-T.


