Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266127AbUHPFOa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266127AbUHPFOa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 01:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267438AbUHPFOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 01:14:30 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:13955 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266127AbUHPFO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 01:14:29 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P0
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
In-Reply-To: <20040816045110.GA15841@elte.hu>
References: <1092432929.3450.78.camel@mindpipe>
	 <20040814072009.GA6535@elte.hu> <20040815115649.GA26259@elte.hu>
	 <20040816022554.16c3c84a@mango.fruits.de>
	 <1092622121.867.109.camel@krustophenia.net> <20040816024314.GA8960@elte.hu>
	 <20040816030818.GA10685@elte.hu> <1092629953.810.23.camel@krustophenia.net>
	 <20040816042653.GA14738@elte.hu> <1092630624.810.30.camel@krustophenia.net>
	 <20040816045110.GA15841@elte.hu>
Content-Type: text/plain
Message-Id: <1092633318.801.11.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 16 Aug 2004 01:15:19 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-16 at 00:51, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:

> seems we need a lock-break in the innermost loop of copy_page_range(). 
> That loop processes up to 1024 pages currently, before the lock-break in
> the outer loop happens. Large GUI processes are more likely to have full
> 4MB regions mapped & populated.
> 
> i suspect you could trigger a similarly bad latency by doing a fork() in
> mlockall-test.cc - the attached mlockall-test2.cc does this. Do you get
> bad latencies?
> 

Yes, mlockall-test2 with 10+MB of memory produces a 200us-3ms xrun about
half the time.

Lee 

