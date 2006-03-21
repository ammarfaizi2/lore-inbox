Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030406AbWCUO2a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030406AbWCUO2a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 09:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030407AbWCUO23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 09:28:29 -0500
Received: from mail25.syd.optusnet.com.au ([211.29.133.166]:32222 "EHLO
	mail25.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1030406AbWCUO23 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 09:28:29 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: interactive task starvation
Date: Wed, 22 Mar 2006 01:28:06 +1100
User-Agent: KMail/1.9.1
Cc: Mike Galbraith <efault@gmx.de>, Willy Tarreau <willy@w.ods.org>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       bugsplatter@gmail.com
References: <1142592375.7895.43.camel@homer> <200603220119.50331.kernel@kolivas.org> <20060321142504.GA31258@elte.hu>
In-Reply-To: <20060321142504.GA31258@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603220128.07550.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 22 March 2006 01:25, Ingo Molnar wrote:
> * Con Kolivas <kernel@kolivas.org> wrote:
> > What you're fixing with unfairness is worth pursuing. The 'ls' issue
> > just blows my mind though for reasons I've just said. Where are the
> > magic cycles going when nothing else is running that make it take ten
> > times longer?
>
> i believe such artifacts are due to array switches not happening (due to
> the workload getting queued back to rq->active, not rq->expired), and
> 'ls' only gets a timeslice once in a while, every STARVATION_LIMIT
> times. I.e. such workloads penalize the CPU-bound 'ls' process quite
> heavily.

With nothing else running on the machine it should still get all the cpu no 
matter which array it's on though.

Con
