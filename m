Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263590AbTETGJb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 02:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263591AbTETGJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 02:09:31 -0400
Received: from mx1.elte.hu ([157.181.1.137]:17298 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id S263590AbTETGJa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 02:09:30 -0400
Date: Tue, 20 May 2003 08:19:03 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: [patch] futex requeueing feature, futex-requeue-2.5.69-D3 
In-Reply-To: <20030520001623.715822C08B@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0305200817040.2342-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 20 May 2003, Rusty Russell wrote:

> 1) Overload the last futex arg (change from timeval * to void *),
>    don't add YA arg at the end.

the right approach is the splitup of the arguments, done in the later
cleanup patch. But i'd rather add yet another argument than some nasty
overload of arguments ...

> 2) Use __alignof__(u32) not sizeof(u32).  Sure, they're the same, but
>    you really mean __alignof__ here.

ok. Could they ever be realistically different?

	Ingo

