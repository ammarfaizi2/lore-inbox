Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319019AbSIJEwE>; Tue, 10 Sep 2002 00:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319033AbSIJEwE>; Tue, 10 Sep 2002 00:52:04 -0400
Received: from dp.samba.org ([66.70.73.150]:49645 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S319019AbSIJEwE>;
	Tue, 10 Sep 2002 00:52:04 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Matthew Wilcox <willy@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Important per-cpu fix. 
In-reply-to: Your message of "Mon, 09 Sep 2002 13:17:44 +0100."
             <20020909131744.G10583@parcelfarce.linux.theplanet.co.uk> 
Date: Tue, 10 Sep 2002 09:24:56 +1000
Message-Id: <20020910045650.206202C2C4@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020909131744.G10583@parcelfarce.linux.theplanet.co.uk> you write:
> Rusty wrote:
> > Yeah, but you can still leave a spinlock uninitialized, and it'll
> > work.
> 
> If your architecture has load-and-zero as its only atomic primitive,
> leaving spinlocks uninitialised will _not_ work ;-)

<sigh>

Context: static initializers. ie. you can use dynamic initialization
on your spinlocks.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
