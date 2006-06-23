Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750744AbWFWCHF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbWFWCHF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 22:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbWFWCHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 22:07:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28551 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750744AbWFWCHD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 22:07:03 -0400
Date: Thu, 22 Jun 2006 19:06:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: [patch 2/3] rtmutex: Propagate priority settings into PI lock
 chains
Message-Id: <20060622190657.08944024.akpm@osdl.org>
In-Reply-To: <20060622082812.607857000@cruncher.tec.linutronix.de>
References: <20060622082758.669511000@cruncher.tec.linutronix.de>
	<20060622082812.607857000@cruncher.tec.linutronix.de>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2006 09:08:39 -0000
Thomas Gleixner <tglx@linutronix.de> wrote:

> When the priority of a task, which is blocked on a lock, changes we must
> propagate this change into the PI lock chain. Therefor the chain walk
> code is changed to get rid of the references to current to avoid false
> positives in the deadlock detector, as setscheduler might be called by a 
> task which holds the lock on which the task whose priority is changed is
> blocked.
> Also add some comments about the get/put_task_struct usage to avoid
> confusion.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> 
>  include/linux/sched.h |    2 ++
>  kernel/rtmutex.c      |   41 ++++++++++++++++++++++++++++++++++++-----

That file's full of lockdep droppings from a different patchset.  Please
check the end result.

