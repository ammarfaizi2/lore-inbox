Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264975AbTANSvy>; Tue, 14 Jan 2003 13:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264983AbTANSvy>; Tue, 14 Jan 2003 13:51:54 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:63943 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S264975AbTANSvv>; Tue, 14 Jan 2003 13:51:51 -0500
Subject: Re: [PATCH 2.5.58] new NUMA scheduler: fix
From: Michael Hohnbaum <hohnbaum@us.ibm.com>
To: Erich Focht <efocht@ess.nec.de>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Andrew Theurer <habanero@us.ibm.com>,
       Christoph Hellwig <hch@infradead.org>, Robert Love <rml@tech9.net>,
       Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
In-Reply-To: <200301141743.25513.efocht@ess.nec.de>
References: <52570000.1042156448@flay>
	<200301141655.06660.efocht@ess.nec.de>
	<200301141723.29613.efocht@ess.nec.de> 
	<200301141743.25513.efocht@ess.nec.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 14 Jan 2003 11:02:34 -0800
Message-Id: <1042570956.27149.178.camel@dyn9-47-17-164.beaverton.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-01-14 at 08:43, Erich Focht wrote:
> Aargh, I should have gone home earlier...
> For those who really care about patch 05, it's attached. It's all
> untested as I don't have a ia32 NUMA machine running 2.5.58...

One more minor problem - the first two patches are missing the
following defines, and result in compile issues:

#define MAX_INTERNODE_LB 40
#define MIN_INTERNODE_LB 4
#define NODE_BALANCE_RATIO 10

Looking through previous patches, and the 05 patch, I found
these defines and put them under the #if CONFIG_NUMA in sched.c
that defines node_nr_running and friends.

With these three lines added, I have a kernel built and booted
using the first numa-sched and numa-sched-add patches.

Test results will follow later in the day.

             Michael


> 
> Erich
> 
> 
> On Tuesday 14 January 2003 17:23, Erich Focht wrote:
> > In the previous email the patch 02-initial-lb-2.5.58.patch had a bug
> > and this was present in the numa-sched-2.5.58.patch and
> > numa-sched-add-2.5.58.patch, too. Please use the patches attached to
> > this email! Sorry for the silly mistake...
> >
> > Christoph, I used your way of coding nr_running_inc/dec now.
> >
> > Regards,
> > Erich

-- 

Michael Hohnbaum                      503-578-5486
hohnbaum@us.ibm.com                   T/L 775-5486

