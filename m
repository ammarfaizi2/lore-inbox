Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289281AbSA1R2y>; Mon, 28 Jan 2002 12:28:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289290AbSA1R2h>; Mon, 28 Jan 2002 12:28:37 -0500
Received: from tux.rsn.bth.se ([194.47.143.135]:56706 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id <S289281AbSA1R2Z>;
	Mon, 28 Jan 2002 12:28:25 -0500
Date: Mon, 28 Jan 2002 18:28:17 +0100 (CET)
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] [sched] yield speedup, 2.5.3-pre5
In-Reply-To: <Pine.LNX.4.33.0201282020440.13846-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.21.0201281827380.4882-100000@tux.rsn.bth.se>
X-message-flag: Get yourself a real mail client! http://www.washington.edu/pine/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jan 2002, Ingo Molnar wrote:

> > I'm not an spinlock expert but shouldn't you use spin_unlock_irq()
> > when it was locked with spin_lock_irq() ?
> 
> normally yes, but in this case it's an optimization: schedule() will
> disable interrupts within a few cycles, so there is no point in enabling
> irqs for a short amount of time.

Thanks for the explanation.

/Martin

Never argue with an idiot. They drag you down to their level, then beat you with experience.

