Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319482AbSH3IOU>; Fri, 30 Aug 2002 04:14:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319484AbSH3IOU>; Fri, 30 Aug 2002 04:14:20 -0400
Received: from mx2.elte.hu ([157.181.151.9]:15781 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S319482AbSH3IOT>;
	Fri, 30 Aug 2002 04:14:19 -0400
Date: Fri, 30 Aug 2002 10:22:07 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@zip.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] scheduler fixes, 2.5.32-BK
In-Reply-To: <3D6F28F6.71228222@zip.com.au>
Message-ID: <Pine.LNX.4.44.0208301005050.8945-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 30 Aug 2002, Andrew Morton wrote:

> yep, looks like the killing of the semaphore_lock made the race go away.
> 
> But ia64, sparc and x86_64 use semaphore_lock, so they still are
> exposed.

btw., this way completions become special-case semaphores optimized for
the context-switching path, not a correctness issue. At which point it's
also an interesting question whether in fact we need to make completion()  
that much of a different interface?

	Ingo

