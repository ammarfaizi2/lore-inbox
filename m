Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292611AbSBUBmD>; Wed, 20 Feb 2002 20:42:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292607AbSBUBlx>; Wed, 20 Feb 2002 20:41:53 -0500
Received: from rcpt-expgw.biglobe.ne.jp ([210.147.6.213]:14563 "EHLO
	rcpt-expgw.biglobe.ne.jp") by vger.kernel.org with ESMTP
	id <S292306AbSBUBll>; Wed, 20 Feb 2002 20:41:41 -0500
X-Biglobe-Sender: <k-suganuma@mvj.biglobe.ne.jp>
Date: Wed, 20 Feb 2002 17:40:56 -0800
From: Kimio Suganuma <k-suganuma@mvj.biglobe.ne.jp>
To: Paul Jackson <pj@engr.sgi.com>
Subject: Re: [Lse-tech] Re: [PATCH] O(1) scheduler set_cpus_allowed for non-current tasks
Cc: Erich Focht <focht@ess.nec.de>, Robert Love <rml@tech9.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@elte.hu>, Matthew Dobson <colpatch@us.ibm.com>,
        lse-tech@lists.sourceforge.net
In-Reply-To: <Pine.SGI.4.21.0202201619560.565754-100000@sam.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.21.0202202337320.10032-100000@sx6.ess.nec.de> <Pine.SGI.4.21.0202201619560.565754-100000@sam.engr.sgi.com>
Message-Id: <20020220173242.2BDF.K-SUGANUMA@mvj.biglobe.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.00.05
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Wed, 20 Feb 2002 17:12:21 -0800
Paul Jackson <pj@engr.sgi.com> wrote:

> > Another problem is the right moment to change the cpu field of the
> > task. ... The IPI to the target CPU is the same as in the
> > initial design of Ingo. It has to wait for the task to unschedule and
> > knows it will find it dequeued.
> 
> How about not changing anything of the target task synchronously,
> except for some new "proposed_cpus_allowed" field.  Set that
> field and get out of there.  Let the target process run the
> set_cpus_allowed() routine on itself, next time it passes through
> the schedule() code.  Leave it the case that the set_cpus_allowed()
> routine can only be run on the current process.
> 
> Perhaps others need this cpus_allowed change (and the migration
> of a task to a different allowed cpu) to happen "right away".
> But I don't, and I don't (yet) know that anyone else does.

CPU hotplug needs to change cpus_allowed in definite time.
When a process is sleeping for 100000 seconds, how can we offline
a CPU the process belongs?

Regards,
Kimi

-- 
Kimio Suganuma <k-suganuma@mvj.biglobe.ne.jp>

