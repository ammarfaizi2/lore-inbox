Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131233AbQLQUdr>; Sun, 17 Dec 2000 15:33:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131366AbQLQUdh>; Sun, 17 Dec 2000 15:33:37 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:61709 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131233AbQLQUdU>; Sun, 17 Dec 2000 15:33:20 -0500
Date: Sun, 17 Dec 2000 12:02:31 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: Petr Vandrovec <vandrove@vc.cvut.cz>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test13-pre1 lockup: run_task_queue or tty_io are wrong
In-Reply-To: <20001217192351.A18244@pcep-jamie.cern.ch>
Message-ID: <Pine.LNX.4.10.10012171200310.25447-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 17 Dec 2000, Jamie Lokier wrote:
> 
> How about using a sentinel list entry representing the current position
> in run_task_queue's loop?

Nope.

There may be multiple concurrent run_task_queue's executing, so for now
I've applied Andrew Morton's patch that most closely gets the old
behaviour of having a private list.

HOWEVER, this does need to be re-visited. The task-queue handling is
potantially something that should be completely re-vamped in the future.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
