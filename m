Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263544AbSJRJ1n>; Fri, 18 Oct 2002 05:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264210AbSJRJ1m>; Fri, 18 Oct 2002 05:27:42 -0400
Received: from dp.samba.org ([66.70.73.150]:10449 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S263544AbSJRJ1m>;
	Fri, 18 Oct 2002 05:27:42 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] futex-2.5.42-A2 
In-reply-to: Your message of "Wed, 16 Oct 2002 10:17:10 +0200."
             <Pine.LNX.4.44.0210161015260.4683-100000@localhost.localdomain> 
Date: Fri, 18 Oct 2002 18:39:34 +1000
Message-Id: <20021018093343.49A612C262@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0210161015260.4683-100000@localhost.localdomain> you 
write:
> 
> On Wed, 16 Oct 2002, Rusty Russell wrote:
> > If you do this, *please* add:
> > 	/* Above check not sufficient if align of int < size.  Break link. */
> 
> But in any case, this should not matter these days, all we need is a
> guarantee that the word is accessed atomically by the kernel when it reads
> it, pure int alignment should be enough for that.

Yes, this is true.  I used to not do get_user() on the value (the page
is pinned anyway), so it mattered.

Sorry for the confusion,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
