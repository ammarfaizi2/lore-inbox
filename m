Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030342AbWBVXQj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030342AbWBVXQj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 18:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030344AbWBVXQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 18:16:39 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:21684
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1030342AbWBVXQj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 18:16:39 -0500
Subject: Re: 2.6.15-rt17
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <Pine.LNX.4.44L0.0602221621110.13737-100000@lifa03.phys.au.dk>
References: <Pine.LNX.4.44L0.0602221621110.13737-100000@lifa03.phys.au.dk>
Content-Type: text/plain
Date: Thu, 23 Feb 2006 00:17:47 +0100
Message-Id: <1140650267.6396.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.5 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-02-22 at 17:50 +0100, Esben Nielsen wrote:
> I didn't know anyone looked at my patch! I am ofcourse happy about it :-)

Was just delayed due to other work in progress.

> That was why I had _reversed_ the lock ordering relative to normal in the
> original patch: First lock task->pi_lock. Assign lock. Lock
> lock->wait_lock. Then unlock task->pi_lock. Now it is safe to refer to
> lock. To avoid deadlocks I used _raw_spin_trylock() when locking the 2.
> lock.

Stupid me. I messed that one up. Should show up in the next -rt

Thanks

	tglx


