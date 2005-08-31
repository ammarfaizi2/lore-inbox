Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751077AbVHaUEb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751077AbVHaUEb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 16:04:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751078AbVHaUEb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 16:04:31 -0400
Received: from digitalimplant.org ([64.62.235.95]:19356 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S1751089AbVHaUEa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 16:04:30 -0400
Date: Wed, 31 Aug 2005 13:04:18 -0700 (PDT)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: Todd Poynor <tpoynor@mvista.com>
cc: Jordan Crouse <jordan.crouse@amd.com>, "" <linux-pm@lists.osdl.org>,
       "" <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] Re: PowerOP Take 2 0/3 Intro
In-Reply-To: <430E4177.10600@mvista.com>
Message-ID: <Pine.LNX.4.50.0508311256150.23387-100000@monsoon.he.net>
References: <20050825025158.GA28662@slurryseal.ddns.mvista.com>
 <20050825210940.GX31472@cosmic.amd.com> <430E4177.10600@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 25 Aug 2005, Todd Poynor wrote:

> In case it's getting lost in all these details, the main point of all
> this is to pose the question: "are arbitrary power parameters arranged
> into a set with mutually consistent values (called here an operating
> point) a good low-level abstraction for system power management of a
> wide variety of platforms?"  Thanks,

Yes, I think so. This seems to be one of the main concerns of the embedded
platform developers, especially e.g. the OMAP people.

The thing I'm most concerned about is integration with other mainstream
platforms. cpufreq works reasonably well for desktop and laptop system,
for CPU frequency. But, I expect to see more flexibility in the power
management parameters in other aspects of the system in the near future.

How do we deal with that? If it's PowerOP, then how does it interact with
cpufreq and its user space tools? If it's used in conjunction (using
cpufreq for the CPUs and PowerOP for everything else), what can we do to
integrate the UI?

Personally I think that they are fine sitting side by side for now, but we
need to do some work on the low-level tools. For one, setting 8 values in
sysfs to effect a change is not very friendly. For another, it took a long
time to get the cpufreq stuff right. How do we learn from that and avoid
that?

Thanks,


	Pat
