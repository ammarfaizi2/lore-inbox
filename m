Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289250AbSA1RLD>; Mon, 28 Jan 2002 12:11:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289260AbSA1RKy>; Mon, 28 Jan 2002 12:10:54 -0500
Received: from tux.rsn.bth.se ([194.47.143.135]:48514 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id <S289250AbSA1RKk>;
	Mon, 28 Jan 2002 12:10:40 -0500
Date: Mon, 28 Jan 2002 18:10:16 +0100 (CET)
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Ingo Molnar <mingo@elte.hu>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] [sched] yield speedup, 2.5.3-pre5
In-Reply-To: <Pine.LNX.4.33.0201281751130.9992-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.21.0201281807530.4731-100000@tux.rsn.bth.se>
X-message-flag: Get yourself a real mail client! http://www.washington.edu/pine/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jan 2002, Ingo Molnar wrote:

Hi Ingo,

I'm not an spinlock expert but shouldn't you use spin_unlock_irq() when it
was locked with spin_lock_irq() ?

        spin_lock_irq(&rq->lock);

> -	spin_unlock_irq(&rq->lock);
> +	spin_unlock(&rq->lock);

/Martin

Never argue with an idiot. They drag you down to their level, then beat you with experience.


