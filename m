Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261814AbVDEQjr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261814AbVDEQjr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 12:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261811AbVDEQj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 12:39:28 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:1248 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261808AbVDEQir (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 12:38:47 -0400
Subject: Re: ext3 allocate-with-reservation latencies
From: Lee Revell <rlrevell@joe-job.com>
To: cmm@us.ibm.com
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1112681424.3811.42.camel@localhost.localdomain>
References: <1112673094.14322.10.camel@mindpipe>
	 <20050405041359.GA17265@elte.hu>
	 <1112681424.3811.42.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 05 Apr 2005 12:38:42 -0400
Message-Id: <1112719122.15473.3.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-04-04 at 23:10 -0700, Mingming Cao wrote:
> On Tue, 2005-04-05 at 06:13 +0200, Ingo Molnar wrote:
> > * Lee Revell <rlrevell@joe-job.com> wrote:
> > 
> > > I can trigger latencies up to ~1.1 ms with a CVS checkout.  It looks
> > > like inside ext3_try_to_allocate_with_rsv, we spend a long time in this
> > > loop:
> > > 
> 
> We have not modify the reservation create algorithm for a long time.
> Sorry, I missed the background here, on which kernel did you see this
> latency? And what tests you were running?

Makes sense, I have been seeing this one for a long time.  I get it with
dbench, or when doing a CVS checkout of a large module.

Kernel is 2.6.12-rc1-RT-V0.7.43-05, with PREEMPT_DESKTOP which AFAIK
should be equivalent to mainline.

Lee

