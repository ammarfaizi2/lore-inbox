Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261806AbUKPUWG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261806AbUKPUWG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 15:22:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbUKPUTs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 15:19:48 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:60309 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261783AbUKPUSv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 15:18:51 -0500
Date: Tue, 16 Nov 2004 14:18:41 -0600
From: Dean Nelson <dcn@sgi.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Chris Wright <chrisw@osdl.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch] export sched_setscheduler() for kernel module use
Message-ID: <20041116201841.GA29687@sgi.com>
References: <4198F70D.mailxMSZ11J00J@aqua.americas.sgi.com> <20041115105801.T14339@build.pdx.osdl.net> <20041115203343.GA32173@sgi.com> <20041116104821.GA31395@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041116104821.GA31395@elte.hu>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2004 at 11:48:21AM +0100, Ingo Molnar wrote:
> 
> * Dean Nelson <dcn@sgi.com> wrote:
> 
> > On Mon, Nov 15, 2004 at 10:58:01AM -0800, Chris Wright wrote:
> > > * Dean Nelson (dcn@sgi.com) wrote:
> > > > +int do_sched_setscheduler(pid_t pid, int policy, struct sched_param __user *param)
> > > 
> > > this should be static.
> > 
> > You're right. I made another change in that one now passes the
> > task_struct pointer to sched_setscheduler() instead of the pid. This
> > requires that the caller of sched_setscheduler() hold the
> > tasklist_lock. The new patch for people's feedback follows.
> 
> could you make sched_setscheduler() also include a parameter for the
> nice value, so that ->static_prio could be set at the same time too
> (which would have relevance if SCHED_OTHER is used)? This would make it
> a generic kernel-internal API to change all the priority parameters.
> Looks good otherwise.

Yeah, I can do that. I'll probably be getting back to you with a
question or two, if what you're after isn't obvious once I start
making the changes for the nice parameter.

Thanks,
Dean
