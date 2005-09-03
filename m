Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161136AbVICFVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161136AbVICFVF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 01:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161138AbVICFVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 01:21:05 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:46475 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161136AbVICFVD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 01:21:03 -0400
Date: Sat, 3 Sep 2005 10:50:33 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org, s0348365@sms.ed.ac.uk,
       kernel@kolivas.org, tytso@mit.edu, cfriesen@nortel.com, trenn@suse.de,
       george@mvista.com, johnstul@us.ibm.com, akpm@osdl.org
Subject: Re: [PATCH 1/3] Updated dynamic tick patches - Fix lost tick calculation in timer_pm.c
Message-ID: <20050903052033.GC5098@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20050831165843.GA4974@in.ibm.com> <20050831171211.GB4974@in.ibm.com> <1125720301.4991.41.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1125720301.4991.41.camel@mindpipe>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 03, 2005 at 12:05:00AM -0400, Lee Revell wrote:
> Are lost ticks really that common?  If so, any idea what's disabling

It becomes common with a patch like dynamic ticks, where we purposefully
skip ticks when CPU is idle. When the CPU wakes up, we have to regain
the lost/skipped ticks and thats where I ran into incorrect lost-tick
calculation issues.

> interrupts for so long (or if it's a hardware issue)?  And if not, it
> seems like you'd need an artificial way to simulate lost ticks in order
> to test this stuff.

Dyn-tick patch is enought to simulate these lost ticks!

-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
