Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318272AbSHPJrL>; Fri, 16 Aug 2002 05:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318277AbSHPJrL>; Fri, 16 Aug 2002 05:47:11 -0400
Received: from mx1.elte.hu ([157.181.1.137]:45507 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S318272AbSHPJrI>;
	Fri, 16 Aug 2002 05:47:08 -0400
Date: Fri, 16 Aug 2002 11:51:37 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] user-vm-unlock-2.5.31-A2
In-Reply-To: <Pine.LNX.4.44.0208151809190.1188-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0208161150060.3062-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 15 Aug 2002, Linus Torvalds wrote:

> The child (Y) it forks off, however, may use thread (Z) for some
> subtask.  Not pthreads, it might be just a clone-by-hand.  So it may be
> doing an exit while it's address space is still actively used by another
> thread - but just because (X) wanted to use CLONE_SETTID to get the
> child information on (Y) does _not_ mean that it's address space (and
> thus that of Z) would somehow be updated at its exit.

yes, now i understand. When using raw clone() then indeed a CLEARTID set
up in X's context does not necesserily have any meaning in Y's (and Z's)
context.

	Ingo

