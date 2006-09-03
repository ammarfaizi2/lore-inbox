Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751435AbWICRMG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435AbWICRMG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 13:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751436AbWICRMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 13:12:06 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:26562 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1751435AbWICRMD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 13:12:03 -0400
Date: Sun, 3 Sep 2006 19:12:02 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Brandon Philips <brandon@ifup.org>
Cc: mingo@elte.hu, rml@tech9.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Export CPU Scheduler Tunables via DebugFS
Message-ID: <20060903171202.GA1290@rhlx01.fht-esslingen.de>
References: <20060903132802.GD10120@plankton.ifup.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060903132802.GD10120@plankton.ifup.org>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Sep 03, 2006 at 08:28:02AM -0500, Brandon Philips wrote:
> This patch exports the CPU scheduler tunables via DebugFS.


> +int min_timeslice;
> +#define MIN_TIMESLICE		(min_timeslice)
> +int def_timeslice;
> +#define DEF_TIMESLICE		(def_timeslice)
> +int on_runqueue_weight;
> +#define ON_RUNQUEUE_WEIGHT	(on_runqueue_weight)
> +int child_penalty;
> +#define CHILD_PENALTY		(child_penalty)
> +int parent_penalty;
> +#define PARENT_PENALTY		(parent_penalty)
> +int exit_weight;
> +#define EXIT_WEIGHT		(exit_weight)
> +int prio_bonus_ratio;
> +#define PRIO_BONUS_RATIO	(prio_bonus_ratio)
> +int max_bonus;
> +#define MAX_BONUS		(max_bonus)
> +int interactive_delta;
> +#define INTERACTIVE_DELTA	(interactive_delta)
> +int max_sleep_avg;
> +#define MAX_SLEEP_AVG		(max_sleep_avg)
> +int starvation_limit;
> +#define STARVATION_LIMIT	(starvation_limit)

__read_mostly? Except for those variables which are being tweaked
quite often by live scheduler code... (probably none)

This only concerns the case of CONFIG_DEBUGFS_SCHED being activated,
but it may still be nice to have, I think, since scheduler stuff
should rather be fast than slow.

But since it is a debugging-only option omitting __read_mostly may
make sense...

Andreas Mohr

-- 
VGER BF report: H 0.00129204
