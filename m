Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288113AbSAVD4O>; Mon, 21 Jan 2002 22:56:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288185AbSAVDzz>; Mon, 21 Jan 2002 22:55:55 -0500
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:43660 "EHLO
	rwcrmhc53.attbi.com") by vger.kernel.org with ESMTP
	id <S288113AbSAVDzr>; Mon, 21 Jan 2002 22:55:47 -0500
Content-Type: text/plain; charset=US-ASCII
From: Adam Keys <akeys@post.cis.smu.edu>
To: "Partha Narayanan" <partha@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: Performance Results for Ingo's O(1)-scheduler
Date: Mon, 21 Jan 2002 21:55:32 -0600
X-Mailer: KMail [version 1.3.2]
Cc: mingo@elte.hu
In-Reply-To: <OF4544D2BC.16B7A12D-ON85256B48.00817250@raleigh.ibm.com>
In-Reply-To: <OF4544D2BC.16B7A12D-ON85256B48.00817250@raleigh.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020122035540.ZUVU10199.rwcrmhc53.attbi.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 21, 2002 06:03, Partha Narayanan wrote:
> Here are some results from running VolanoMark on different
> versions of O(1)-scheduler based on 2.4.17.
>
> VolanoMark 2.1.2 Loopback test,
> 8-way 700MHZ Pentium III,
> 1GB Kernel,
> IBM JVM 1.3. (build cx 130 -20010626)
> Throughput in msg/sec
>
>
> KERNEL              UP          4-way       8-way
> =========           ======      ======      ======
>
> 2.4.17              11005       15894       11595
>
> 2.4.17 + D2 patch   10606       23300       29726
>
> 2.4.17 + G1 patch   10415       23038       31098
>
> 2.4.17 + H6 patch   10914       22270       32300
>
> 2.4.17 + H7 patch   11018       23427       31674
>
> 2.4.17 + J2 patch   13015       23071       33259

I'm curious about the performance of the 4-way and 8-way systems.  I know 
nothing about this benchmark.  IIRC correctly it simulates chat clients 
connecting to a server and talking to each other.  Is it a CPU, memory, or 
disk bound benchmark?  What is causing the 4-way machines to be only 2x the 
performance of the 1-way machine and the 8-way machines to be < 3x the 
performance?  Is the system bus the limiting factor on those machines?

Curiosity aside, it looks like Ingo's scheduler is coming along nicely.

-- 
akk~
