Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964815AbVKVBPi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964815AbVKVBPi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 20:15:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964816AbVKVBPi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 20:15:38 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:37871 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S964815AbVKVBPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 20:15:37 -0500
Date: Mon, 21 Nov 2005 20:15:11 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Ingo Molnar <mingo@elte.hu>
cc: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@us.ibm.com>,
       "K.R. Foley" <kr@cybsft.com>, Thomas Gleixner <tglx@linutronix.de>,
       pluto@agmk.net, john cooper <john.cooper@timesys.com>,
       Benedikt Spranger <bene@linutronix.de>,
       Daniel Walker <dwalker@mvista.com>,
       Tom Rini <trini@kernel.crashing.org>,
       George Anzinger <george@mvista.com>
Subject: Re: test time-warps [was: Re: 2.6.14-rt13]
In-Reply-To: <20051121221941.GA11102@elte.hu>
Message-ID: <Pine.LNX.4.58.0511212012020.5461@gandalf.stny.rr.com>
References: <20051115090827.GA20411@elte.hu> <1132608728.4805.20.camel@cmn3.stanford.edu>
 <20051121221511.GA7255@elte.hu> <20051121221941.GA11102@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 21 Nov 2005, Ingo Molnar wrote:

>
> but in any case, -rt13 should be silent and there should be no time
> warps. If there are any then those could cause the keyboard repeat
> problems.
>

Hi Ingo,

I'm running -rt13 with the following command line:

root=/dev/md0 ro console=ttyS0,115200 console=tty0 nmi_watchdog=2 lapic
earlyprintk=ttyS0,115200 idle=poll

I just got the following output:

$ ./time-warp-test
#CPUs: 2
running 2 tasks to check for time-warps.
warp ..        -5 cycles, ... 0000004fc2ab2b7f -> 0000004fc2ab2b7a ?
warp ..       -12 cycles, ... 000000506d1d558c -> 000000506d1d5580 ?
warp ..       -97 cycles, ... 000000536c8868d3 -> 000000536c886872 ?
warp ..       -99 cycles, ... 00000059ae9d49a1 -> 00000059ae9d493e ?
warp ..      -110 cycles, ... 00000059ed0f05d6 -> 00000059ed0f0568 ?
warp ..      -118 cycles, ... 0000007392963142 -> 00000073929630cc ?
warp ..      -122 cycles, ... 0000007d6a94bc76 -> 0000007d6a94bbfc ?
warp ..      -346 cycles, ... 0000008acf28a18e -> 0000008acf28a034 ?
warp ..      -390 cycles, ... 0000008b2fc61fef -> 0000008b2fc61e69 ?

-- Steve


