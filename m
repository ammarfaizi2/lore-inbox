Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265111AbTLWLwG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 06:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265112AbTLWLwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 06:52:06 -0500
Received: from stat0143.cruzio.com ([63.249.101.143]:50701 "EHLO O.Q.NET")
	by vger.kernel.org with ESMTP id S265111AbTLWLwC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 06:52:02 -0500
RECEIVED: FROM ulmo BY O.Q.NET WITH local (Exim 4.22 #1 (Debian))
	ID 1AYl4w-0007A5-R3; Tue, 23 Dec 2003 03:51:58 -0800
To: linux-kernel@vger.kernel.org
Subject: Re:  DevFS vs. udev
Cc: ulmo@q.net
Message-Id: <E1AYl4w-0007A5-R3@O.Q.NET>
From: "Bradley W. Allen" <ULMO@Q.NET>
Date: Tue, 23 Dec 2003 03:51:58 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DevFS was written by an articulate person who solved a lot of
problems.  udev sounds more like a thug who's smug about winning,
not explaining himself, saying things like "oh, the other guy
disappeared, so who cares, you have to use my code, too bad it sucks".

Just by what the udev people have said I have decided never to use it,
and to return to DevFS.  Thank god for linux-kernel archives.

A few points:

*  User space is slow, causing all sorts of extra work for device
   accesses.
*  Another layer of filesystem for udev to have to interact with
   is also slow, especially if it has to be disk based with all sorts
   of extra caches, and also if it's with buggy tmpfs code and layers.
*  Most of the interesting devices I have now are character devices,
   and have multiple potential /dev entries per device.  I've heard
   that udev can't even handle that requirement!
   Udev has lots of other problems, like something called an anonymous
   device, and it not being fully implemented, however, that's OK for
   development.  We're in 2.6.0, now, so that's not OK!  DevFS has been
   solid for over half a decade, so it belongs in stable kernels.
*  Many times a broken record comes out with claims.  Here are a few:
   "... there are still unfixable devfs bugs in the code." without
   any examples, so I don't believe him (Greg K-H).  Others have looked
   and not found that.
*  Userspace is not the proper place for kernel device drivers or
   anything they need to work.
*  We do not need the same old maintainer for devfs.  We can create
   new code, and maintain old code, as a group, ourselves.
*  Greg K-H (what that dash is for I can't imagine) claims that DevFS
   is experimental and proof of concept; well, it has been in production
   use for over half a decade, which in the life of Linux is pretty long.
   It's certainly not just some experiment any more.
*  Greg K-H refers to "hahahaha" and "the OLS paper" and "sysfs",
   things that most Linux kernel compilers, linux-kernel readers, and
   DevFS users (including lots of admins) have probably never ever
   heard of except the bad attitude of the hahaha part.
*  Someone named viro said "the latter had stayed, period" refering to
   udev, which means absolutely nothing, but expected it to mean
   something.
*  Viro also said that devfs had been "shoved" into the tree, and
   that it "had stayed around for many months".  It's been stable for
   many *YEARS*, for most of a *DECADE*.

I've spent two hours on this problem, and that's absurd; stable shouldn't
be doing this sort of thing to us.  Yes, we know there are things that
happen during transition from development to stable, but to have some
terrorist hijack part of the kernel and destroy it right at the begin-
ing of stable is simply criminal thinking.  Luckily, this is just
software, so we can do what we want with it, but organizationally it
is conceptually just as bad.
