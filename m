Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265865AbTBCCSk>; Sun, 2 Feb 2003 21:18:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265857AbTBCCRm>; Sun, 2 Feb 2003 21:17:42 -0500
Received: from dp.samba.org ([66.70.73.150]:8166 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265854AbTBCCRi>;
	Sun, 2 Feb 2003 21:17:38 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Paul Marinceu <elixxir@ucc.gu.uwa.edu.au>
Cc: linux-kernel@vger.kernel.org,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: Re: [RFC][PATCH] new modversions implementation 
In-reply-to: Your message of "Sun, 02 Feb 2003 16:37:52 +0800."
             <Pine.LNX.4.21.0302021616230.11976-100000@mussel> 
Date: Mon, 03 Feb 2003 11:46:18 +1100
Message-Id: <20030203022709.99BAC2C256@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.21.0302021616230.11976-100000@mussel> you write:
> +#ifdef CONFIG_MODVERSIONING
> +       if ((mod->symbols.num_syms && !crcindex)
> +           || (mod->gpl_symbols.num_syms && !gplcrcindex)) {

Thanks Paul!  Good catch.

Kai is currently the one beating this patch into shape: he's the
Makefile guru, I just twiddle with modules.  I'm waiting for him and
Andrew Morton to merge with Linus to see what's left to apply.

> Also, whatever happened to modversions.h? A module I have refuses to
> compile without it. I'm not yet such a good hacker to figure out how your
> new modversions implementation works 8) 

You shouldn't need modversions.h any more: you can simply excise it.
This means that such a module will taint a modversioned kernel,
though.

The correct (and future-proof) way to build external modules is to use
the kernel makefiles themselves:

http://hypermail.idiosynkrasia.net/linux-kernel/archived/2002/week23/0162.html

Hope that helps!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
