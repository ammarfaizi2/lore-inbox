Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265880AbSLIR1g>; Mon, 9 Dec 2002 12:27:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265885AbSLIR1g>; Mon, 9 Dec 2002 12:27:36 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:36619 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265880AbSLIR1d>; Mon, 9 Dec 2002 12:27:33 -0500
Date: Mon, 9 Dec 2002 09:35:59 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Mikael Starvik <mikael.starvik@axis.com>
cc: "'Daniel Jacobowitz'" <dan@debian.org>,
       "'george anzinger'" <george@mvista.com>,
       "'Jim Houston'" <jim.houston@ccur.com>,
       "'Stephen Rothwell'" <sfr@canb.auug.org.au>,
       "'LKML'" <linux-kernel@vger.kernel.org>,
       "'anton@samba.org'" <anton@samba.org>,
       "'David S. Miller'" <davem@redhat.com>, "'ak@muc.de'" <ak@muc.de>,
       "'davidm@hpl.hp.com'" <davidm@hpl.hp.com>,
       "'schwidefsky@de.ibm.com'" <schwidefsky@de.ibm.com>,
       "'ralf@gnu.org'" <ralf@gnu.org>,
       "'willy@debian.org'" <willy@debian.org>
Subject: RE: [PATCH] compatibility syscall layer (lets try again)
In-Reply-To: <3C6BEE8B5E1BAC42905A93F13004E8AB017DE4E9@mailse01.axis.se>
Message-ID: <Pine.LNX.4.44.0212090906340.3410-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 9 Dec 2002, Mikael Starvik wrote:
>
> No problem for CRIS architechture (port will be submitted when 2.5.51
> has been released if that happens before xmas).

Note that I've not committed the patch to my tree at all, and as far as I
am concerned this is in somebody elses court (ie somebody that cares about
restarting). I don't have any strong feelings either way about how
restarting should work - and I'd like to have somebody take it up and
testing it as well as having architecture maintainers largely sign off on
this approach.

It's certainly more flexible to save restart info in user space registers,
so in that way it's good. It has some downsides, though - it may be
against the callinmg convention of the architecture, for example, to
change those registers (some people expect the system call arguments to
not be changed by the system call, so when it returns and the arguments
have been modified to be the "restart arguments", those people would be
unhappy).

And apparently ia64 is again being a singularly awkward architecture.

			Linus

