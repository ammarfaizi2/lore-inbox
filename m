Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263157AbUCYOZh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 09:25:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263170AbUCYOZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 09:25:13 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:43994 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263162AbUCYOYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 09:24:51 -0500
Date: Tue, 23 Mar 2004 10:23:40 +0100
From: Pavel Machek <pavel@suse.cz>
To: Kurt Garloff <garloff@suse.de>,
       Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: dynamic sched timeslices
Message-ID: <20040323092340.GD1505@openzaurus.ucw.cz>
References: <20040315224201.GX4452@tpkurt.garloff.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040315224201.GX4452@tpkurt.garloff.de>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

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

If you make ration much bigger, you are going to see
priority inversion issues. Some kind of "boost priority when in
kernel" would be needed...

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

