Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262219AbUCPOx7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 09:53:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262215AbUCPOvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 09:51:14 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:47369 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S262219AbUCPOsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 09:48:25 -0500
Message-ID: <4057174B.3050305@techsource.com>
Date: Tue, 16 Mar 2004 10:03:39 -0500
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Kurt Garloff <garloff@suse.de>
CC: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: dynamic sched timeslices
References: <20040315224201.GX4452@tpkurt.garloff.de>
In-Reply-To: <20040315224201.GX4452@tpkurt.garloff.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Kurt Garloff wrote:
> Hi,
> 
> attached patch allows userspace to tune the scheduling timeslices.
> It can be used for a couple of things:
> * Tune a workload for batch processing:
>   You'd probably wnat to use long timeslices in order to not reschedule
>   as often to make good use of your CPU caches
> * Tune a workload for interactive use:
>   Under load, you may want to reduce the scedulilng latencies by using
>   shorter timeslices (and there are situations where the interactiviy
>   tweak -- even if they were perfect -- can't save you).
> * Tune the ration betweeen maximum and minimum timeslices to make
>   nice much nicer e.g.
> 
> The patch exports /proc/sys/kernel/max_timeslice and min_timeslice,
> unites are us. It also exports HZ (readonly).
> The patch implementes the desktop boot parameter which introduces 
> shorter timeslices.
> 
> Patch is from andrea and is in our 2.4 tree; 2.6 port was done by me and
> straightforward. 
> 
> Regards,

If this doesn't change the total amount of CPU a process can get but 
lets a process tweak how its CPU time is divided up, then it sounds 
wonderful.

