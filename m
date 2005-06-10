Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261359AbVFJW4S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261359AbVFJW4S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 18:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261370AbVFJW4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 18:56:18 -0400
Received: from smtp.lnxw.com ([207.21.185.24]:36875 "EHLO smtp.lnxw.com")
	by vger.kernel.org with ESMTP id S261359AbVFJWzm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 18:55:42 -0400
Date: Fri, 10 Jun 2005 16:01:21 -0700
To: Andrea Arcangeli <andrea@suse.de>
Cc: Bill Huey <bhuey@lnxw.com>, Lee Revell <rlrevell@joe-job.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Tim Bird <tim.bird@am.sony.com>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de, karim@opersys.com, mingo@elte.hu,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org
Subject: Re: Attempted summary of "RT patch acceptance" thread
Message-ID: <20050610230121.GB21618@nietzsche.lynx.com>
References: <20050608022646.GA3158@us.ibm.com> <42A8D1F3.8070408@am.sony.com> <20050609235026.GE1297@us.ibm.com> <1118372388.32270.6.camel@mindpipe> <20050610154745.GA1300@us.ibm.com> <20050610173728.GA6564@g5.random> <1118436338.6423.48.camel@mindpipe> <20050610210614.GD6564@g5.random> <20050610221914.GA20694@nietzsche.lynx.com> <20050610223751.GE6564@g5.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050610223751.GE6564@g5.random>
User-Agent: Mutt/1.5.9i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 11, 2005 at 12:37:51AM +0200, Andrea Arcangeli wrote:
> Did you read Karim's answer at all?

Reverse to youe did you read message from the original thread at all ?
Karim supports this work and knows this is possible.

> Those RTOS don't have frenetic development in scheduler and all other

SCHED_FIFO isn't effected by it, nor is SCHED_RR. That's another hysterical
claim on your part.

> subsystems and they may be simpler as well, so perhaps you can disable
> L2 and L3 and measure all possible paths that kernel can take in
> invoking your rt code, but I doubt you're going to keep it up with linux
> development in demonstrating the worst case deadline in every possible
> hardware. Measuring all possible paths of a nanokernel is absolutely

Not an issue. Folks do it all of the time here. There's no hysteria
regarding this here. Single image kernel do it all of the time such as
Mach, QNX, LynxOS and friends. 

> RTOS may be fine for cellphones or other stuff where you may not even
> need hard-RT at all, but you just want the lowest possible latency, but
> I'd _never_ use it whenever I need a true deadline, since other more
> reliable solutions are possible without much more complexity.

Read the original thread. Folks have intention of doing more than you
realize at this point. Trivial strawman claims of provable verses
measured latencies are just stupid. The problem is not as wacked you
make it.

[cellphone commentary stripped]
 
> About the fact the kernel can crash, and a driver can corrupt memory,
> that's the difference between ruby and diamond.

Nanokernels crash as well from lack of memory protection. So what ?

You make too many assumptions in domain you have little experience in
and turn it into some assumed fatal argument about single image RT which
is far from reality and the true of the matter.

> I simply think RTOS is an awful solution to hard-RT, RTAI/rtlinux
> designs are much more reliable. There are certainly areas where RTOS is

LynxOS runs on HP printers for real time guarantees all of the time and
is good for general purpose usages as well. Folks use single image kernel
for RT guarantees even before the existence RTAI and RT Linux. Your history
is reversed here. People have been doing this for ages under a single image.

> acceptable, and this is where hard-RT isn't required and you simply want
> the lowest possible latency when invoking syscalls like alsa ioctls. But
> when alsa kernel code is out of the equation I'd never use RTOS to get
> the kernel out of the way.

Hard RT is required in audio. It's require in processing DSP data coming
from those cards. ioctl() paths are short and pretty much directly go to
the driver.

bill

