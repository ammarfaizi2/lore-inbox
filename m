Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133061AbRDZCb1>; Wed, 25 Apr 2001 22:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133066AbRDZCbR>; Wed, 25 Apr 2001 22:31:17 -0400
Received: from [206.46.170.142] ([206.46.170.142]:48844 "EHLO
	smtp10ve.mailsrvcs.net") by vger.kernel.org with ESMTP
	id <S133061AbRDZCbD>; Wed, 25 Apr 2001 22:31:03 -0400
Date: Wed, 25 Apr 2001 22:30:30 -0400 (EDT)
From: Werner Puschitz <werner.lx@verizon.net>
X-X-Sender: <werner.lx@localhost.localdomain>
To: Dan Maas <dmaas@dcine.com>
cc: Michael Rothwell <rothwell@holly-springs.nc.us>,
        <linux-kernel@vger.kernel.org>
Subject: Re: #define HZ 1024 -- negative effects?
In-Reply-To: <004f01c0cdf4$f17f4ce0$0701a8c0@morph>
Message-ID: <Pine.LNX.4.33.0104252228450.3012-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Apr 2001, Dan Maas wrote:

> > Are there any negative effects of editing include/asm/param.h to change
> > HZ from 100 to 1024? Or any other number? This has been suggested as a
> > way to improve the responsiveness of the GUI on a Linux system.
>
> I have also played around with HZ=1024 and wondered how it affects
> interactivity. I don't quite understand why it could help - one thing I've
> learned looking at kernel traces (LTT) is that interactive processes very,
> very rarely eat up their whole timeslice (even hogs like X). So more
> frequent timer interrupts shouldn't have much of an effect...
>
> If you are burning CPU doing stuff like long compiles, then the increased HZ
> might make the system appear more responsive because the CPU hog gets
> pre-empted more often. However, you could get the same result just by
> running the task 'nice'ly...

A tradeoff of having better system responsiveness by having the kernel to
check more often if a running process should be preempted is that the CPU
spends more time in Kernel Mode and less time in User Mode.
And as a consequence, user programs run slower.

Regards,
Werner



