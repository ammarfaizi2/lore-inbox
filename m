Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317182AbSFKQxE>; Tue, 11 Jun 2002 12:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317184AbSFKQxD>; Tue, 11 Jun 2002 12:53:03 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:7685 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317182AbSFKQxC>; Tue, 11 Jun 2002 12:53:02 -0400
Date: Tue, 11 Jun 2002 09:53:14 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: linux-kernel@vger.kernel.org, <frankeh@watson.ibm.com>,
        <alan@lxorguk.ukuu.org.uk>, <viro@math.psu.edu>
Subject: Re: [PATCH] Futex Asynchronous Interface 
In-Reply-To: <E17Hhke-0007rs-00@wagner.rustcorp.com.au>
Message-ID: <Pine.LNX.4.44.0206110951380.2712-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Rusty,
 this makes no sense:

D: This changes the implementation so that the waker actually unpins
D: the page.  This is preparation for the async interface, where the
D: process which registered interest is not in the kernel.

Whazzup? The closing of the fd will unpin the page, the waker has no
reason to do so. It is very much against the linux philosophy (and a
design disaster anyway) to have the waker muck with the data structures of
anything waiting.

		Linus

