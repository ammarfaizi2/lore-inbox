Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263566AbTIHUR3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 16:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263562AbTIHUR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 16:17:29 -0400
Received: from fw.osdl.org ([65.172.181.6]:25823 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263566AbTIHURY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 16:17:24 -0400
Date: Mon, 8 Sep 2003 12:59:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jamie Lokier <jamie@shareable.org>
Cc: rusty@rustcorp.com.au, hugh@veritas.com, drepper@redhat.com,
       lk@tantalophile.demon.co.uk, shemminger@osdl.org,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: today's futex changes
Message-Id: <20030908125932.777f2585.akpm@osdl.org>
In-Reply-To: <20030908200741.GH27097@mail.jlokier.co.uk>
References: <Pine.LNX.4.44.0309061723160.1470-100000@localhost.localdomain>
	<20030908102309.0AC4E2C013@lists.samba.org>
	<20030908120234.5d05cda9.akpm@osdl.org>
	<20030908200741.GH27097@mail.jlokier.co.uk>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier <jamie@shareable.org> wrote:
>
> Andrew Morton wrote:
> > Rusty Russell <rusty@rustcorp.com.au> wrote:
> > > D: 4) Andrew Morton says spurious wakeup is a bug.  Catch it.
> > 
> > Yes, but going BUG() is a bit rude.  We can detect the error, we can
> > recover from it and it doesn't cause any user data corruption or anything.
> > A rude printk is all that is needed here.
> 
> Well, it should really _never_ happen.  We are very careful.  Is
> there something like BUG() which doesn't terminate the process?
> 

A WARN_ON(1) is good enough.  It will spit a stack dump and we will get to
hear about it.  Going BUG merely reduces the chances of the info hitting
the logs and irritates our testers.


