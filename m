Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131366AbQLQUkq>; Sun, 17 Dec 2000 15:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131455AbQLQUkg>; Sun, 17 Dec 2000 15:40:36 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:46092 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S131366AbQLQUk0>; Sun, 17 Dec 2000 15:40:26 -0500
Date: Sun, 17 Dec 2000 14:05:30 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>,
        Petr Vandrovec <vandrove@vc.cvut.cz>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test13-pre1 lockup: run_task_queue or tty_io are wrong
Message-ID: <20001217140530.A14173@vger.timpanogas.org>
In-Reply-To: <20001217192351.A18244@pcep-jamie.cern.ch> <Pine.LNX.4.10.10012171200310.25447-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.10.10012171200310.25447-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sun, Dec 17, 2000 at 12:02:31PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 17, 2000 at 12:02:31PM -0800, Linus Torvalds wrote:
> 
> 
> On Sun, 17 Dec 2000, Jamie Lokier wrote:
> > 
> > How about using a sentinel list entry representing the current position
> > in run_task_queue's loop?
> 
> Nope.
> 
> There may be multiple concurrent run_task_queue's executing, so for now
> I've applied Andrew Morton's patch that most closely gets the old
> behaviour of having a private list.
> 
> HOWEVER, this does need to be re-visited. The task-queue handling is
> potantially something that should be completely re-vamped in the future.
> 
> 		Linus


Linus,

Try thinking about the work to do model (since task queues are so similiar)
Having to "kick" these things should be automatic in the kernel.  I could
do a lot of cool stuff with this in there, manos aside.....

:-)

Jeff


> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
