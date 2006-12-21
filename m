Return-Path: <linux-kernel-owner+w=401wt.eu-S965197AbWLUKVs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965197AbWLUKVs (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 05:21:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965195AbWLUKVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 05:21:48 -0500
Received: from aa014msr.fastwebnet.it ([85.18.95.74]:45732 "EHLO
	aa014msr.fastwebnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965197AbWLUKVs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 05:21:48 -0500
Date: Thu, 21 Dec 2006 11:20:00 +0100
From: Paolo Ornati <ornati@fastwebnet.it>
To: "Sorin Manolache" <sorinm@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: newbie questions about while (1) in kernel mode and spinlocks
Message-ID: <20061221112000.67722190@localhost>
In-Reply-To: <20170a030612210141y6578602eo525e6df5f324747d@mail.gmail.com>
References: <20170a030612210141y6578602eo525e6df5f324747d@mail.gmail.com>
X-Mailer: Sylpheed-Claws 2.4.0 (GTK+ 2.10.6; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Dec 2006 10:41:44 +0100
"Sorin Manolache" <sorinm@gmail.com> wrote:

> spin_lock(&lck);
> down(&sem); /* I know that one shouldn't sleep when holding a lock */
>                     /* but I want to understand why */

I suppose because the lock is held for an indefinite amount of time and
any other process that try to get that lock will "spin" and burn CPU
without doing anything useful (locking the process in kernel mode and
preventing the execution of other processes on that CPU if there
isn't any type of PREEMPTION).

:)

spin_lock is a "while(1) {...}" thing...

-- 
	Paolo Ornati
	Linux 2.6.20-rc1-g99f5e971 on x86_64
