Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262502AbTICFJJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 01:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262518AbTICFJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 01:09:09 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:19648 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S262502AbTICFJG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 01:09:06 -0400
Date: Tue, 2 Sep 2003 22:08:59 -0700
From: Larry McVoy <lm@bitmover.com>
To: CaT <cat@zip.com.au>
Cc: Larry McVoy <lm@bitmover.com>, Anton Blanchard <anton@samba.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Scaling noise
Message-ID: <20030903050859.GD10257@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>, CaT <cat@zip.com.au>,
	Larry McVoy <lm@bitmover.com>, Anton Blanchard <anton@samba.org>,
	linux-kernel@vger.kernel.org
References: <20030903040327.GA10257@work.bitmover.com> <20030903041850.GA2978@krispykreme> <20030903042953.GC10257@work.bitmover.com> <20030903043355.GC2019@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030903043355.GC2019@zip.com.au>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 03, 2003 at 02:33:56PM +1000, CaT wrote:
> I think Anton is referring to the fact that on a 4-way cpu machine with
> HT enabled you basically have an 8-way smp box (with special conditions)
> and so if 4-way machines are becoming more popular, making sure that 8-way
> smp works well is a good idea.

Maybe this is a better way to get my point across.  Think about more CPUs
on the same memory subsystem.  I've been trying to make this scaling point
ever since I discovered how much cache misses hurt.  That was about 1995
or so.  At that point, memory latency was about 200 ns and processor speeds
were at about 200Mhz or 5 ns.  Today, memory latency is about 130 ns and
processor speeds are about .3 ns.  Processor speeds are 15 times faster and
memory is less than 2 times faster.  SMP makes that ratio worse.

It's called asymptotic behavior.  After a while you can look at the graph
and see that more CPUs on the same memory doesn't make sense.  It hasn't
made sense for a decade, what makes anyone think that is changing?
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
