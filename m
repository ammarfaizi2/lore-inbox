Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317474AbSFHXaC>; Sat, 8 Jun 2002 19:30:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317476AbSFHXaB>; Sat, 8 Jun 2002 19:30:01 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:62993 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317474AbSFHXaB>; Sat, 8 Jun 2002 19:30:01 -0400
Date: Sat, 8 Jun 2002 16:30:22 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Dan Aloni <da-x@gmx.net>
cc: Brian Gerst <bgerst@didntduck.org>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] More list_del_init cleanups
In-Reply-To: <20020608024030.GA18037@callisto.yi.org>
Message-ID: <Pine.LNX.4.44.0206081628390.11630-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 8 Jun 2002, Dan Aloni wrote:
>
> If we are at it, how about replacing:
>
> 	list_del(&entry->list);
> 	list_add(&entry->list, dispose);
>
> with something like:
>
> 	list_del_add(&entry->list, dispose);

Ehh.. Am I the only one who thinks "move()" would make more sense than
"del_add()"?

How many such users are there? I don't want to make up new abstractions if
they aren't widely used - it's not as if "del + add" is all that hard to
understand in itself..

		Linus

