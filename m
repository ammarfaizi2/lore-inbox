Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268431AbTBYXkW>; Tue, 25 Feb 2003 18:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268435AbTBYXkV>; Tue, 25 Feb 2003 18:40:21 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:519 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268431AbTBYXkV>; Tue, 25 Feb 2003 18:40:21 -0500
Date: Tue, 25 Feb 2003 15:47:59 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Richard Henderson <rth@twiddle.net>, <linux-kernel@vger.kernel.org>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: Re: [PATCH] eliminate warnings in generated module files 
In-Reply-To: <20030225234343.1109E2C05E@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0302251546590.2185-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 25 Feb 2003, Rusty Russell wrote:
> 
> __optional should always be __attribute__((__unused__)), and
> __required should be your __attribute_used__.

But I think rth's point was that "__module_depends" should definitely 
_not_ be "optional", since that just means that the compiler can (and 
will) optimize away the whole thing.

So marking it optional is definitely the wrong thing to do.

		Linus

