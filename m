Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261299AbULHSbH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261299AbULHSbH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 13:31:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbULHSbH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 13:31:07 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:56230 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261299AbULHSa6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 13:30:58 -0500
Subject: Re: nanosleep resolution, jiffies vs microseconds
From: Darren Hart <dvhltc@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20041208171420.GD1270@us.ibm.com>
References: <1102524468.16986.30.camel@farah.beaverton.ibm.com>
	 <20041208171420.GD1270@us.ibm.com>
Content-Type: text/plain
Date: Wed, 08 Dec 2004 10:30:54 -0800
Message-Id: <1102530654.4060.13.camel@farah.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-12-08 at 09:14 -0800, Paul E. McKenney wrote:
> Hello, Darren,
> 
> Thank you very much for getting to the bottom of this!
> 
> This is mostly an issue when sleeping for small numbers of ticks,
> so if HZ was 10000, a nanosleep(1000000) would get bumped by
> a couple hundred microseconds rather than the current milliseconds,
> right?

yes.

> 
> Further, if one were to do nanosleep(900000) given HZ of 1024,
> the expected sleep time would be 2 milliseconds, right?

and yes.

-- 
Darren Hart <dvhltc@us.ibm.com>
IBM Linux Technology Center

