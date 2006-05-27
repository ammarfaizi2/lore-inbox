Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750955AbWE0Io0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750955AbWE0Io0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 04:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751445AbWE0Io0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 04:44:26 -0400
Received: from omta03ps.mx.bigpond.com ([144.140.82.155]:53708 "EHLO
	omta03ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1750955AbWE0IoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 04:44:25 -0400
Message-ID: <44781167.6060700@bigpond.net.au>
Date: Sat, 27 May 2006 18:44:23 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Balbir Singh <bsingharora@gmail.com>
CC: Mike Galbraith <efault@gmx.de>, Con Kolivas <kernel@kolivas.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Kingsley Cheung <kingsley@aurema.com>, Ingo Molnar <mingo@elte.hu>,
       Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [RFC 3/5] sched: Add CPU rate hard caps
References: <20060526042021.2886.4957.sendpatchset@heathwren.pw.nest>	 <20060526042051.2886.70594.sendpatchset@heathwren.pw.nest> <661de9470605262348s52401792x213f7143d16bada3@mail.gmail.com>
In-Reply-To: <661de9470605262348s52401792x213f7143d16bada3@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta03ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Sat, 27 May 2006 08:44:23 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir Singh wrote:
> 
> Using a timer for releasing tasks from their sinbin sounds like a  bit
> of an overhead. Given that there could be 10s of thousands of tasks.

The more runnable tasks there are the less likely it is that any of them 
is exceeding its hard cap due to normal competition for the CPUs.  So I 
think that it's unlikely that there will ever be a very large number of 
tasks in the sinbin at the same time.

> Is it possible to use the scheduler_tick() function take a look at all
> deactivated tasks (as efficiently as possible) and activate them when
> its time to activate them or just fold the functionality by defining a
> time quantum after which everyone is worken up. This time quantum
> could be the same as the time over which limits are honoured.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
