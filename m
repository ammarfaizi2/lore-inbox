Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261930AbVGKR2x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261930AbVGKR2x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 13:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261941AbVGKR0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 13:26:47 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:36847 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261930AbVGKRZt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 13:25:49 -0400
Subject: Re: Attempted summary of "RT patch acceptance" thread, take 2
From: Daniel Walker <dwalker@mvista.com>
To: paulmck@us.ibm.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050711171910.GE1304@us.ibm.com>
References: <20050711145552.GA1489@us.ibm.com>
	 <1121098272.7050.13.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <20050711164322.GD1304@us.ibm.com>
	 <1121100589.7050.24.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <20050711171910.GE1304@us.ibm.com>
Content-Type: text/plain
Date: Mon, 11 Jul 2005 10:25:28 -0700
Message-Id: <1121102728.7050.29.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-07-11 at 10:19 -0700, Paul E. McKenney wrote:

> OK, interesting point, though this would apply only to interrupt latency,
> not to scheduling latency or to latency for any other system services,
> right?

Only for interrupt latency, that I know of. 

> Do you believe that the 50-us delay measured by Kristian and Karim was
> due to APM or due to hardware (as Karim suspected)?  If the latter,
> any guesses as to the cause of the holdup?  50 us is a -really- long
> time for ~100 instructions on today's hardware, even if each instruction
> misses the cache!

There are ~100 interrupt off critical sections. Those sections can be
variable numbers of instructions. I would imagine that whatever maximum
latency that Kristian and Karim found is the maximum for their hardware.

Daniel

