Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965034AbVKHBRI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965034AbVKHBRI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 20:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965063AbVKHBRH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 20:17:07 -0500
Received: from ozlabs.org ([203.10.76.45]:4488 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S965034AbVKHBRG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 20:17:06 -0500
Date: Tue, 8 Nov 2005 12:15:47 +1100
From: Anton Blanchard <anton@samba.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Brian Twichell <tbrian@us.ibm.com>,
       David Lang <david.lang@digitalinsight.com>,
       linux-kernel@vger.kernel.org, mbligh@mbligh.org, slpratt@us.ibm.com
Subject: Re: Database regression due to scheduler changes ?
Message-ID: <20051108011547.GP12353@krispykreme>
References: <436FD291.2060301@us.ibm.com> <Pine.LNX.4.62.0511071431030.9339@qynat.qvtvafvgr.pbz> <436FDDE2.4000708@us.ibm.com> <436FF6A6.1040708@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <436FF6A6.1040708@yahoo.com.au>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Nick,

> I would also take a look at removing SD_WAKE_IDLE from the flags.
> This flag should make balancing more aggressive, but it can have
> problems when applied to a NUMA domain due to too much task
> movement.

I was wondering how ppc64 ended up with different parameters in the NODE
definitions (added SD_BALANCE_NEWIDLE and SD_WAKE_IDLE)	and it looks
like it was Andrew :)

http://lkml.org/lkml/2004/11/2/205

It looks like balancing was not agressive enough on his workload too.
Im a bit uneasy with only ppc64 having the two flags though.

Im also considering adding balance on fork for ppc64, it seems like a
lot of people like to run stream like benchmarks and Im getting tired of
telling them to lock their threads down to cpus.

Anton
