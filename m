Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263800AbTL3B1Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 20:27:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264141AbTL3B1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 20:27:24 -0500
Received: from [24.35.117.106] ([24.35.117.106]:63370 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S263800AbTL3B1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 20:27:22 -0500
Date: Mon, 29 Dec 2003 20:27:21 -0500 (EST)
From: Thomas Molina <tmolina@cablespeed.com>
X-X-Sender: tmolina@localhost.localdomain
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0 performance problems
In-Reply-To: <Pine.LNX.4.58.0312291647410.5288@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0312292020190.6227@localhost.localdomain>
References: <Pine.LNX.4.58.0312291647410.5288@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Dec 2003, Thomas Molina wrote:
> Under 2.4 top shows: 
> 
> user	nice	system	irq	softirq	iowait	idle
> 1.3	0	2.1	0	0	0	96.6
> 
> Execution time for the test was:
> real	13m33.482s
> user	0m33.540s
> sys	0m16.210s

A suggestion was made that readahead might make a difference.  Changing 
readahead under 2.4 from default of 8 to 255 the times went to:

real    13m50.198s
user    0m33.780s
sys     0m15.390s


> Under 2.6 top shows:
> user	nice	system	irq	softirq	iowait	idle
> 0.9	0	5.3	0.9	0.3	92.6	0
> 
> Execution time for the test was:
> real	22m42.397s
> user	0m37.753s
> sys	0m54.043s


Changing 2.6 to 8 from 255 changed times:

real    25m39.653s
user    0m37.594s
sys     0m55.454s


I'll try the suggestion of 8192 for 2.6 later.  hdparm won't let me set 
readahead more than 255 for 2.4.  I'm currently recompiling for profiling 
support.  I'm ashamed to say that wasn't configured in.

Linus, once I get that finished and do some testing I'll post results.
