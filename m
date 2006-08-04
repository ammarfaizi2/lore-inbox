Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932565AbWHDGv4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932565AbWHDGv4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 02:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932590AbWHDGv4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 02:51:56 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:53455 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932565AbWHDGv4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 02:51:56 -0400
Date: Fri, 4 Aug 2006 12:26:15 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: mingo@elte.hu, nickpiggin@yahoo.com.au, sam@vilain.net,
       linux-kernel@vger.kernel.org, dev@openvz.org, efault@gmx.de,
       balbir@in.ibm.com, sekharan@us.ibm.com, nagar@watson.ibm.com,
       haveblue@us.ibm.com, pj@sgi.com
Subject: Re: [RFC, PATCH 0/5] Going forward with Resource Management - A cpu controller
Message-ID: <20060804065615.GA26960@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20060804050753.GD27194@in.ibm.com> <20060803223650.423f2e6a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060803223650.423f2e6a.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2006 at 10:36:50PM -0700, Andrew Morton wrote:
> ug, I didn't know this.  Had I been there (sorry) I'd have disagreed with
> this whole strategy.
> 
> I thought the most recently posted CKRM core was a fine piece of code.  It
> provides the machinery for grouping tasks together and the machinery for
> establishing and viewing those groupings via configfs, and other such
> common functionality.  My 20-minute impression was that this code was an
> easy merge and it was just awaiting some useful controllers to come along.
> 
> And now we've dumped the good infrastructure and instead we've contentrated
> on the controller, wired up via some imaginative ab^H^Hreuse of the cpuset
> layer.

Andrew,
	CPUset was used in this patch series primarily because it
represent a task-grouping mechanism already in the kernel and because
people at the BoF wanted to start with something simple. The idea of using 
cpusets here was not to push this as a final solution, but use it as a means to 
discuss the effects of task-grouping on CPU scheduler.

We had be more than happy to work with the ckrm core which was posted last.
In fact I had sent out the same cpu controller against ckrm core itself last
time around to Nick/Ingo.

> Right.  We won't be controlling memory, numtasks, disk, network etc
> controllers via cpusets, will we?

Agreed. Using CPUset interface makes sense mainly for cpu and memory. 

> Correct me if I'm wrong, but a cpuset isn't the appropriate machinery to be
> using to group tasks.
> 
> And if this whole resource-control effort is to end up being successful, it
> should have as core infrastructure a flexible, appropriate and uniform way
> of grouping tasks together and of getting data into and out of those
> aggregates.  We already have that, don't we?

-- 
Regards,
vatsa
