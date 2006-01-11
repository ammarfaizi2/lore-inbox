Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751049AbWAKWDK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbWAKWDK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 17:03:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751106AbWAKWDK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 17:03:10 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:27566 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751049AbWAKWDJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 17:03:09 -0500
Subject: Re: Back to the Future ? or some thing sinister ?
From: john stultz <johnstul@us.ibm.com>
To: Nathan Lynch <ntl@pobox.com>
Cc: Chaitanya Hazarey <cvh.tcs@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20060109040322.GA2683@localhost.localdomain>
References: <eaef64fc0601081131i17336398l304038c6dea3e057@mail.gmail.com>
	 <20060109040322.GA2683@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 11 Jan 2006 14:03:06 -0800
Message-Id: <1137016986.2890.57.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-01-08 at 22:03 -0600, Nathan Lynch wrote:
> Chaitanya Hazarey wrote:
> >
> > We have got a machine, lets say X , make is IBM and the CPU is Intel
> > Pentium 4 2.60 GHz. Its running a 2.6.13.1 Kernel and previously,
> > 2.6.27-4 Kernel the distribution is Debian Sagre.
> > 
[snip]
> > 
> > The problem is that, after a some time ( fuzzy , but I think like 2
> > hours ) of inactivity or because of some esoteric factor which triggers
> > a state in which the time on the machine starts going around in a loop.
> > if I do cat /proc/uptime, it goes 4  ticks ahead and again rewinds back
> > to the starting count ( not zero, but the moment in time when the event
> > was triggred. )
> > 
> > The problem seems to be specific to the 2.6 series of kernel, not the
> > 2.4 series.
> > 
> > I  would like to know how to go about the debugging of the problem, and
> > that which specific part of the kernel will be directly interacting with
> > the rtc / system clock.
> 
> Look into upgrading the BIOS on that machine; I've had similar
> problems on a IBM P4 workstation that were fixed in this way.

Yes, there was a problematic BIOS on some IBM P4 systems that after a
few hours messed up the apic's timer interrupt frequency. I believe
booting w/ noapic will work around the issue, but the correct fix is to
update your BIOS.

Please file a bugzilla bug if upgrading your BIOS does resolve the
issue.

thanks
-john

