Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276905AbRJHOrx>; Mon, 8 Oct 2001 10:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276906AbRJHOre>; Mon, 8 Oct 2001 10:47:34 -0400
Received: from [216.191.240.114] ([216.191.240.114]:31365 "EHLO
	shell.cyberus.ca") by vger.kernel.org with ESMTP id <S276905AbRJHOrV>;
	Mon, 8 Oct 2001 10:47:21 -0400
Date: Mon, 8 Oct 2001 10:45:02 -0400 (EDT)
From: jamal <hadi@cyberus.ca>
To: <linux-kernel@vger.kernel.org>, <netdev@oss.sgi.com>
cc: Bernd Eckenfels <ecki@lina.inka.de>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
Message-ID: <Pine.GSO.4.30.0110081024440.5473-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>Yes, have a look at the work of the Click Modular Router PPL from MIT,
>having a Polling Router Module Implementatin which outperforms Linux
>Kernel Routing by far (according to their paper :)

I have read the click paper; i also just looked at the code and it seems
the tulip driver they use has the same roots as us (based on Alexey's
initial HFC driver)

Several things to note/observe:
- They use some very specialized piece of hardware (with two PCI buses).
- Roberts results on a single PCI bus hardware was showing ~360Kpps
routing vs clicks 435Kpps. This is not "far off" given the differences in
hardware. What would be really interesting is to have the click folks
post their latency results. I am curious as to what a purely polling
scheme they have would achieve (as opposed to NAPI which is a mixture of
interupts and polls).
- Linux is already "very modular" as a router with both the traffic
control framework and netfilter. I like their language specification etc;
ours is a little more primitive in comparison.
- Click seems to only run on a system that is designated as a router (as
you seem to point out).

Linux has a few other perks, but the above were to compare the two.

> You can find the Link to Click somewhere on my Page:
> http://www.freefire.org/tools/index.en.php3in the Operating System
> section (i think)

Nice web page and collection, btw. The right web page seems to be:
http://www.freefire.org/tools/index.en.php3

I looked at the latest click paper on SMP. It would help if they were
aware of whats happening on Linux (since it seems to be their primary OS).
softnet does what they are asking for sans the scheduling (which in Linux
proper is done via the IRQ scheduling). They also have a way for the
admin to specify the scheduling scheme; which is nice, but i am not sure
to be very valuable; I'll read the paper again to avoid hasty judgement.
It would be nice to work with the click people (at least to avoid
redundant work and maybe to get Linux mentioned in their paper -- they
even mention ALTQ but forget Linux, which is more advanced ;->).

cheers,
jamal

