Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261515AbSJJNdo>; Thu, 10 Oct 2002 09:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261538AbSJJNdo>; Thu, 10 Oct 2002 09:33:44 -0400
Received: from denise.shiny.it ([194.20.232.1]:12432 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id <S261515AbSJJNdn>;
	Thu, 10 Oct 2002 09:33:43 -0400
Message-ID: <XFMail.20021010153919.pochini@shiny.it>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <1034221067.794.505.camel@phantasy>
Date: Thu, 10 Oct 2002 15:39:19 +0200 (CEST)
From: Giuliano Pochini <pochini@shiny.it>
To: Robert Love <rml@tech9.net>
Subject: Re: [PATCH] O_STREAMING - flag for optimal streaming I/O
Cc: linux-kernel@vger.kernel.org, Mark Mielke <mark@mark.mielke.cc>,
       Jamie Lokier <lk@tantalophile.demon.co.uk>, andersen@codepoet.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Look, the pagecache is already smart.  New stuff will replace unusued
> old stuff.  On VM pressure, the pagecache will be pruned.  Streaming I/O
> is a fundamentally different problem in that the data is so large it
> _continually_ thrashes the pagecache.  Such I/O is sequential and
> use-once.  You end up with a permanent waste of memory (the cached
> I/O).

When a process opens a file with O_STREAMING, it tells the kernel
it will use the data only once, but it tells nothing about other
tasks. If that process reads something which is already cached,
then it must not drop it because someone other used it recently
and IMHO pagecache only should be allowed to drop it.

> Let's prove we have a solution to this problem before going after
> tangent ones.

If "solution" means "code", sorry, I can't help :(


Bye.

