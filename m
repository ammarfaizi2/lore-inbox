Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318128AbSIET5m>; Thu, 5 Sep 2002 15:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318132AbSIET5m>; Thu, 5 Sep 2002 15:57:42 -0400
Received: from mx2.elte.hu ([157.181.151.9]:28811 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S318128AbSIET5l>;
	Thu, 5 Sep 2002 15:57:41 -0400
Date: Thu, 5 Sep 2002 22:06:36 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Daniel Jacobowitz <dan@debian.org>
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] ptrace-fix-2.5.33-A1
In-Reply-To: <20020905183609.GA26898@nevyn.them.org>
Message-ID: <Pine.LNX.4.44.0209052205090.19199-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 5 Sep 2002, Daniel Jacobowitz wrote:

> You're right, we just need to clear p->ptrace.  And there was a problem
> with debugged detached tasks.  Ingo, does this look right to you?  It
> passes my testing.  Handle unlinking in release_task instead of at both
> call sites, since they both need it.

your patch works for me - in fact it works better than the one i sent. I
had another (largely unrelated) patch which i suspected to cause hung
unkillable zombies while stracing an application - it turned out that your
patch fixes this artifact as well.

(Linus, please apply Daniel's patch, not mine.)

	Ingo

