Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318075AbSHKTBp>; Sun, 11 Aug 2002 15:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318121AbSHKTBp>; Sun, 11 Aug 2002 15:01:45 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:9231 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318075AbSHKTBp>; Sun, 11 Aug 2002 15:01:45 -0400
Date: Sun, 11 Aug 2002 12:06:57 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <akpm@zip.com.au>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 4/21] fix ARCH_HAS_PREFETCH
In-Reply-To: <3D56B13A.D3F741D1@zip.com.au>
Message-ID: <Pine.LNX.4.44.0208111203520.9930-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 11 Aug 2002, Andrew Morton wrote:
> 
> It's actually a special-case inside the compiler to not optimise
> away such constructs.

I thought that special case was removed long ago, because it is untenable 
in C++ etc (where such empty loops happen due to various abstraction 
issues, and not optimizing them away is just silly).

But testing shows that you're right at least for 2.95 and 2.96. Argh

		Linus

