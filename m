Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933220AbWFXIHz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933220AbWFXIHz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 04:07:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933222AbWFXIHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 04:07:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50824 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S933220AbWFXIHy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 04:07:54 -0400
Date: Sat, 24 Jun 2006 01:07:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: [patch 1/3] Drop tasklist lock in do_sched_setscheduler
Message-Id: <20060624010741.6faf355d.akpm@osdl.org>
In-Reply-To: <20060622082812.492564000@cruncher.tec.linutronix.de>
References: <20060622082758.669511000@cruncher.tec.linutronix.de>
	<20060622082812.492564000@cruncher.tec.linutronix.de>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2006 09:08:38 -0000
Thomas Gleixner <tglx@linutronix.de> wrote:

> 
> There is no need to hold tasklist_lock across the setscheduler call, when we
> pin the task structure with get_task_struct(). Interrupts are disabled in 
> setscheduler anyway and the permission checks do not need interrupts disabled.
> 

These three patches had intricate dependencies upon the __IP__ and
__IP_DECL__ gunk which later patches removed, so these patches do not
compile against the pi-futex patches.

So I dropped these.

And I'll drop the lockdep patches, so you'll be able to redo these.
