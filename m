Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132872AbRDIX2v>; Mon, 9 Apr 2001 19:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132875AbRDIX2k>; Mon, 9 Apr 2001 19:28:40 -0400
Received: from nrg.org ([216.101.165.106]:53264 "EHLO nrg.org")
	by vger.kernel.org with ESMTP id <S132872AbRDIX2h>;
	Mon, 9 Apr 2001 19:28:37 -0400
Date: Mon, 9 Apr 2001 16:28:27 -0700 (PDT)
From: Nigel Gamble <nigel@nrg.org>
Reply-To: nigel@nrg.org
To: bsuparna@in.ibm.com
cc: paul.mckenney@us.ibm.com, lse-tech@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, ak@suse.de, dipankar.sarma@in.ibm.com
Subject: Re: [Lse-tech] Re: [PATCH for 2.5] preemptible kernel
In-Reply-To: <CA256A29.0047C346.00@d73mta05.au.ibm.com>
Message-ID: <Pine.LNX.4.05.10104091607370.15750-100000@cosmic.nrg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Apr 2001 bsuparna@in.ibm.com wrote:
> As you've observed, with the approach of waiting for all pre-empted tasks
> to synchronize, the possibility of a task staying pre-empted for a long
> time could affect the latency of an update/synchonize (though its hard for
> me to judge how likely that is).

It's very unlikely on a system that doesn't already have problems with
CPU starvation because of runaway real-time tasks or interrupt handlers.

First, preemption is a comparitively rare event with a mostly
timesharing load, typically from 1% to 10% of all context switches.

Second, the scheduler should not penalize the preempted task for being
preempted, so that it should usually get to continue running as soon as
the preempting task is descheduled, which is at most one timeslice for
timesharing tasks.

Nigel Gamble                                    nigel@nrg.org
Mountain View, CA, USA.                         http://www.nrg.org/
MontaVista Software                             nigel@mvista.com

