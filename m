Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261775AbUB1M1b (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 07:27:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261835AbUB1M1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 07:27:31 -0500
Received: from mail006.syd.optusnet.com.au ([211.29.132.63]:42192 "EHLO
	mail006.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261775AbUB1M1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 07:27:19 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Nick Piggin <piggin@cyberone.com.au>
Subject: Re: sched domains kernbench improvements
Date: Sat, 28 Feb 2004 23:27:15 +1100
User-Agent: KMail/1.6
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200402282159.58452.kernel@kolivas.org> <200402282218.41590.kernel@kolivas.org> <40407A14.90108@cyberone.com.au>
In-Reply-To: <40407A14.90108@cyberone.com.au>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402282327.15272.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Feb 2004 22:23, Nick Piggin wrote:
> Con Kolivas wrote:
> >Will this affect the SCHED_SMT performance and should I do a round of
> > benchies with this enabled?
>
> It will as far as balancing between physical CPUs, yes. It probably
> doesn't make quite a big difference because it is less of a problem
> if one sibling goes idle than if one CPU (in the 8-way) goes idle).
>
> But if you could do a round with SCHED_SMT enabled it would be very
> nice of you ;)

One wonders sometimes why one asks a question if one already knows the 
answer ;-) 

better on half load

sched_SMT:
Average Half Load Run:
Elapsed Time 113.008
User Time 742.786
System Time 90.65
Percent CPU 738
Context Switches 28062.6
Sleeps 24571.8

Average Optimum Load Run:
Elapsed Time 79.278
User Time 1007.69
System Time 107.388
Percent CPU 1407
Context Switches 33355
Sleeps 32720

Average Maximum Load Run:
Elapsed Time 80.33
User Time 1009.89
System Time 121.518
Percent CPU 1408.4
Context Switches 31802.4
Sleeps 22905


sched_SMT-lessidle:
Average Half Load Run:
Elapsed Time 112.084
User Time 722.972
System Time 91.946
Percent CPU 727.2
Context Switches 13016.6
Sleeps 24991.2

Average Optimum Load Run:
Elapsed Time 79.07
User Time 1007.33
System Time 107.482
Percent CPU 1410.2
Context Switches 33007.2
Sleeps 32159.6

Average Maximum Load Run:
Elapsed Time 80.926
User Time 1010.12
System Time 121.472
Percent CPU 1399
Context Switches 31268.4
Sleeps 22479

Con
