Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262770AbUCOXBY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 18:01:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262667AbUCOXBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 18:01:23 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:25868 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262770AbUCOW7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 17:59:40 -0500
Date: Mon, 15 Mar 2004 22:59:39 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Kurt Garloff <garloff@suse.de>,
       Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: dynamic sched timeslices
Message-ID: <20040315225939.A23686@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Kurt Garloff <garloff@suse.de>,
	Linux kernel list <linux-kernel@vger.kernel.org>
References: <20040315224201.GX4452@tpkurt.garloff.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040315224201.GX4452@tpkurt.garloff.de>; from garloff@suse.de on Mon, Mar 15, 2004 at 11:42:01PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2004 at 11:42:01PM +0100, Kurt Garloff wrote:
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

Remove the silly desktop boot parameter and the patch looks basically
okay to me.

I remember we had a more complete patch to allow tuning the scheduler
through sysctls in -mm once, though.  Questions is why that one wasn't
merged and if the same reasons apply to a 'light' version.

