Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267191AbSLaHtI>; Tue, 31 Dec 2002 02:49:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267188AbSLaHtH>; Tue, 31 Dec 2002 02:49:07 -0500
Received: from dp.samba.org ([66.70.73.150]:33933 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267191AbSLaHtG>;
	Tue, 31 Dec 2002 02:49:06 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Dave Jones <davej@codemonkey.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Overzealous permenant mark removed 
In-reply-to: Your message of "Mon, 30 Dec 2002 23:17:41 -0800."
             <Pine.LNX.4.44.0212302313370.2043-100000@home.transmeta.com> 
Date: Tue, 31 Dec 2002 18:56:49 +1100
Message-Id: <20021231075731.CE8A02C11D@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0212302313370.2043-100000@home.transmeta.com> you wri
te:
> And if somebody wants to create an un-unloadable driver, he should just 
> increment the module count and be done with it. No magic rules (maybe you 
> can make /proc/modules print out "<permanent>" if the count is over some 
> number, and then people who want permanent modules just initialize the 
> count past that).

OTOH, your approach left us with stuff that wasn't modular at all
(like IPv4) because people felt it was somehow "wrong" to make it
non-unloadable.

I guess it depends on numbers.  If we see lots of drivers which
initialize things and don't really need to clean up, you're right.

If we see far more "I didn't implement unloading" drivers, it's
easiest to do the safe thing: require the author DO SOMETHING to make
the module unloadable, not vice versa.

But the change is trivial,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
