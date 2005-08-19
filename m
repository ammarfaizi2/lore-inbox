Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964817AbVHSEqx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964817AbVHSEqx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 00:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964828AbVHSEqx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 00:46:53 -0400
Received: from mail23.syd.optusnet.com.au ([211.29.133.164]:47795 "EHLO
	mail23.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S964817AbVHSEqv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 00:46:51 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: Schedulers benchmark - Was: [ANNOUNCE][RFC] PlugSched-5.2.4 for 2.6.12 and 2.6.13-rc6
Date: Fri, 19 Aug 2005 14:36:42 +1000
User-Agent: KMail/1.8.2
Cc: Lee Revell <rlrevell@joe-job.com>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>
References: <43001E18.8020707@bigpond.net.au> <200508191341.24821.kernel@kolivas.org> <430562E5.1070208@bigpond.net.au>
In-Reply-To: <430562E5.1070208@bigpond.net.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508191436.42881.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Aug 2005 02:41 pm, Peter Williams wrote:
> Con Kolivas wrote:
> > On Fri, 19 Aug 2005 01:28 pm, Lee Revell wrote:
> >>On Fri, 2005-08-19 at 05:09 +0200, Michal Piotrowski wrote:
> >>>Hi,
> >>>here are interbench v0.29 resoults:
> >>
> >>The X test under simulated "Compile" load looks most interesting.
> >>
> >>Most of the schedulers do quite poorly on this test - only Zaphod with
> >>default max_ia_bonus and max_tpt_bonus manages to deliver under 100ms
> >>max latency.  As expected with interactivity bonus disabled it performs
> >>horribly.
> >
> > The compile load is not a real compile load; it is an extreme
> > exaggeration of what happens during a compile and this is done to
> > increase the sensitivity of this test. It is _not_ worth trying to get a
> > perfect score in this.
> >
> >>I'd like to see some results with X reniced to -10.  Despite what the
> >>2.6 release notes say, this still seems to make a difference.
> >
> > Well of course it helps X - but then any X load totally fscks up audio on
> > mainline and staircase which is why it's recommended not to renice it.
>
> Maybe we could use interbench to find a nice value for X that doesn't
> destroy Audio and Video?  The results that I just posted for
> spa_no_frills with X reniced to -10 suggest that the other schedulers
> could cope with something closer to zero.

I don't see the point. X works fine as is without renicing not withstanding 
these extreme loads in interbench. Furthermore, reworking of xorg code to not 
spin the cpu unnecessarily when the gpu is busy is underway and tuning the 
cpu scheduler unfairly for an X server that will no longer behave so badly is 
inappropriate.

Cheers,
Con
