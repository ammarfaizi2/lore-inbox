Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965028AbVLaRYi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965028AbVLaRYi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 12:24:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965031AbVLaRYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 12:24:37 -0500
Received: from 213-140-2-73.ip.fastwebnet.it ([213.140.2.73]:14565 "EHLO
	aa006msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S965028AbVLaRYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 12:24:37 -0500
Date: Sat, 31 Dec 2005 18:24:40 +0100
From: Paolo Ornati <ornati@fastwebnet.it>
To: Mike Galbraith <efault@gmx.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Con Kolivas <kernel@kolivas.org>, Ingo Molnar <mingo@elte.hu>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: [SCHED] wrong priority calc - SIMPLE test case
Message-ID: <20051231182440.56863dd3@localhost>
In-Reply-To: <5.2.1.1.2.20051231162352.00bda610@pop.gmx.net>
References: <5.2.1.1.2.20051231090255.00bede00@pop.gmx.net>
	<200512281027.00252.kernel@kolivas.org>
	<20051227190918.65c2abac@localhost>
	<20051227224846.6edcff88@localhost>
	<200512281027.00252.kernel@kolivas.org>
	<5.2.1.1.2.20051231090255.00bede00@pop.gmx.net>
	<5.2.1.1.2.20051231162352.00bda610@pop.gmx.net>
X-Mailer: Sylpheed-Claws 2.0.0-rc1 (GTK+ 2.6.10; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 Dec 2005 17:37:11 +0100
Mike Galbraith <efault@gmx.de> wrote:

> >"./a.out 200 & ./a.out 333"
> >
> >   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
> >  5607 paolo     15   0  2396  320  252 R 56.1  0.1   0:06.79 a.out
> >  5606 paolo     15   0  2396  324  252 R 38.7  0.1   0:04.55 a.out
> >     1 root      16   0  2556  552  468 S  0.0  0.1   0:00.28 init
> 
> Strange.  Using the exact same arguments, I do see some odd bouncing up to 
> high priorities, but they spend the vast majority of their time down at 25.

You shouldn't use "the same exact numbers", you should try different
args and see if you can reproduce the problem. Or maybe preemption
make some difference... I'll try with PREEMPT enabled and see.

-- 
	Paolo Ornati
	Linux 2.6.15-rc7-plugsched on x86_64
