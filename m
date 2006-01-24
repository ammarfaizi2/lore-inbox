Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030225AbWAXDCm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030225AbWAXDCm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 22:02:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030304AbWAXDCm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 22:02:42 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:50869 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030225AbWAXDCl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 22:02:41 -0500
Subject: Re: [PATCH -mm] Time: Keep clock=pmtmr functional, but depricated
From: john stultz <johnstul@us.ibm.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1138071554.2771.45.camel@mindpipe>
References: <1138071141.15682.81.camel@cog.beaverton.ibm.com>
	 <1138071554.2771.45.camel@mindpipe>
Content-Type: text/plain
Date: Mon, 23 Jan 2006 19:02:36 -0800
Message-Id: <1138071756.15682.85.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-23 at 21:59 -0500, Lee Revell wrote:
> On Mon, 2006-01-23 at 18:52 -0800, john stultz wrote:
> > With the new clocksource code, the ACPI PM timer is now called acpi_pm.
> > This has confused users that are familiar w/ using the clock=pmtmr boot
> > option.
> > 
> > This patch insures that the clock=pmtmr boot option will still function,
> > but will warn the users to use clocksource=acpi_pm in the future.
> 
> What about the other clock= boot options?

They are using the same old names: "cyclone", "hpet", "pit", "tsc"
So nothing changes there, clock= will still function (but prints out a
warning).

> I believe that changing their behavior counts as "breaking userspace".

I'm not sure I'd consider changing a kernel boot parameter as "breaking
userspace", but I do agree that we should preserve behavior for awhile
to avoid confusion, and that is what this patch provides.

thanks
-john



