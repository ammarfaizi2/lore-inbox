Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262788AbUB0NKy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 08:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262852AbUB0NKy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 08:10:54 -0500
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:31427 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S262788AbUB0NKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 08:10:46 -0500
Date: Fri, 27 Feb 2004 08:10:33 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Dan Creswell <dan@dcrdev.demon.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Hard locks under high interrupt load?
In-Reply-To: <403F2237.6080505@dcrdev.demon.co.uk>
Message-ID: <Pine.LNX.4.58.0402270744240.17504@montezuma.fsmlabs.com>
References: <403F2237.6080505@dcrdev.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Feb 2004, Dan Creswell wrote:

> I'm having zero success in getting 2.6.3 stable under interrupt load.  I
> can kill my machine in a variety of fashions all of which appear, to my
> naive eye, related to interrupt load:
>
> (1)   LAN traffic via E1000 card (X is not running)
> (2)   Running X for more than a few minutes - starting up a couple of
> applications whilst performing some disk-based activity (such as a
> compile) usually seems to do the trick.
>
> (2) is worth a little more examination.  I have an NVIDIA card (I can
> hear you all groan) *but* I get the same results with the XFree driver
> *or* the proprietary NVIDIA driver.
>
> Disabling IO-APIC usage seems to resolve the problem.

Does the 'noirqbalance' kernel parameter also serve as a workaround? Are
you using any userspace irq balancers?

> Machine is a dual Xeon, Tyan S2665 (E7505 chipset) with an MPT-Fusion
> SCSI controller.
>
> 2.4.26-pre1 and various other 2.4 kernels give me no problems at all.  I
> really want to switch my machines over to 2.6 but I can't whilst this
> problem persists.
