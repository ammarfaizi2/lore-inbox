Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266894AbUIOC7o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266894AbUIOC7o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 22:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266903AbUIOC7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 22:59:44 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:62391 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266894AbUIOC7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 22:59:42 -0400
Subject: Re: [patch] sched: fix scheduling latencies for !PREEMPT kernels
From: Lee Revell <rlrevell@joe-job.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Robert Love <rml@ximian.com>,
       Andrea Arcangeli <andrea@novell.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040915023611.GH9106@holomorphy.com>
References: <41470021.1030205@yahoo.com.au>
	 <20040914150316.GN4180@dualathlon.random>
	 <1095185103.23385.1.camel@betsy.boston.ximian.com>
	 <20040914185212.GY9106@holomorphy.com>
	 <1095188569.23385.11.camel@betsy.boston.ximian.com>
	 <20040914192104.GB9106@holomorphy.com>
	 <1095189593.16988.72.camel@localhost.localdomain>
	 <1095207749.2406.36.camel@krustophenia.net>
	 <20040915014610.GG9106@holomorphy.com>
	 <1095213644.2406.90.camel@krustophenia.net>
	 <20040915023611.GH9106@holomorphy.com>
Content-Type: text/plain
Message-Id: <1095217186.2406.121.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 14 Sep 2004 22:59:46 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-14 at 22:36, William Lee Irwin III wrote:
> I have neither of these locally. I suspect someone needs to care enough
> about the code for anything to happen soon. I suppose there are things
> that probably weren't tried, e.g. auditing to make sure dependencies on
> external synchronization are taken care of, removing implicit sleeping
> with the BKL held, then punt a private recursive spinlock in reiser3's
> direction. Not sure what went on, or if I want to get involved in this
> particular case.
> 

There isn't really any information in the archives about what was
tried.  Here's Andrew's message:

http://lkml.org/lkml/2004/7/12/266

And Hans':

http://lkml.org/lkml/2004/8/10/320

I suspect that "Use reiser4 (or ext3) if you care about latency" is a
good enough answer for most people.

Lee

