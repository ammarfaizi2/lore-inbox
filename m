Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318176AbSGQBTV>; Tue, 16 Jul 2002 21:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318177AbSGQBTV>; Tue, 16 Jul 2002 21:19:21 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:31501 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318176AbSGQBTU>; Tue, 16 Jul 2002 21:19:20 -0400
Date: Tue, 16 Jul 2002 18:23:18 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "David S. Miller" <davem@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: close return value
In-Reply-To: <20020716.180521.57640174.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0207161817560.4794-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 16 Jul 2002, David S. Miller wrote:
>
>    Oh, Linus knows.  In fact, Linus wrote some of the code in question.
>
> Ok, I think the issue here is different.
>
> Several years ago we were returning -EAGAIN from close() via NFS and
> that is what caused the problems.

Oh.

Yes, EAGAIN doesn't really work as a close return value, simply because
_nobody_ expects that (and leaving the file descriptor open after a
close() is definitely unexpected, ie people can very validly complain
about buggy behaviour).

		Linus

