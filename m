Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272234AbTHNHAS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 03:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272235AbTHNHAR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 03:00:17 -0400
Received: from holomorphy.com ([66.224.33.161]:51384 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S272234AbTHNHAM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 03:00:12 -0400
Date: Thu, 14 Aug 2003 00:01:19 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: Timothy Miller <miller@techsource.com>, rob@landley.net,
       Charlie Baylis <cb-lkml@fish.zetnet.co.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] O12.2int for interactivity
Message-ID: <20030814070119.GN32488@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Con Kolivas <kernel@kolivas.org>,
	Timothy Miller <miller@techsource.com>, rob@landley.net,
	Charlie Baylis <cb-lkml@fish.zetnet.co.uk>,
	linux-kernel@vger.kernel.org
References: <20030804195058.GA8267@cray.fish.zetnet.co.uk> <3F3A5D61.7080207@techsource.com> <20030814060959.GK32488@holomorphy.com> <200308141659.33447.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308141659.33447.kernel@kolivas.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Aug 2003 16:09, William Lee Irwin III wrote:
>> "scale" on which scheduling events should happen, and as tasks become
>> more cpu-bound, they have longer timeslices, so that two cpu-bound
>> tasks of identical priority will RR very slowly and have reduced
>> context switch overhead, but are near infinitely preemptible by more
>> interactive or short-running tasks.

On Thu, Aug 14, 2003 at 04:59:33PM +1000, Con Kolivas wrote:
> Actually the timeslice handed out is purely dependent on the static priority, 
> not the priority it is elevated or demoted to by the interactivity estimator. 
> However lower priority tasks (cpu bound ones if the estimator has worked 
> correctly) will always be preempted by higher priority tasks (interactive 
> ones) whenever they wake up.

So it is; the above commentary was rather meant to suggest that the
lengthening of timeslices in conventional arrangements did not penalize
interactive tasks, not to imply that priority preemption was not done
at all in the current scheduler.


-- wli
