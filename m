Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965022AbWA1QJD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965022AbWA1QJD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 11:09:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965020AbWA1QJD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 11:09:03 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:41451 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S965013AbWA1QJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 11:09:02 -0500
Date: Sat, 28 Jan 2006 10:08:49 -0600
From: Jack Steiner <steiner@sgi.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org,
       Robert Love <rml@novell.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.16 - sys_sched_getaffinity & hotplug
Message-ID: <20060128160849.GA23677@sgi.com>
References: <20060127230659.GA4752@sgi.com> <20060127191400.aacb8539.pj@sgi.com> <20060128133244.GA22704@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060128133244.GA22704@elte.hu>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2006 at 02:32:44PM +0100, Ingo Molnar wrote:
> 
> * Paul Jackson <pj@sgi.com> wrote:
> 
> > Jack wrote:
> > > Should the following change be made to sched_getaffinity(). 
> > > 
> > > Index: linux/kernel/sched.c
> > > ===================================================================
> > > --- linux.orig/kernel/sched.c	2006-01-25 08:50:21.401747695 -0600
> > > +++ linux/kernel/sched.c	2006-01-27 16:57:24.504871895 -0600
> > > @@ -4031,7 +4031,7 @@ long sched_getaffinity(pid_t pid, cpumas
> > >  		goto out_unlock;
> > >  
> > >  	retval = 0;
> > > -	cpus_and(*mask, p->cpus_allowed, cpu_possible_map);
> > > +	cpus_and(*mask, p->cpus_allowed, cpu_online_map);
> > 
> > Adding Robert Love to the cc list, as he is Mr. sched_getaffinity, I 
> > believe.
> 
> i'm to blame for the syscall, Robert is to blame for the tool side
> :-) In any case, Jack's change looks reasonable and obviously correct.
> 
> Acked-by: Ingo Molnar <mingo@elte.hu>
> 
> 	Ingo

Ok, thanks. I'll repost as a patch later today....


-- 
Thanks

Jack Steiner (steiner@sgi.com)          651-683-5302


