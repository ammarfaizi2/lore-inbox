Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262410AbSJTGSU>; Sun, 20 Oct 2002 02:18:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262414AbSJTGSU>; Sun, 20 Oct 2002 02:18:20 -0400
Received: from franka.aracnet.com ([216.99.193.44]:24508 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262410AbSJTGSU>; Sun, 20 Oct 2002 02:18:20 -0400
Date: Sat, 19 Oct 2002 23:18:16 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Bill Davidsen <davidsen@tmr.com>, Dave McCracken <dmccr@us.ibm.com>
cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [PATCH 2.5.43-mm2] New shared page table patch
Message-ID: <2458064740.1035069495@[10.10.2.3]>
In-Reply-To: <Pine.LNX.3.96.1021019151523.29078E-200000@gatekeeper.tmr.com>
References: <Pine.LNX.3.96.1021019151523.29078E-200000@gatekeeper.tmr.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> For reference, one of the tests was TPC-H.  My code reduced the number of
>> allocated pte_chains from 5 million to 50 thousand.
> 
> Don't tease, what did that do for performance? I see that someone has
> already posted a possible problem, and the code would pass for complex for
> most people, so is the gain worth the pain?

In many cases, this will stop the box from falling over flat on it's 
face due to ZONE_NORMAL exhaustion (from pte-chains), or even total
RAM exhaustion (from PTEs). Thus the performance gain is infinite ;-)

M.

