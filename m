Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266240AbSKGA3e>; Wed, 6 Nov 2002 19:29:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266248AbSKGA3d>; Wed, 6 Nov 2002 19:29:33 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:44433 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S266240AbSKGA3d>; Wed, 6 Nov 2002 19:29:33 -0500
X-AuthUser: davidel@xmailserver.org
Date: Wed, 6 Nov 2002 16:46:03 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] epoll bits 0.30 ...
In-Reply-To: <20021106124607.09da5e1c.rusty@rustcorp.com.au>
Message-ID: <Pine.LNX.4.44.0211061641180.953-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Nov 2002, Rusty Russell wrote:

> On Mon, 4 Nov 2002 19:44:29 -0800 (PST)
> Davide Libenzi <davidel@xmailserver.org> wrote:
>
> >
> > These are the latest few bits for epoll. Changes :
> >
> > *) Some constant adjusted
> >
> > *) Comments plus
> >
> > *) Better hash initialization
>
> Um, why doesn't this use linux/hash.h?  Haven't looked hard, but...

Rusty, the hash is not under pressure over there. The only time seeks is
performed is at file removal ( from the set ) and eventually at file
modify. There's a direct link between the wait queue and its item during
the high frequency event delivery, so need seek is performed.




- Davide


