Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316088AbSHBSGB>; Fri, 2 Aug 2002 14:06:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316322AbSHBSGB>; Fri, 2 Aug 2002 14:06:01 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:10764 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316088AbSHBSGA>; Fri, 2 Aug 2002 14:06:00 -0400
Date: Fri, 2 Aug 2002 11:10:19 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Benjamin LaHaise <bcrl@redhat.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       David Woodhouse <dwmw2@infradead.org>,
       David Howells <dhowells@redhat.com>, <alan@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: manipulating sigmask from filesystems and drivers
In-Reply-To: <shsr8hhqh3d.fsf@charged.uio.no>
Message-ID: <Pine.LNX.4.44.0208021109210.1108-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 2 Aug 2002, Trond Myklebust wrote:
>
> Would you therefore be planning on making down() interruptible by
> SIGKILL?

Can't do - existing users know that down() cannot fail.

But we already have a "down_interruptible()", so if we introduce the
notion of "non-interruptible but killable", we can also introduce a
"down_killable()".

		Linus

