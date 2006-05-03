Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965132AbWECHku@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965132AbWECHku (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 03:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965047AbWECHku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 03:40:50 -0400
Received: from ns2.suse.de ([195.135.220.15]:12161 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965132AbWECHkt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 03:40:49 -0400
From: Andi Kleen <ak@suse.de>
To: Mike Galbraith <efault@gmx.de>
Subject: Re: sched_clock() uses are broken
Date: Wed, 3 May 2006 09:40:19 +0200
User-Agent: KMail/1.9.1
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Christopher Friesen <cfriesen@nortel.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org
References: <20060502132953.GA30146@flint.arm.linux.org.uk> <445791D3.9060306@yahoo.com.au> <1146640155.7526.27.camel@homer>
In-Reply-To: <1146640155.7526.27.camel@homer>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605030940.20409.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 May 2006 09:09, Mike Galbraith wrote:

> Given that most people are going to end up using the pm_timer anyway, I
> don't see the point of even having a sched_clock().  If it's jiffy
> resolution, it's useless.  If it's wildly inaccurate (as it is in the
> SMP case, monotonicity issues aside) it's more than useless.

For sched_clock TSC is always used and it's fine - sched_clock
doesn't require the guarantees that make TSC often useless otherwise

e.g. the scheduler is designed to only use it on one CPU 
and can also tolerate variations scaling with frequency.

-Andi
