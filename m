Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314101AbSESDeH>; Sat, 18 May 2002 23:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314106AbSESDeG>; Sat, 18 May 2002 23:34:06 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:45575 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S314101AbSESDeF>; Sat, 18 May 2002 23:34:05 -0400
Date: Sat, 18 May 2002 20:34:08 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: linux-kernel@vger.kernel.org, <alan@lxorguk.ukuu.org.uk>
Subject: Re: AUDIT: copy_from_user is a deathtrap. 
In-Reply-To: <E179HQd-0000j7-00@wagner.rustcorp.com.au>
Message-ID: <Pine.LNX.4.44.0205182030160.31341-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 19 May 2002, Rusty Russell wrote:
>
> Um, what about delivering a SIGSEGV?  So, copy_to/from_user always
> returns 0, but a signal is delivered.

That doesn't help. It's against some stupid SUS rule, I'm afraid.

(And THAT is a stupid rule, I 100% agree with. It means that some things
return -EFAULT, and other things do SIGSEGV, and the only difference is
whether something is a system call or is implemented as a library thing.
UNIX should always just have segfaulted, but there you are..)

		Linus

