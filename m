Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129098AbQKEEwe>; Sat, 4 Nov 2000 23:52:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129109AbQKEEwY>; Sat, 4 Nov 2000 23:52:24 -0500
Received: from twinlark.arctic.org ([204.107.140.52]:60427 "HELO
	twinlark.arctic.org") by vger.kernel.org with SMTP
	id <S129098AbQKEEwU>; Sat, 4 Nov 2000 23:52:20 -0500
Date: Sat, 4 Nov 2000 20:52:19 -0800 (PST)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Andrew Morton <andrewm@uow.edu.au>, kumon@flab.fujitsu.co.jp,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: Negative scalability by removal of  lock_kernel()?(Was:Strange
In-Reply-To: <E13sAAB-0004nz-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0011042041500.22526-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Nov 2000, Alan Cox wrote:

> > sysv semaphores have a very unfortunate negative feature -- if the admin
> > kill -9's the server (impatient admins do this all the time) then you end
> > up leaving a semaphore lying around.  sysvsem don't have the usual unix
> 
> Umm they have SEM_UNDO. Its a case of deeper magic

we use SEM_UNDO, that's not quite what i was worrying about.  i was
worrying about leaving a stale semaphore in the global semaphore table.

IPC_RMID causes the semaphore to be destroyed immediately, rather than
after all the users are done.

-dean

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
