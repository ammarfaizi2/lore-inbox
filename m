Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293109AbSCJRMG>; Sun, 10 Mar 2002 12:12:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293111AbSCJRL4>; Sun, 10 Mar 2002 12:11:56 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:41325 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S293109AbSCJRLo>; Sun, 10 Mar 2002 12:11:44 -0500
Date: Sat, 9 Mar 2002 22:07:51 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Dieter =?iso-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@elte.hu>, Robert Love <rml@tech9.net>,
        Oleg Drokin <green@namesys.com>
Subject: Re: 23 second kernel compile (aka which patches help scalibility on NUMA)
Message-ID: <20020309220751.C13379@dualathlon.random>
In-Reply-To: <200203092044.43456.Dieter.Nuetzel@hamburg.de> <135154151.1015676353@[10.10.2.3]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <135154151.1015676353@[10.10.2.3]>
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 09, 2002 at 12:19:13PM -0800, Martin J. Bligh wrote:
> some other stuff as well. The -aa tree also seems to be 
> incompatible (or rather, not trivially fixable) with the O(1)
> scheduler.

To apply the O(1) scheduler you only need to backout the dyn-sched and
numa-sched patches first (dyn-sched will be definitely obsoleted by the
O(1) scheduler, numa-sched should be changed like Mike described a few
weeks ago but probably O(1) will just work better than my current
numa-sched). There are no other changes to the scheduler, the
child-first is an optimization and parent-timeslice is an important
bugfix.

Andrea
