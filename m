Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261522AbSIXBhI>; Mon, 23 Sep 2002 21:37:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261523AbSIXBhI>; Mon, 23 Sep 2002 21:37:08 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20742 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261522AbSIXBhH>;
	Mon, 23 Sep 2002 21:37:07 -0400
Message-ID: <3D8FC2DA.3010107@pobox.com>
Date: Mon, 23 Sep 2002 21:41:46 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Gustafson, Geoffrey R" <geoffrey.r.gustafson@intel.com>
CC: "'Andy Pfiffer'" <andyp@osdl.org>, cgl_discussion@osdl.org,
       "Rhoads, Rob" <rob.rhoads@intel.com>,
       hardeneddrivers-discuss@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Hardeneddrivers-discuss] RE: [cgl_discussion] Some Initial Comments
 on DDH-Spec-0.5h.pdf
References: <EDC461A30AC4D511ADE10002A5072CAD01FD8CEA@orsmsx119.jf.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gustafson, Geoffrey R wrote:
> Most of what makes a 'good' driver is common for all purposes - things you
> mention like don't make the system hang, don't cause fatal exceptions. But
> there are some things that would be different between a desktop, embedded
> system, enterprise server, or carrier server. For instance, when there is a
> tradeoff between reliability and performance; when reliability is king, it
> might be wise to do an insane amount of parameter checking to offset the
> merest chance of an undetected bug crashing a system.

This is not a valid example.  We do not make tradeoffs between 
performance and reliability.  Reliability _always_ comes first.  If it 
did not, it's a bug.


> Regarding the question: why not just fix the "bad" drivers? Drivers that are
> actually bad are probably for obscure hardware that is not really of
> concern. The purpose is to take good drivers and make sure they meet the
> last few percent of the objective standard of 'good'.

What exactly does this mean?  Can you give a concrete example of taking 
an existing driver and updating it for that last few percent?

[I venture to guess that Intel doesn't know yet what is necessary, but 
that's just a guess.]


> Another good point was about enforcement. Just because something is hardened
> at one point, doesn't necessarily mean some of the rules won't get
> accidentally violated by patches later on. So it either requires periodic
> reevaluation or strong buy-in from the respective maintainers. At least part
> of the beauty of open source is it _can_ be evaluated by an objective third
> party, if someone chose to do that.

It depends on what needs to be "enforced."  If its compliance to 
existing APIs, that's pretty much a given.  Non-compliance would be a bug.


> You asked several times for objective data, and I agree that would be great.
> However, drivers _are_ in the unique position of being both privileged code
> and yet specific to certain hardware. Thus they are capable of more damage
> than user-space code, but (on average) can't have been tested in as many
> configurations as core kernel code. So at least without data, they are a
> very logical starting point.

That's still not a concrete example :)  We already knew you were talking 
about drivers.

Does Intel even have --one-- example of a driver that could be hardened?

It seems to me Intel is writing a spec for an abstract objective, IOW 
writing a solution when the problem hasn't even been defined yet. 
Please define the problem ("<this> API needs updating to harden 
drivers") not the solution ("add <this> API and drivers will be hardened").

Finally, and this bears repeating -- I am very encouraged by Intel's 
participation, and initiative in hardening Linux drivers.  I actively 
encourage this effort, and think that Intel's resources can 
[potentially] dramatically improve the overall quality of Linux kernel 
drivers.  Guys, you have an excellent opportunity here ;-)  Please 
listen to the feedback from kernel developers, we are the guys in the 
trenches doing the Real Life software engineering day in and day out.

	Jeff



