Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281006AbRKLWTd>; Mon, 12 Nov 2001 17:19:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281046AbRKLWTX>; Mon, 12 Nov 2001 17:19:23 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:60176 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S281006AbRKLWTO>; Mon, 12 Nov 2001 17:19:14 -0500
Date: Mon, 12 Nov 2001 14:14:59 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Lionel Bouton <Lionel.Bouton@free.fr>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: File System Performance
In-Reply-To: <3BF04926.2080009@free.fr>
Message-ID: <Pine.LNX.4.33.0111121411410.7555-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 12 Nov 2001, Lionel Bouton wrote:
>
> Seems not the case with gnu tar : write isn't even called once on the fd
> returned by open("/dev/null",...). In fact a "grep write" on the strace
> output is empty in the "tar cf /dev/null" case. Every file in the tar-ed
> tree is stat-ed but no-one is read-ed.

Wow. What a sleazy optimization - it can't be anything but a special case.

How do they do it anyway? By matching on the name Or by knowing what the
minor/major numbers of /dev/null are supposed to be on that particular
operating system?

And what's the _point_ of the optimization? I've never heard of a "tar
benchmark"..

		Linus

