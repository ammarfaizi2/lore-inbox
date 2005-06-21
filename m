Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261831AbVFUOzs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261831AbVFUOzs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 10:55:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261980AbVFUOzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 10:55:48 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:40657 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261831AbVFUOzn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 10:55:43 -0400
Message-ID: <42B82A4F.5090804@nortel.com>
Date: Tue, 21 Jun 2005 08:55:11 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: john stultz <johnstul@us.ibm.com>, Roman Zippel <zippel@linux-m68k.org>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       George Anzinger <george@mvista.com>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
Subject: Re: [PATCH 1/6] new timeofday core subsystem for -mm (v.B3)
References: <1119063400.9663.2.camel@cog.beaverton.ibm.com>	 <Pine.LNX.4.61.0506181344000.3743@scrub.home>	 <1119287354.9947.22.camel@cog.beaverton.ibm.com>	 <1119291034.16180.9.camel@mindpipe>	 <1119304422.9947.90.camel@cog.beaverton.ibm.com> <1119311096.17701.3.camel@mindpipe>
In-Reply-To: <1119311096.17701.3.camel@mindpipe>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:

> But some user space apps are now *required* to use rdtsc for timing due
> to the massive performance difference.  If we only took a 5x or 10x
> performance hit vs rdtsc, rather than the current 50x, it might be
> enough that user space apps won't have to do this.

For my userspace apps I've actually switched to 
clock_gettime(CLOCK_MONOTONIC, &ts);

This at least guarantees that it will never go backwards.

For the experts: Is there a clock exported to userspace that is both 
monotonic and uniform?  Does CLOCK_MONOTONIC give this on linux?


Chris
