Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262824AbSLFRWq>; Fri, 6 Dec 2002 12:22:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264745AbSLFRWp>; Fri, 6 Dec 2002 12:22:45 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:63441 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262824AbSLFRWp>; Fri, 6 Dec 2002 12:22:45 -0500
Subject: Re: per cpu time statistics
From: Michael Hohnbaum <hohnbaum@us.ibm.com>
To: Erich Focht <efocht@ess.nec.de>
Cc: Andrew Morton <akpm@zip.com.au>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>
In-Reply-To: <200212041343.39734.efocht@ess.nec.de>
References: <200212041343.39734.efocht@ess.nec.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 06 Dec 2002 09:31:43 -0800
Message-Id: <1039195903.16948.85.camel@dyn9-47-17-164.beaverton.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-12-04 at 04:43, Erich Focht wrote:
> Andrew, Bill,
> 
> I had to learn from Michael Hohnbaum that you've eliminated the per
> CPU time statistics in 2.5.50 (akpm changeset from Nov. 26).
...
> 
> For those who miss this feature I'm attaching a patch doing what wli
> suggested. The config option is CONFIG_CPUS_STAT and can be found in
> the "Kernel Hacking" menu, as wli suggested. Just didn't like
> DEBUG_SCHED, we want to monitor the statistics and this is not
> necessarily related to bugs in the scheduler. Also added as last line
> in /proc/pid/cpu the current CPU of the task. It's often needed and
> /proc/pid/stat is much too cryptic.

I use a set of tests provided by Erich that use the cpu information from
the task.  This information is crucial for understanding how processes
are dispatched across CPUs (and nodes on NUMA boxes).  I've applied
Erich's patch and it restores this data, making his tests useful.  Could
this patch be considered for inclusion?  Please.

             Michael
> 
> Regards,
> 
> Erich
> ----

-- 

Michael Hohnbaum                      503-578-5486
hohnbaum@us.ibm.com                   T/L 775-5486

