Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290772AbSARSKr>; Fri, 18 Jan 2002 13:10:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290773AbSARSKh>; Fri, 18 Jan 2002 13:10:37 -0500
Received: from [208.29.163.248] ([208.29.163.248]:46490 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S290772AbSARSKa>; Fri, 18 Jan 2002 13:10:30 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Ben Greear <greearb@candelatech.com>
Cc: linux-kernel@vger.kernel.org
Date: Fri, 18 Jan 2002 10:10:02 -0800 (PST)
Subject: Re: Tulip driver bug in 2.4.17 (fwd)
In-Reply-To: <3C4839E8.6080800@candelatech.com>
Message-ID: <Pine.LNX.4.40.0201181006410.27656-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jan 2002, Ben Greear wrote:

> David Lang wrote:
> > On Thu, 17 Jan 2002, Ben Greear wrote:
> >>David Lang wrote:
> >>>On Thu, 17 Jan 2002, Ben Greear wrote:
> >>>>You're not using a PCI extender/riser card, are you?
> >>>Yes, (it's in a 2u rackmount case). it's a low right-angle extender
> >>You're screwed :)
> >>
> >>It seems to be a hardware/PCI problem.  I replaced 4-port NICS (the DFE-570-TX),
> >>motherboards, cpus, entire chassis...the problem followed the riser cards.
> >>
> >
> > then why does the same card work properly with the old driver? if it's
> > truely a hardware problem then all versions of the driver should fail. if
> > it's possible for one version to work around the problem (or avoid
> > triggering it) then other versions should be able to.
>
>
> That is interesting.  (For me, I had some older, slightly slower systems
> work, while the newer ones failed.  I believe I tried older drivers on my
> new hardware, but I'm not sure...)  The only excuse I could come up with is
> that the newer drivers/machines could utilize the PCI bus faster and
> that somehow caused the lockup.  Because even sysreq didn't work, I can't
> imagine what a driver, buggy or otherwise, could do to lock the system
> like it does...

for me the same machine is rock solid with 2.4.5/8 (driver 0.9.14) but
fails with 2.4.14/17 (driver 0.9.15-pre9)

the failure is not at all traffic related, I have these boxes in
production (only useing 3 of the 4 ports) with no problems at all, but on
a box not connected to any network I can lock it up by just issuing an
ifconfig.

it's possible that it's a PCI problem (if so can we back off the timing to
what worked?), but I would expect the problem to be more variable if that
was the case.

David Lang
