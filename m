Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964953AbWCURun@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964953AbWCURun (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 12:50:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964968AbWCURun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 12:50:43 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:3084 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S964953AbWCURum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 12:50:42 -0500
Date: Tue, 21 Mar 2006 18:50:04 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: Mike Galbraith <efault@gmx.de>, Ingo Molnar <mingo@elte.hu>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       bugsplatter@gmail.com
Subject: Re: interactive task starvation
Message-ID: <20060321175004.GA27303@w.ods.org>
References: <200603090036.49915.kernel@kolivas.org> <1142949690.7807.80.camel@homer> <200603220117.54822.kernel@kolivas.org> <200603220220.11368.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603220220.11368.kernel@kolivas.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2006 at 02:20:10AM +1100, Con Kolivas wrote:
> On Wednesday 22 March 2006 01:17, Con Kolivas wrote:
> > I actually believe the same effect can be had by a tiny 
> > modification to enable/disable the estimator anyway.
> 
> Just for argument's sake it would look something like this.
> 
> Cheers,
> Con
> ---
> Add sysctl to enable/disable cpu scheduer interactivity estimator

At least, in May 2005, the equivalent of this patch I tested on
2.6.11.7 considerably improved responsiveness, but there was still
this very annoying slowdown when the load increased. vmstat delays
increased by one second every 10 processes. I retried again around
2.6.14 a few months ago, and it was the same. Perhaps Mike's code
and other changes in 2.6-mm really fix the initial problem (array
switching ?) and then only the interactivity boost is causing the
remaining trouble ?

Cheers,
Willy

