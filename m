Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751526AbWEULd1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751526AbWEULd1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 07:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751527AbWEULd1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 07:33:27 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:32940 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751524AbWEULd1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 07:33:27 -0400
Date: Sun, 21 May 2006 16:59:08 +0530
From: Balbir Singh <balbir@in.ibm.com>
To: Martin Peschke <mp3@de.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [Patch 0/6] statistics infrastructure
Message-ID: <20060521112908.GA13773@in.ibm.com>
Reply-To: balbir@in.ibm.com
References: <1148054876.2974.10.camel@dyn-9-152-230-71.boeblingen.de.ibm.com> <20060519092411.6b859b51.akpm@osdl.org> <446E4ED6.6020000@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <446E4ED6.6020000@de.ibm.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Andrew, Balbir,
> 
> I will read Balbir's patches. Probably, I won't manage it this weekend,
> as a friend of mine is visiting.
> 
> Why doesn't come it as a surprise that the user interface appears to
> restart the discussion ;-)
> I can't comment on netlink yet. There are some thoughts on why I
> chose debugfs in my documentation file.
> 
> Balbir, could you try to summarise briefly what the main issues are that
> your patches solve?
>

We collect statistics about the delays that are experienced by each task on
the system. Note, that this information is per-task.

The information collected provides us with information about the number of
times the the task executed on the runqueue, the delay it encountered
waiting for CPU (run_delay) and the total time it spent on the runqueue.
Similar statistics are collected for block io and swapin block io.

The statistics can be queried at any time (during the lifetime of the task)
and user space can be notified of the statistics when the task exits.

More detailed information can be found at
http://lkml.org/lkml/2006/5/2/30

and in the Documentation/accounting directory tree in -mm

I hope this is the summary you were looking for.

	Warm Regards,
	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
