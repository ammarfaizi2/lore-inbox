Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267589AbSKQUh7>; Sun, 17 Nov 2002 15:37:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267592AbSKQUh7>; Sun, 17 Nov 2002 15:37:59 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:25578 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S267589AbSKQUh6>;
	Sun, 17 Nov 2002 15:37:58 -0500
Date: Sun, 17 Nov 2002 20:44:51 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Ingo Molnar <mingo@elte.hu>, Luca Barbieri <ldb@ldb.ods.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] threading fix, tid-2.5.47-A3
Message-ID: <20021117204451.GA2339@bjl1.asuk.net>
References: <Pine.LNX.4.44.0211172212001.18431-100000@localhost.localdomain> <3DD7FD86.7000407@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DD7FD86.7000407@redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Instead let the user initialize the memory location the clone call is
> supposed to write in with zero.  if the value didn't change the
> user-level code can detect the error and handle appropriately.

Does that work?  Zero is also read if the child was created, did
something, and exited with CLEARTID.

You can initialise it with -1, though.

-- Jamie
