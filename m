Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317347AbSH1UWB>; Wed, 28 Aug 2002 16:22:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318943AbSH1UWB>; Wed, 28 Aug 2002 16:22:01 -0400
Received: from pallas.or.intel.com ([134.134.214.21]:14576 "EHLO
	pallas.or.intel.com") by vger.kernel.org with ESMTP
	id <S317347AbSH1UWA>; Wed, 28 Aug 2002 16:22:00 -0400
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD0236DDE7@orsmsx119.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Linus Torvalds'" <torvalds@transmeta.com>,
       Dominik Brodowski <devel@brodo.de>
Cc: cpufreq@www.linux.org.uk, linux-kernel@vger.kernel.org
Subject: RE: [PATCH][2.5.32] CPU frequency and voltage scaling (0/4)
Date: Wed, 28 Aug 2002 13:25:11 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Linus Torvalds [mailto:torvalds@transmeta.com] 
> In other words: there is no valid way that a _user_ can set the policy
> right now: the user can set the frequency, but since any sane policy
> depends on how busy the CPU is, the user isn't even, the 
> right person to
> _do_ that, since the user doesn't _know_.
> 
> Also note that policy is not just about how busy the CPU is, but also 
> about how _hot_ the CPU is. Again, a user-mode application 
> (that maybe 
> polls the situation every minute or so), simply _cannot_ handle this 
> situation. You need to have the ability to poll the CPU tens 
> of times a 
> second to react to heat events, and clearly user mode cannot do that 
> without impacting performance in a big way.
> 
> The interface needs to be improved upon. It is simply _not_ 
> valid to say
> "run at this speed" as the primary policy.

Well TMTA CPUs would seem to be easy, because all this is done behind the
OS's back, right?

Let's talk about CPUs in which the OS has to control processor performance.
The way I see it, there are a bunch of inputs that are going to determine
CPU speed & voltage: user preference, workload, and thermals.

Wouldn't you have your initial perf setting determined by the workload, and
then revised down, based upon user preferences (such as "I want to conserve
battery") and the thermal requirements?

Any workload analysis has to be in the kernel. The user interface can be one
that just allows a limit to be placed upon the setting the workload demands.
Then, the thermal control can further drop the setting, if needs be.

Regards -- Andy
