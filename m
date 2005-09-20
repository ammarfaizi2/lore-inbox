Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932759AbVITOXf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932759AbVITOXf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 10:23:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932760AbVITOXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 10:23:34 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:29946 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932759AbVITOXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 10:23:34 -0400
Date: Tue, 20 Sep 2005 10:23:17 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
To: Ingo Molnar <mingo@elte.hu>
cc: LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH linux-2.6.13-rt14] Priority inversion bug
In-Reply-To: <20050920133706.GA4855@elte.hu>
Message-ID: <Pine.LNX.4.58.0509201013040.5489@localhost.localdomain>
References: <1127162309.5097.15.camel@localhost.localdomain>
 <20050920133706.GA4855@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 20 Sep 2005, Ingo Molnar wrote:
> thanks - added it to my tree. I'm wondering why it never showed up in
> practice?

How do we know if it hasn't?  It wouldn't bug, you may just have a longer
latency on the higher priority process than what should be. It did happen
on my kernel, and the way I found that it did, was that I had a test in
the passing of ownership to make sure that the one that got the lock is
indeed the highest priority process. Without this check, we probably
would never know.

-- Steve

