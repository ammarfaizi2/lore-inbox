Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271292AbRHOQy1>; Wed, 15 Aug 2001 12:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271291AbRHOQyR>; Wed, 15 Aug 2001 12:54:17 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:20233 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S271285AbRHOQyF>; Wed, 15 Aug 2001 12:54:05 -0400
Date: Wed, 15 Aug 2001 09:53:09 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <mag@fbab.net>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.8 Resource leaks + limits
In-Reply-To: <E15Wz1n-00033Y-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0108150952001.2220-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 15 Aug 2001, Alan Cox wrote:
>
> > Linux has had (for a while now) a "struct user" that is actually quickly
> > accessible through a direct pointer off every process that is associated
> > with that user, and we could (and _will_) start adding these kinds of
> > limits. However, part of the problem is that because the limits haven't
> > historically existed, there is also no accepted and nice way of setting
> > the limits.
>
> For that to work we need to seperate struct user from the uid a little, or
> provide heirarchical pools (which seems overcomplex). Its common to want
> to take a group of users (eg the chemists) and give them a shared limit
> rather than per user limits

No, I think the answer there is to do all the same things for "struct
group" as we do for user.

Yes, it would mean that the primary group is _really_ primary, but from a
system management standpoint that's probably preferable (ie you can give
group read-write access to a person without giving group "resource" access
to him)

		Linus

