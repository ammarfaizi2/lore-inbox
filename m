Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130288AbRBZOel>; Mon, 26 Feb 2001 09:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130236AbRBZObp>; Mon, 26 Feb 2001 09:31:45 -0500
Received: from zeus.kernel.org ([209.10.41.242]:53191 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130289AbRBZO3y>;
	Mon, 26 Feb 2001 09:29:54 -0500
Message-Id: <m14XJot-000ObCC@amadeus.home.nl>
Date: Mon, 26 Feb 2001 10:19:51 +0100 (CET)
From: arjan@fenrus.demon.nl (Arjan van de Ven)
To: twaugh@redhat.com (Tim Waugh)
Subject: Re: timing out on a semaphore
cc: linux-kernel@vger.kernel.org
X-Newsgroups: fenrus.linux.kernel
In-Reply-To: <20010225224039.W13721@redhat.com>
User-Agent: tin/pre-1.4-981002 ("Phobia") (UNIX) (Linux/2.2.18pre19 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010225224039.W13721@redhat.com> you wrote:

> --2F7AbV2suvT8PGoH
> Content-Type: text/plain; charset=us-ascii
> Content-Disposition: inline

> I'm trying to chase down a semaphore time-out problem.  I want to
> sleep on a semaphore until either

> (a) it's signalled, or
> (b) some amount of time has elapsed.

> What I'm doing is calling add_timer, and then down_interruptible, and
> finally del_timer.  The timer's function ups the semaphore.


What we _really_ need is down_timeout(), which I plan to implement for early
2.5. The semantics should by similar to the try_lock functions, exect that
it will try for a specified amount of time first.

Greetings,
   Arjan van de Ven
