Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270271AbTGRSE3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 14:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270272AbTGRSE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 14:04:29 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:58600 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S270271AbTGRSE1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 14:04:27 -0400
Date: Fri, 18 Jul 2003 11:18:50 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: Erich Focht <efocht@hpce.nec.com>
Cc: LSE <lse-tech@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] [patch 2.6.0-test1] per cpu times
Message-ID: <20030718111850.C1627@w-mikek2.beaverton.ibm.com>
References: <200307181835.42454.efocht@hpce.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200307181835.42454.efocht@hpce.nec.com>; from efocht@hpce.nec.com on Fri, Jul 18, 2003 at 06:35:42PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 18, 2003 at 06:35:42PM +0200, Erich Focht wrote:
>
> This patch brings back the per CPU user & system times which one was
> used to see in /proc/PID/cpu with 2.4 kernels. Useful for SMP and NUMA
> scheduler development, needed for reasonable output in numabench /
> numa_test.
>

On a somewhat related note ...

We (Big Blue) have a performance reporting application that
would like to know how long a task sits on a runqueue before
it is actually given the CPU.  In other words, it wants to
know how long the 'runnable task' was delayed due to contention
for the CPU(s).  Of course, one could get an overall feel for
this based on total runqueue length.  However, this app would
really like this info on a per-task basis.

Does anyone else think this type of info would be useful?

A patch to compute/export this info should be straight forward
to implement.

-- 
Mike
