Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266718AbTAPDYs>; Wed, 15 Jan 2003 22:24:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266968AbTAPDYs>; Wed, 15 Jan 2003 22:24:48 -0500
Received: from dp.samba.org ([66.70.73.150]:1478 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266718AbTAPDYr>;
	Wed, 15 Jan 2003 22:24:47 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Werner Almesberger <wa@almesberger.net>
Cc: kuznet@ms2.inr.ac.ru, Roman Zippel <zippel@linux-m68k.org>,
       kronos@kronoz.cjb.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Migrating net/sched to new module interface 
In-reply-to: Your message of "Wed, 15 Jan 2003 23:42:58 -0300."
             <20030115234258.E1521@almesberger.net> 
Date: Thu, 16 Jan 2003 14:31:27 +1100
Message-Id: <20030116033343.C87CF2C33D@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030115234258.E1521@almesberger.net> you write:
> > And remember why we're doing it: for a fairly obscure race condition.
> 
> No, I want to do this to fix the reason for the fix for the
> obscure race condition :-)

Semantics.

> Also, all this smells of a fundamental design problem: modules
> aren't the only things that can become unavailable. So why
> construct a special mechanism that only applies to modules ?

NO NO NO.  Listen *carefully*.

The ONLY time that FUNCTIONS vanish is when MODULES get UNLOADED (or
fail to LOAD).

So you're suggesting we should lock ALL functions the way we lock all
other datastructures.  I look forward to your compiler patch.

I've explained this multiple times.  If you're not convinced, fine.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
