Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268107AbUH0V7v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268107AbUH0V7v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 17:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262329AbUH0V6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 17:58:50 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:14536 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267927AbUH0VyZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 17:54:25 -0400
Message-Id: <200408272154.i7RLsJk02714@owlet.beaverton.ibm.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
cc: "Martin J. Bligh" <mbligh@aracnet.com>, Con Kolivas <kernel@kolivas.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm1 
In-reply-to: Your message of "Fri, 27 Aug 2004 22:54:58 +0200."
             <200408272254.58646.rjw@sisk.pl> 
Date: Fri, 27 Aug 2004 14:54:18 -0700
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    > Rafael, what baseline release are you comparing to?  I should be able
    > to provide some tools to measure the effect on updatedb directly for
    > both 2.6.9-rc1 and your baseline (so long as it's 2.6-based)
    
    2.6.8.1, for example.  I'd like to compate it with the 2.6.9-rc1-mm1, which 
    contains the Nick's scheduler (2.6.9-rc1 has the same scheduler as 2.6.8.1, 
    AFAIK).

Okay.  A schedstats patch for 2.6.8.1 is available at

    http://eaglet.rain.com/rick/linux/schedstat/patches/schedstat-2.6.8.1
    or
    http://oss.software.ibm.com/linux/patches/?patch_id=730

You can also pick up the program "latency.c" at

    http://eaglet.rain.com/rick/linux/schedstat/v9/latency.c

With these two things in hand, you should be able to measure the latency
on 2.6.8.1 of a particular process.

A patch is not necessary for 2.6.9-rc1-mm1 (schedstats is already in there)
but you will need to config the kernel to use it.  Then retrieve a slightly
different latency.c:
    
    http://eaglet.rain.com/rick/linux/schedstat/v10/latency.c

since 2.6.9-rc1-mm1 output format is different (as you noted, it's a
different scheduler.)  Then you should be able to see if the latency of
a particular process (updatedb, for instance) changes.

Rick
