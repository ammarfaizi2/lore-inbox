Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932145AbWDFEaF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbWDFEaF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 00:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932148AbWDFEaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 00:30:05 -0400
Received: from mail18.syd.optusnet.com.au ([211.29.132.199]:18136 "EHLO
	mail18.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932145AbWDFEaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 00:30:03 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Mike Galbraith <efault@gmx.de>
Subject: Re: [patch 2.6.16-mm2 10/9] sched throttle tree extract - kill interactive task feedback loop
Date: Thu, 6 Apr 2006 14:29:39 +1000
User-Agent: KMail/1.9.1
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>,
       Peter Williams <pwil3058@bigpond.net.au>,
       Nick Piggin <nickpiggin@yahoo.com.au>
References: <1143880124.7617.5.camel@homer> <200604060915.07036.kernel@kolivas.org> <1144296619.7436.8.camel@homer>
In-Reply-To: <1144296619.7436.8.camel@homer>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604061429.40207.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 06 April 2006 14:10, Mike Galbraith wrote:
> On Thu, 2006-04-06 at 09:15 +1000, Con Kolivas wrote:
> > On Thursday 06 April 2006 03:38, Mike Galbraith wrote:
> > > -	if (!rt_task(next) && interactive_sleep(next->sleep_type)) {
> > > +	if (!TASK_INTERACTIVE(next) && interactive_sleep(next->sleep_type)) {
> >
> > You can't remove that rt_task check from there can you? We shouldn't ever
> > requeue a rt task.
>
> RT tasks are always interactive aren't they?  (I'll check)

No, they're always equal to their static_prio. This rt_task check was added 
originally because it was found to inappropriately be requeueing SCHED_FIFO 
tasks.

Cheers,
Con
