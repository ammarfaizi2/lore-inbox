Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266665AbUGQIqa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266665AbUGQIqa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jul 2004 04:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266667AbUGQIqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jul 2004 04:46:30 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:23044 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S266665AbUGQIq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jul 2004 04:46:28 -0400
Subject: Re: 2.6.8-rc1-np1
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <40F8B7C5.9030201@yahoo.com.au>
References: <40F8B7C5.9030201@yahoo.com.au>
Content-Type: text/plain
Date: Sat, 17 Jul 2004 10:45:43 +0200
Message-Id: <1090053943.1828.4.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.90 (1.5.90-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-07-17 at 15:23 +1000, Nick Piggin wrote:

> Scheduler behaviour is generally pretty good now so I've increased the
> timeslice size to see how far I can push it. Some workloads really demand
> small timeslices though, so I've added /proc/sys/kernel/base_timeslice.
> If you have any problems with the default, please report it to me, and
> check if lowering this value helps.

On my 700Mhz Pentium III Mobile laptop, I feel that 256ms is too high
for the system to keep interactive when a CPU hog is running. For
example, running "while true; do a=2; done" makes the system pretty
sluggish with the default timeslice. This is noticeable while dragging
windows around (the movement is jerky and doesn't feel smooth).
Decreasing the timeslie to 50ms, or even better, 25ms, makes the system
behave much much better, although it will decrease throughput
considerably, I guess.

For light to low worloads, the default of 256ms seems acceptable,
though.

PS: I will test -np1 on my 2Ghz PIV machine very soon.

