Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270930AbTHOVBP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 17:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270939AbTHOVBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 17:01:15 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:50957
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S270930AbTHOVBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 17:01:13 -0400
Date: Fri, 15 Aug 2003 14:01:11 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       gaxt <gaxt@rogers.com>, Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH] O16int for interactivity
Message-ID: <20030815210111.GP1027@matchmail.com>
Mail-Followup-To: Con Kolivas <kernel@kolivas.org>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
	gaxt <gaxt@rogers.com>, Mike Galbraith <efault@gmx.de>
References: <200308160149.29834.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308160149.29834.kernel@kolivas.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 16, 2003 at 01:49:06AM +1000, Con Kolivas wrote:
> Changes:
> Waker is now kept track of.
> 
> Only user tasks have the bonus ceiling from uninterruptible sleep.
> 
> Preemption of tasks at the same level with twice as much timeslice has been 
> dropped as this is not necessary with timeslice granularity (may improve 
> performance of cpu intensive tasks).
> 
> Preemption of user tasks is limited to those in the interactive range; cpu 
> intensive non interactive tasks can run out their full timeslice (may also 
> improve cpu intensive performance)
> 
> Tasks cannot preempt their own waker.
> 
> Cleanups etc.

Con, given the problems reported, maybe each of these should be in a
different changeset (OXXint, etc...).

Seeing the large number of changes, compared to previous releases gave me a
pause on this patch.  So I waited a few minutes and there was a problem
report quickly.

Is there any way you can provide each change in a seperate patch, so we can
narrow down the problem patch? (I have a feeling that most of your changes will do a
lot of good)

Mike
