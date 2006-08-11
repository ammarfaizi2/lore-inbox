Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964785AbWHKUjX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964785AbWHKUjX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 16:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964786AbWHKUjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 16:39:23 -0400
Received: from rtr.ca ([64.26.128.89]:47553 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S964785AbWHKUjX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 16:39:23 -0400
Message-ID: <44DCEAF7.5020005@rtr.ca>
Date: Fri, 11 Aug 2006 16:39:19 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: cpufreq stops working after a while
References: <EB12A50964762B4D8111D55B764A84546F8EC3@scsmsx413.amr.corp.intel.com> <44DCE8BA.2070601@rtr.ca>
In-Reply-To: <44DCE8BA.2070601@rtr.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ahhh...

>From the trace, I see a bunch of "userspace" lines appearing.
And sure enough, something called "powernowd" is running,
and probably conflicting with the "ondemand" governor.

I'm nuking powernowd, and that'll probably cure it for this box.
I guess the distro (kubuntu) must have started "powernowd"
even though I told it (the distro) to use "ondemand".

Does it make sense that this could change the upper limit, though?

Thanks guys!
