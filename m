Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932424AbWAIQI0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932424AbWAIQI0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 11:08:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932429AbWAIQI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 11:08:26 -0500
Received: from mail28.syd.optusnet.com.au ([211.29.133.169]:61883 "EHLO
	mail28.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932424AbWAIQIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 11:08:25 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Mike Galbraith <efault@gmx.de>
Subject: Re: [SCHED] wrong priority calc - SIMPLE test case
Date: Tue, 10 Jan 2006 03:08:04 +1100
User-Agent: KMail/1.9
Cc: Paolo Ornati <ornati@fastwebnet.it>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Peter Williams <pwil3058@bigpond.net.au>
References: <5.2.1.1.2.20060102092903.00bde090@pop.gmx.net> <5.2.1.1.2.20051231162352.00bda610@pop.gmx.net> <5.2.1.1.2.20060109162113.00ba9fd0@pop.gmx.net>
In-Reply-To: <5.2.1.1.2.20060109162113.00ba9fd0@pop.gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601100308.05836.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 January 2006 02:52, Mike Galbraith wrote:
> At 12:11 PM 1/9/2006 +0100, Mike Galbraith wrote:
> >Care to try an experiment?...
>
> Oops.  I guess I should send one that's not mixed p1 and p0.  Sorry about
> that :-/
>
> Anyway, if anyone wants to see a functional demonstration, just try
> this.  Remove the TASK_NONINTERACTIVE in fs/pipe.c in both the stock kernel
> and this modified one so Davide Libenzi's excellent sleep pattern exploit
> (irman2) can work [1], and do the below all at the same time ...
>
> make -j4 bzImage
> irman2
> thud 3
>
> With the stock kernel, I got bored after a half an hour, and stopped the
> kernel build.  It had produced 40 .o files.  The modified kernel finished
> in 20 minutes vs the 8 minutes it took to produce the same 504 .o files if
> not under load.
>
>          -Mike
>
> 1.  it just so happens that Davide wrote irman2 using pipes... he could
> have done something else.  if anyone doesn't think this is a fair test,
> just use Paolo's much simpler exploit instead.  the result will be about
> the same.

Want to try with a few other schedulers using plugsched?

Con
