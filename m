Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314454AbSEMA7Q>; Sun, 12 May 2002 20:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315170AbSEMA7P>; Sun, 12 May 2002 20:59:15 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:25360 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S314454AbSEMA7P>; Sun, 12 May 2002 20:59:15 -0400
Date: Sun, 12 May 2002 17:59:27 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Rose, Billy" <wrose@loislaw.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Segfault hidden in list.h
In-Reply-To: <4188788C3E1BD411AA60009027E92DFD0962E24F@loisexc2.loislaw.com>
Message-ID: <Pine.LNX.4.44.0205121750530.15392-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 12 May 2002, Rose, Billy wrote:
>
> If something is accessing the list in reverse at the time of insertion and
> "next->prev = new;" has been executed, there exists a moment when new->prev

No.

If the coder doesn't lock his data structures, it doesn't matter _what_
order we execute the list modifications in - different architectures will
do different thing with inter-CPU memory ordering, and trying to order
memory accesses on a source level is futile.

		Linus

