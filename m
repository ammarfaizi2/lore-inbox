Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268486AbUHXD07@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268486AbUHXD07 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 23:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268479AbUHXD06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 23:26:58 -0400
Received: from jade.spiritone.com ([216.99.193.136]:26583 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S268539AbUHXD0V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 23:26:21 -0400
Date: Mon, 23 Aug 2004 20:26:13 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Nick Piggin <piggin@cyberone.com.au>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Performance of -mm2 and -mm4
Message-ID: <16660000.1093317972@[10.10.2.4]>
In-Reply-To: <412AB4AC.8040702@cyberone.com.au>
References: <336080000.1093280286@[10.10.2.4]> <412AB4AC.8040702@cyberone.com.au>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Martin J. Bligh wrote:
> 
>> Kernbench: (make -j vmlinux, maximal tasks)
>>                              Elapsed      System        User         CPU
>>                  2.6.8.1       43.90       87.76      572.94     1505.67
>>              2.6.8.1-mm1       44.26       87.71      574.73     1496.33
>>              2.6.8.1-mm2       44.27       90.27      574.84     1502.33
>>              2.6.8.1-mm4       45.87       97.60      595.23     1510.00
>> 
>> mm2 seems to take slightly (but consistently) more systime than mm1, and
>> mm4 is significantly worse still ;-(
>> 
>> 
> 
> Increasing base_timeslice here takes about 10s off the user time,
> and maybe 1-2 off elapsed. You may see a better improvement because
> the machine I'm testing on has very small caches; I assume you are
> using a 32-way NUMAQ with 1-2MB caches?

16-way with 2MB caches. Doing 256 as opposed to 64 gives a little less
user time, more systime at the low end, and a wash with more tasks.
Not much affects elapsed though. I'll try 16, then backing out the 
sched patch, and what Jesse suggested as well.

M.

