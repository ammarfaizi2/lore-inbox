Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264951AbSJPH7u>; Wed, 16 Oct 2002 03:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264953AbSJPH7u>; Wed, 16 Oct 2002 03:59:50 -0400
Received: from mx2.elte.hu ([157.181.151.9]:48594 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S264951AbSJPH7u>;
	Wed, 16 Oct 2002 03:59:50 -0400
Date: Wed, 16 Oct 2002 10:17:10 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] futex-2.5.42-A2 
In-Reply-To: <20021016024951.490F42C0DE@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0210161015260.4683-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 16 Oct 2002, Rusty Russell wrote:

> If you do this, *please* add:
> 	/* Above check not sufficient if align of int < size.  Break link. */
> 	if (__alignof__(int) < sizeof(int)) {
> 		extern void __error_small_int_align();
> 		__error_small_int_align();
> 	}

are you aware of any platform we care about that has a word alignment like
this? But in any case, this should not matter these days, all we need is a
guarantee that the word is accessed atomically by the kernel when it reads
it, pure int alignment should be enough for that.

	Ingo


