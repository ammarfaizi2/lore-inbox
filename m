Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261615AbTILBNS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 21:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261622AbTILBNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 21:13:18 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:35985 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S261615AbTILBNR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 21:13:17 -0400
X-AuthUser: davidel@xmailserver.org
Date: Thu, 11 Sep 2003 18:08:02 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Rick Lindsley <ricklind@us.ibm.com>
cc: akpm@osdl.org, kernel@kolivas.org, piggin@cyberone.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] schedstat-2.6.0-test5-A1 measuring process scheduling
 latency
In-Reply-To: <200309112235.h8BMZcM03839@owlet.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.56.0309111803270.1889@bigblue.dev.mdolabs.com>
References: <200309112235.h8BMZcM03839@owlet.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Sep 2003, Rick Lindsley wrote:

> All the tweaking of the scheduler for interactive processes is still
> rather reliant on "when I run X, Y, and Z, and wiggle the mouse, it feels
> slower."  At best, we might get a more concrete "the music skips every
> now and then."  It's very hard to develop changes for an environment I
> don't have in front of me and can't ever seem to precisely duplicate.
>
> It's my contention that what we're seeing is scheduler latency: processes
> want to run but end up waiting for some period of time.  There's currently
> no way to capture that short of the descriptions above.  This patch adds
> counters at various places to measure, among other things, the scheduler
> latency.  That is, we can now measure the time processes spend waiting
> to run after being made runnable.  We can also see on average how long
> a process runs before giving up (or being kicked off) the cpu.

When I was working on it, I wrote a patch that at every context switch
used to register cycle counter timestamp, pid and other things (this per
CPU), with the number of samples configurable. This helped me a lot not
only to understand latencies, but also process migrations (usefull for
balancing thingies). There was a /dev/something where you could collect
samples and analyze them. It'd nice to have something like that for 2.6.



- Davide

