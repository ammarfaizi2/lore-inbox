Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267636AbSKTHUN>; Wed, 20 Nov 2002 02:20:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267633AbSKTHUJ>; Wed, 20 Nov 2002 02:20:09 -0500
Received: from dp.samba.org ([66.70.73.150]:56019 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267636AbSKTHTt>;
	Wed, 20 Nov 2002 02:19:49 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: Re: kksymoops 
In-reply-to: Your message of "Mon, 18 Nov 2002 22:10:00 CDT."
             <3DD9AB88.4000102@pobox.com> 
Date: Wed, 20 Nov 2002 08:10:04 +1100
Message-Id: <20021120072654.15E932C079@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3DD9AB88.4000102@pobox.com> you write:
> I'm _not_ asking "when", just wondering what the plan is to resuscitate 
> kksymoops.

Looks like someone pushed my patch.  Erm, OK, wonder if it works on
x86? 8)

My mental TODO list looked something like this:
1) Drop the optimization which checks against addr between _stext and
   _etext, as this skips __init functions on most archs.
2) Only put in the symbols for functions (currently CONFIG_KALLSYMS=y
   adds 400k on my laptop: ouch!).
3) Keith asked me to rename it, so as not to get confused with the
   previous patches and kgdb support).  I guess it's too late for this
   one.
4) Use a simple scheme like the mini-oopser did to reduce the symbol
   table size furthur (I got it down to 70k IIRC).
5) See if Kai prefers the compile step inside the Makefile rather than
   in the script.
6) It'd be nice if CONFIG_KALLSYMS=m worked.

If someone wants to champion any or all of these, be my guest, there's
plenty to go around 8)

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
