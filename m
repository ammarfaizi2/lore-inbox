Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261427AbTAMDBe>; Sun, 12 Jan 2003 22:01:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261448AbTAMDBe>; Sun, 12 Jan 2003 22:01:34 -0500
Received: from dp.samba.org ([66.70.73.150]:56499 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261427AbTAMDBc>;
	Sun, 12 Jan 2003 22:01:32 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: joe.korty@ccur.com (Joe Korty)
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] some large create_module(2) sizes can oops a kernel 
In-reply-to: Your message of "Sat, 11 Jan 2003 21:41:36 CDT."
             <200301120241.CAA16791@rudolph.ccur.com> 
Date: Mon, 13 Jan 2003 13:34:43 +1100
Message-Id: <20030113031023.213EC2C06A@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <200301120241.CAA16791@rudolph.ccur.com> you write:
> Hi Rusty aka trivial patch monkey, everyone,
> 
> The 2.4 kernel will oops when create_module(2) is passed a size of
> -1, -2, or any size larger than num_physpages.  The following patch
> is one of the many simple ways to fix this.  Please consider it or
> some variant for inclusion in 2.4.

How about removing the BUG() from vmalloc.c, like 2.5 has done?

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
