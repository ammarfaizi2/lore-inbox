Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278379AbRJMTeL>; Sat, 13 Oct 2001 15:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278374AbRJMTdu>; Sat, 13 Oct 2001 15:33:50 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:10756 "EHLO
	bug.ucw.cz") by vger.kernel.org with ESMTP id <S278375AbRJMTcr>;
	Sat, 13 Oct 2001 15:32:47 -0400
Date: Fri, 12 Oct 2001 13:01:39 +0000
From: Pavel Machek <pavel@suse.cz>
To: Dave Jones <davej@suse.de>
Cc: Jose_Jorge@teklynx.fr, linux-kernel@vger.kernel.org
Subject: Re: kapmidled and AMD K6-2
Message-ID: <20011012130138.A35@toy.ucw.cz>
In-Reply-To: <OFD647EAB7.926A3491-ONC1256AE0.00534E9E@bradycorp.com> <Pine.LNX.4.30.0110091735160.31520-100000@Appserv.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.30.0110091735160.31520-100000@Appserv.suse.de>; from davej@suse.de on Tue, Oct 09, 2001 at 05:45:50PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > for the AMD K6-2 on a DFI motherboard AT/ATX, using the AT power supply,
> > this option is buggy. I mean the cycles kapmidled works doesn't cool the
> > processor, they hot him.
> 
> Initially, I thought was odd. The spec seemed straight forward
> enough, and doesn't say we have to do any special magic.
> Just that "During the execution of the HLT instruction, the AMD-K6-2
> processor executes a Halt special cycle."
> 
> The next bit is interesting however..
> 
> "After BRDY# is sampled asserted during this cycle, and then EWBE#
> is also sampled asserted (if not masked off), the processor enters
> the halt state in which the processor disables most of its internal
> clock distribution."
> 
> EWBE is a feature that is enabled with bits 2-3 of the EFER MSR.
> This controls the behaviour of the CPU with respect to ordering
> of write cycles. Behaviour here can affect performance, and from
> my interpretation of the above, the amount of power saving that
> is possible.
> 
> You can control the EWBE register using powertweak
> (http://www.powertweak.org), but if you don't want to/are unable
> to build that, and want to do some further tests, let me know
> and I'll hack something up.

If I don't want to build powertweak, are you willing to hack something up
for me? ;-). [My k6-2 is too hot to slow down CPU fan. I tried throttling
it using ACPI, but no success. I want to cool it down so that fan slows
and machine becomes quiet.]
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

