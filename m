Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261695AbTHTEUZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 00:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261700AbTHTEUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 00:20:25 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:13075 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S261695AbTHTEUX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 00:20:23 -0400
Date: Wed, 20 Aug 2003 00:11:26 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: William Lee Irwin III <wli@holomorphy.com>
cc: David Lang <david.lang@digitalinsight.com>,
       Eric St-Laurent <ericstl34@sympatico.ca>, linux-kernel@vger.kernel.org
Subject: Re: scheduler interactivity: timeslice calculation seem wrong
In-Reply-To: <20030820004851.GD4306@holomorphy.com>
Message-ID: <Pine.LNX.3.96.1030820000415.11300B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Aug 2003, William Lee Irwin III wrote:

> On Tue, Aug 19, 2003 at 05:32:04PM -0700, David Lang wrote:
> > while thinking about scaling based on CPU speed remember systems with
> > variable CPU clocks (or even just variable performance like the transmeta
> > CPU's)
> 
> This and/or mixed cpu speeds could make load balancing interesting on
> SMP. I wonder who's tried. jejb?

Hum, I *guess* that if you are using some "mean time between dispatches"
to tune time slice you could apply a CPU speed correction, but mixed speed
SMP is too corner a case for me. I think if you were tuning time slice by
mean time between dispatches (or similar) you could either apply a
correction, set affinity low to keep jobs changing CPUs, or just ignore
it.

The thing I like about the idea is that if the CPU speed changes the MTBD
will change and the timeslice will compensate. You could use median MTBD,
or pick some percentile to tune for response or throughput.

I thought I was just thinking out loud, but it does sound interesting to
try, since it would not prevent using some priorities as well.

> 
> 
> -- wli
> 

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

