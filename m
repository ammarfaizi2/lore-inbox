Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261583AbSIXGnD>; Tue, 24 Sep 2002 02:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261584AbSIXGnD>; Tue, 24 Sep 2002 02:43:03 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:21593 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S261583AbSIXGnC>; Tue, 24 Sep 2002 02:43:02 -0400
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "Gustafson, Geoffrey R" <geoffrey.r.gustafson@intel.com>,
       "'Andy Pfiffer'" <andyp@osdl.org>, cgl_discussion@osdl.org,
       "Rhoads, Rob" <rob.rhoads@intel.com>,
       hardeneddrivers-discuss@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Hardeneddrivers-discuss] RE: [cgl_discussion] Some Initial Comments on DDH-Spec-0.5h.pdf
References: <EDC461A30AC4D511ADE10002A5072CAD01FD8CEA@orsmsx119.jf.intel.com>
	<3D8FC2DA.3010107@pobox.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 24 Sep 2002 00:33:06 -0600
In-Reply-To: <3D8FC2DA.3010107@pobox.com>
Message-ID: <m1k7lbkicd.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On the intel side I'm ready to ask for hardened hardware.
Maybe it's just the high volume but it feels like to use any piece
of intel hardware I half to use arounds for hardware bugs.

A lot of the problems feel like someone was doing a rush, job to meet
some marketing window.

My current favorite is the ICH3 I have my choice.  I can either monitor
Xeon temporatures via the i2c/smbus interface or I can reliably reset
the machine.

The useful point here is no amount of abstract talking about
hardening the hardware is going to reveal issues like these.  Only
testing and debugging.  And keeping both the hardware and the software
simple is an important piece of preventing bugs.


Jeff Garzik <jgarzik@pobox.com> writes:

> Gustafson, Geoffrey R wrote:
> > Most of what makes a 'good' driver is common for all purposes - things you
> > mention like don't make the system hang, don't cause fatal exceptions. But
> > there are some things that would be different between a desktop, embedded
> > system, enterprise server, or carrier server. For instance, when there is a
> > tradeoff between reliability and performance; when reliability is king, it
> > might be wise to do an insane amount of parameter checking to offset the
> > merest chance of an undetected bug crashing a system.
> 
> This is not a valid example.  We do not make tradeoffs between performance and
> reliability.  Reliability _always_ comes first.  If it did not, it's
> a bug.

Agreed.  

 
> > Regarding the question: why not just fix the "bad" drivers? Drivers that are
> > actually bad are probably for obscure hardware that is not really of
> > concern. The purpose is to take good drivers and make sure they meet the
> > last few percent of the objective standard of 'good'.

O.k. Then why not just fix the buggy hardware?
 
> What exactly does this mean?  Can you give a concrete example of taking an
> existing driver and updating it for that last few percent?

Does fixing intel hardware bugs count?
> 
> > You asked several times for objective data, and I agree that would be great.
> > However, drivers _are_ in the unique position of being both privileged code
> > and yet specific to certain hardware. Thus they are capable of more damage
> > than user-space code, but (on average) can't have been tested in as many
> > configurations as core kernel code. So at least without data, they are a
> > very logical starting point.

Oh, and don't forget that the hardware specification that drivers are
written to, many times are not generally available greatly reducing 
the pool of capable people who have the opportunity to review the and
debug the drivers.  I would make it a requirement for a hardened
driver that both the code and the hardware documentation be publicly
available so the code can easily be reviewed by as many people as wish
to.

> Finally, and this bears repeating -- I am very encouraged by Intel's
> participation, and initiative in hardening Linux drivers.  I actively encourage
> this effort, and think that Intel's resources can [potentially] dramatically
> improve the overall quality of Linux kernel drivers.  Guys, you have an
> excellent opportunity here ;-)  Please listen to the feedback from kernel
> developers, we are the guys in the trenches doing the Real Life software
> engineering day in and day out.

I will agree with that sentiment.  

Eric
