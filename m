Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266053AbSLSTb3>; Thu, 19 Dec 2002 14:31:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266069AbSLSTb3>; Thu, 19 Dec 2002 14:31:29 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:39692 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266053AbSLSTb2>; Thu, 19 Dec 2002 14:31:28 -0500
Date: Thu, 19 Dec 2002 11:37:06 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: bart@etpmod.phys.tue.nl
cc: davej@codemonkey.org.uk, <lk@tantalophile.demon.co.uk>,
       <hpa@transmeta.com>, <terje.eggestad@scali.com>, <drepper@redhat.com>,
       <matti.aarnio@zmailer.org>, <hugh@veritas.com>, <mingo@elte.hu>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Intel P6 vs P7 system call performance
In-Reply-To: <20021219135517.7E78051FB6@gum12.etpnet.phys.tue.nl>
Message-ID: <Pine.LNX.4.44.0212191134180.2731-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 19 Dec 2002 bart@etpmod.phys.tue.nl wrote:
> 
> True, but unless I really don't get it, compatibility of a new static
> binary with an old kernel is going to break anyway. 

NO.

The current code in 2.5.x is perfectly able to be 100% compatible with 
binaries even on old kernels. This whole discussion is _totally_ 
pointless. I solved all the glibc problems early on, and Uli is already 
happy with the interfaces, and they work fine for old kernels that don't 
have a clue about the new system call interfaces.

WITHOUT any new magic system calls.

WITHOUT any stupid SIGSEGV tricks.

WITHOUT and silly mmap()'s on magic files.

> My point was that the double-mapped page trick adds no overhead in the
> case of a static binary, and just one extra mmap in case of a shared
> binary.

For _zero_ gain.  The jump to the library address has to be indirect 
anyway, and glibc has several places to put the information without any 
mmap's or anything like that.

		Linus

