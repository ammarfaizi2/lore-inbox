Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266153AbSLISnb>; Mon, 9 Dec 2002 13:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266157AbSLISna>; Mon, 9 Dec 2002 13:43:30 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:44561 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266153AbSLISn1>; Mon, 9 Dec 2002 13:43:27 -0500
Date: Mon, 9 Dec 2002 10:52:01 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
cc: Daniel Jacobowitz <dan@debian.org>, george anzinger <george@mvista.com>,
       Jim Houston <jim.houston@ccur.com>,
       Stephen Rothwell <sfr@canb.auug.org.au>,
       LKML <linux-kernel@vger.kernel.org>, <anton@samba.org>,
       "David S. Miller" <davem@redhat.com>, <ak@muc.de>, <davidm@hpl.hp.com>,
       <ralf@gnu.org>, <willy@debian.org>
Subject: Re: [PATCH] compatibility syscall layer (lets try again)
In-Reply-To: <OF6B91BBE3.E3C87169-ONC1256C8A.0066A5C2@de.ibm.com>
Message-ID: <Pine.LNX.4.44.0212091051120.1282-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 9 Dec 2002, Martin Schwidefsky wrote:
>
> I had been looking at 2.5.50, we had a different meaning of current.
> If you are saying that for any implementation of nanosleep I have to implement
> the -ERESTART_RESTARTBLOCK thingy anyway, then I better start with it.

You don't _have_ to. An architecture for which restarting is just too
painful can just always choose to return -EINTR, that should be ok. That's
how nanosleep() used to work before - it may not be 100% SuS compliant,
but it's not as if anybody really cares, I suspect.

		Linus

