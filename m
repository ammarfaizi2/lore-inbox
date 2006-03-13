Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751703AbWCMGn2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751703AbWCMGn2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 01:43:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751765AbWCMGn2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 01:43:28 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:27011
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751703AbWCMGn2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 01:43:28 -0500
Subject: Re: 2.6.16-rc6-rt1
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <6bffcb0e0603121536n61be10aaj@mail.gmail.com>
References: <20060312220218.GA3469@elte.hu>
	 <6bffcb0e0603121517s79f6a0e9i@mail.gmail.com>
	 <6bffcb0e0603121536n61be10aaj@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 13 Mar 2006 07:43:51 +0100
Message-Id: <1142232231.19916.555.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.5 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-03-13 at 00:36 +0100, Michal Piotrowski wrote:
> [snip]
> > WARNING: /lib/modules/2.6.16-rc6-rt1/kernel/drivers/parport/parport_pc.ko
> > needs unknown symbol rt_read_lock
> >

Index: linux-2.6.16-rc6/kernel/rt.c
===================================================================
--- linux-2.6.16-rc6.orig/kernel/rt.c
+++ linux-2.6.16-rc6/kernel/rt.c
@@ -191,6 +191,7 @@ void __lockfunc rt_read_lock(rwlock_t *r
 	_raw_spin_unlock_irqrestore(&rwsem->lock.wait_lock, flags);
 	rt_rw_lock(rwsem __RET_IP__);
 }
+EXPORT_SYMBOL(rt_read_lock);
 
 static inline void rt_rw_unlock(struct rw_semaphore *rwsem __IP_DECL__)
 {


