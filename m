Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314340AbSFISJT>; Sun, 9 Jun 2002 14:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314389AbSFISJS>; Sun, 9 Jun 2002 14:09:18 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:3588 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S314340AbSFISJQ>; Sun, 9 Jun 2002 14:09:16 -0400
Date: Sun, 9 Jun 2002 11:09:02 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kai Henningsen <kaih@khms.westfalen.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Futex Asynchronous Interface
In-Reply-To: <8QXHSZTXw-B@khms.westfalen.de>
Message-ID: <Pine.LNX.4.44.0206091056550.13459-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 9 Jun 2002, Kai Henningsen wrote:
>
> However, I don't think that's all that important. What I'd rather see is
> making the network devices into namespace nodes. The situation of eth0 and
> friends, from a Unix perspective, is utterly unnatural.

But what would you _do_ with them? What would be the advantage as compared
to the current situation?

Now, to configure a device, you get a fd to the device the same way you
get a fd _anyway_ - with "socket()".

And anybody who says that "socket()" is utterly unnatural to the UNIX way
is quite far out to lunch. It may be unnatural to the Plan-9 way of
"everything is a namespace", but that was never the UNIX way. The UNIX way
is "everything is a file descriptor or a process", but that was never
about namespaces.

Yes, some old-timers could argue that original UNIX didn't have sockets,
and that the BSD interface is ugly and an abomination and that it _should_
have been a namespace thing, but that argument falls flat on its face when
you realize that the "pipe()" system call _was_ in original UNIX, and has
all the same issues.

Don't get hung up about names.

			Linus

