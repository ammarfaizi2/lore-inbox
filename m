Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932530AbWIVOWa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932530AbWIVOWa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 10:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932529AbWIVOWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 10:22:30 -0400
Received: from [212.33.163.198] ([212.33.163.198]:35712 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S932530AbWIVOW1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 10:22:27 -0400
From: Al Boldi <a1426z@gawab.com>
To: linux-kernel@vger.kernel.org
Subject: Poor scheduling when not loaded at 100% (Was: [PATCH] sched.c: Be a bit more conservative in SMP)
Date: Fri, 22 Sep 2006 17:24:17 +0300
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609221724.17107.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ludovic Drolez wrote:
> Ludovic Drolez <ldrolez <at> linbox.com> writes:
> > In fact, I tested the 1st patch on our cluster (Finite elements
> > computing on 8 CPUs):
> > - Under Windows: 875 seconds
> > - Linux 2.6.16 : 1019 s
> > - Linux 2.6.16 + manual taskset : 842 s
> > - Linux 2.6.16 + Vincent's patch : 1373 s
>
> Anyone has an idea why the scheduling is poor when processes don't use all
> CPU ?
>
> In the above example, we have 4 processes on 4 processors which use about
> 40% of the CPU (computing and waiting for network packets).
> 1- If taskset is not used : CPU0 is used at 80%, and the 3 others at 30%.
> The tasks are constantly migrated between cores -> poor performance
> (1019s), Windows does better :-(
> 2- If taskset is used : All CPUs have 1 process and are used at 40%. No
> migration -> high performance (842s), better than Windows :-)
>
> I tried to play with the 'migration_cost' kernel parameter but it did not
> help. By default, on the Bi-Xeon Dual Core MB (Dell 1855),
> migration_cost=1600, and trying values up to 200000, did not improve
> performance...
>
> Any Ideas ?

Did you try PlugSched?  The spa scheds work wonders, once tuned properly.


Thanks!


--
Al

