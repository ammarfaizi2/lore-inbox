Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315630AbSGXAsy>; Tue, 23 Jul 2002 20:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315634AbSGXAsy>; Tue, 23 Jul 2002 20:48:54 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:59834 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S315630AbSGXAsx>;
	Tue, 23 Jul 2002 20:48:53 -0400
Date: Wed, 24 Jul 2002 02:51:58 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200207240051.CAA16434@harpo.it.uu.se>
To: kevin@koconnor.net, neilb@cse.unsw.edu.au
Subject: Re: PATCH: type safe(r) list_entry repacement: generic_out_cast
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jul 2002 18:58:52 -0400, Kevin O'Connor wrote:
>#define BackPtr(ptr, type, member) ({                                         \
>        typeof( ((type *)0)->member ) *__mptr = (ptr);                        \
>        ((type *)( (char *)__mptr - (unsigned long)(&((type *)0)->member) ));})

I've seen this sort of code several times now in the Linux kernel,
and I've never liked it. Is there some reason why you guys avoid
offsetof() like the plague?

/Mikael
