Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263879AbTE0P0U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 11:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263894AbTE0P0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 11:26:20 -0400
Received: from franka.aracnet.com ([216.99.193.44]:37030 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263879AbTE0P0A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 11:26:00 -0400
Date: Tue, 27 May 2003 08:38:52 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Erich Focht <efocht@hpce.nec.com>, Andi Kleen <ak@suse.de>
cc: LSE <lse-tech@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] Node affine NUMA scheduler extension
Message-ID: <10090000.1054049930@[10.10.2.4]>
In-Reply-To: <200305271154.52608.efocht@hpce.nec.com>
References: <200305271031.55554.efocht@hpce.nec.com> <20030527091104.GB31510@wotan.suse.de> <200305271154.52608.efocht@hpce.nec.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Interesting observation, I didn't make it when I tried the lazy
> homenode (quite a while ago). But I was focusing on MPI jobs. So what
> if we add a condition to CAN_MIGRATE which disables the cache affinity
> before the first load balance? 
> 
>> Migration directly on fork/clone requires a lot
>> of changes and also breaks down on some benchmarks.
> 
> Hmmm, I wouldn't allow this to any task/child, only to special
> ones. Under 2.4 I currently use a sched_balance_fork() function
> similar to  sched_balance_exec(). Tasks have a default initial load
> balancing policy of being migrated (and selecting the homenode) at
> exec(). This can be changed (with prctl) to fork(). The ilb policy is
> inheritable. Works fine for OpenMP jobs.

It'd be nice not to require user intervention here ... is it OK to
set CAN_MIGRATE for all clone operations?

M.

