Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317112AbSGHUd1>; Mon, 8 Jul 2002 16:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317114AbSGHUd0>; Mon, 8 Jul 2002 16:33:26 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:65039 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S317112AbSGHUdZ>;
	Mon, 8 Jul 2002 16:33:25 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200207082034.g68KYOM263957@saturn.cs.uml.edu>
Subject: Re: Diff b/w 32bit & 64-bit
To: lk@tantalophile.demon.co.uk (Jamie Lokier)
Date: Mon, 8 Jul 2002 16:34:24 -0400 (EDT)
Cc: thunder@ngforever.de (Thunder from the hill),
       acahalan@cs.uml.edu (Albert D. Cahalan),
       mru@users.sourceforge.net (M?ns Rullg?rd),
       MohamedG@ggn.hcltech.com (Mohamed Ghouse Gurgaon),
       linux-kernel@vger.kernel.org ('linux-kernel@vger.kernel.org')
In-Reply-To: <20020707222425.A12535@kushida.apsleyroad.org> from "Jamie Lokier" at Jul 07, 2002 10:24:25 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier writes:

>>>> don't cast from "foo *" to "bar *" if sizeof(foo)<sizeof(bar)
...
> Oliver Neukum explained that you shouldn't dereference a pointer to a
> larger type because of alignment issues on some machines.
> sizeof(foo)<sizeof(bar) captures this rule just fine for the basic data
> types (char, int etc.).

Yes, that was the intent.

> But for structures, it's actually possible to have a smaller type with a
> larger alignment requirement, and vice versa:
>
>      struct small { double x; };
>      struct large { char y [11]; };
>
> Also, it is certainly permitted to cast "char *" to "int *" if you know
> that the underlying object is an "int" or something compatible with one.
>
> So, the general rule `don't cast from "foo *" to "bar *" if
> sizeof(foo)<sizeof(bar)' is wrong, and is routinely not followed.
>
> An alternative rule might be `never dereference a "bar *" if it might
> not have the correct alignment for "bar" on any platform'.

Got a shorter way to say that? In less than one line, give
a rule that will keep x86-centric programmers from getting
hurt by the alignment restrictions.

