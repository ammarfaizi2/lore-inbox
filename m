Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129391AbQLSArU>; Mon, 18 Dec 2000 19:47:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129431AbQLSArK>; Mon, 18 Dec 2000 19:47:10 -0500
Received: from nrg.org ([216.101.165.106]:28992 "EHLO nrg.org")
	by vger.kernel.org with ESMTP id <S129391AbQLSArB>;
	Mon, 18 Dec 2000 19:47:01 -0500
Date: Mon, 18 Dec 2000 16:14:56 -0800 (PST)
From: Nigel Gamble <nigel@nrg.org>
Reply-To: nigel@nrg.org
To: Daniel Phillips <phillips@innominate.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Semaphores used for daemon wakeup
In-Reply-To: <0012171922570J.00623@gimli>
Message-ID: <Pine.LNX.4.05.10012181611430.2088-100000@cosmic.nrg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Dec 2000, Daniel Phillips wrote:
> This patch illustrates an alternative approach to waking and waiting on
> daemons using semaphores instead of direct operations on wait queues.
> The idea of using semaphores to regulate the cycling of a daemon was
> suggested to me by Arjan Vos.  The basic idea is simple: on each cycle
> a daemon down's a semaphore, and is reactivated when some other task
> up's the semaphore.

> Is this better, worse, or lateral?

This is much better, especially from a maintainability point of view.
It is also the method that a lot of operating systems already use.

Nigel Gamble                                    nigel@nrg.org
Mountain View, CA, USA.                         http://www.nrg.org/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
