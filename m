Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266686AbRGKNiK>; Wed, 11 Jul 2001 09:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266687AbRGKNhu>; Wed, 11 Jul 2001 09:37:50 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:5528 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S266686AbRGKNhr>; Wed, 11 Jul 2001 09:37:47 -0400
Message-ID: <3B4C56F1.3085D698@uow.edu.au>
Date: Wed, 11 Jul 2001 23:38:57 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: Klaus Dittrich <kladit@t-online.de>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.7p6 hang
In-Reply-To: <200107110849.f6B8nlm00414@df1tlpc.local.here>,
		kladit@t-online.de's message of "Wed, 11 Jul 2001 10:49:47 +0200 (METDST)" <shslmlv62us.fsf@charged.uio.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
> 
> ...
> I have the same problem on my setup. To me, it looks like the loop in
> spawn_ksoftirqd() is suffering from some sort of atomicity problem.

Does a `set_current_state(TASK_RUNNING);' in spawn_ksoftirqd()
fix it?  If so we have a rogue initcall...

-
