Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751158AbVLCCS2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbVLCCS2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 21:18:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbVLCCS2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 21:18:28 -0500
Received: from numenor.qualcomm.com ([129.46.51.58]:18318 "EHLO
	numenor.qualcomm.com") by vger.kernel.org with ESMTP
	id S1751158AbVLCCS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 21:18:27 -0500
Message-ID: <43910022.1030300@qualcomm.com>
Date: Fri, 02 Dec 2005 18:17:06 -0800
From: Max Krasnyansky <maxk@qualcomm.com>
User-Agent: Thunderbird 1.4.1 (X11/20051006)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>,
       acpi-devel@lists.sourceforge.net, len.brown@intel.com,
       nando@ccrma.stanford.edu, rlrevell@joe-job.com,
       linux-kernel@vger.kernel.org, paulmck@us.ibm.com, kr@cybsft.com,
       tglx@linutronix.de, pluto@agmk.net, john.cooper@timesys.com,
       bene@linutronix.de, dwalker@mvista.com, trini@kernel.crashing.org,
       george@mvista.com, akpm@osdl.org
Subject: Re: [RFC][PATCH] Runtime switching of the idle function [take 2]
References: <20051124150731.GD2717@elte.hu> <1132952191.24417.14.camel@localhost.localdomain> <20051126130548.GA6503@elte.hu> <1133232503.6328.18.camel@localhost.localdomain> <20051128190253.1b7068d6.akpm@osdl.org> <1133235740.6328.27.camel@localhost.localdomain> <20051128200108.068b2dcd.akpm@osdl.org> <20051129064420.GA15374@elte.hu> <p73mzjngwim.fsf@verdi.suse.de> <438FA2E4.80705@qualcomm.com> <20051202014512.GH997@wotan.suse.de>
In-Reply-To: <20051202014512.GH997@wotan.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>> Also IMO saying that CPU will run too hot with idle=poll is basically 
>> saying that those
>> CPUs cannot be used for simulations and stuff which run flat out for days 
>> (months actually).
>> Which is obviously not true (again speaking from experience :)).
> 
> The CPUs can be used, but many cooling setups
> (both AirCon in complete data centers, cooling in Blade Racks, laptops)  
> the cooling is now often designed to not cool
> the maximum thermal output of all systems in parallel, but instead
> throttle the systems when things get too hot. This usually
> works because in most workloads systems are more often idle
> than busy, so no throttling is needed.
> 
> On desktops it probably won't throttle, but just become noisy
> when all the fans spin up.
> 
> All things you don't really want.
We do it (simulations that is) on normal 1U and desktop machines. No special
cooling and stuff. And it does not cause any problems. Granted we don't use
cheap/crappy machines but still it's unmodified off-the-shelf HW.

btw That ZPro machine that I mentioned used to run with idle=poll for weeks
and fans would never spin up unless you put real load on it.

> Super computing is different of course, but even there maximum
> capacity of the air condition often limits how many CPUs you can buy.
> And you need all the help you can get.
> 
> That said you're right that there is still a small niche 
> where idle=poll makes sense, but it's definitely nothing
> that should be encouraged to be used regularly like that
> original patch would.
Agreed.

Max
