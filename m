Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262192AbTE0BCl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 21:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262195AbTE0BCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 21:02:41 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:14506 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S262192AbTE0BCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 21:02:09 -0400
Date: Tue, 27 May 2003 02:16:20 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Andrea Arcangeli <andrea@suse.de>
Cc: "David S. Miller" <davem@redhat.com>, akpm@digeo.com, davidsen@tmr.com,
       haveblue@us.ibm.com, habanero@us.ibm.com, mbligh@aracnet.com,
       linux-kernel@vger.kernel.org
Subject: Re: userspace irq balancer
Message-ID: <20030527011620.GB7135@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Andrea Arcangeli <andrea@suse.de>,
	"David S. Miller" <davem@redhat.com>, akpm@digeo.com,
	davidsen@tmr.com, haveblue@us.ibm.com, habanero@us.ibm.com,
	mbligh@aracnet.com, linux-kernel@vger.kernel.org
References: <20030527000639.GA3767@dualathlon.random> <20030526.171527.35691510.davem@redhat.com> <20030527004115.GD3767@dualathlon.random> <20030526.174841.116378513.davem@redhat.com> <20030527010903.GF3767@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030527010903.GF3767@dualathlon.random>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 27, 2003 at 03:09:03AM +0200, Andrea Arcangeli wrote:

 > > So I'm asking you, again, how are you going to measure softirq load in
 > > making hardware IRQ load balancing decisions?  Watching the scheduling
 > 
 > rdtsc could do it very well, irqs and softirqs can't be rescheduled so
 > you can tick measure how long you take in each cpu

On CPUs that vary frequency, this will break, unless TSC scales
with frequency. You cannot assume that this will be the case.

		Dave

