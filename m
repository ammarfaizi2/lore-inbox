Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315232AbSEYSph>; Sat, 25 May 2002 14:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315235AbSEYSpf>; Sat, 25 May 2002 14:45:35 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:18959 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315232AbSEYSov>; Sat, 25 May 2002 14:44:51 -0400
Date: Sat, 25 May 2002 11:44:39 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Karim Yaghmour <karim@opersys.com>
cc: Wolfgang Denk <wd@denx.de>, <linux-kernel@vger.kernel.org>
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
In-Reply-To: <3CEFD65A.ED871095@opersys.com>
Message-ID: <Pine.LNX.4.44.0205251138390.17649-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 25 May 2002, Karim Yaghmour wrote:
>
> Blinders ehh... Well, if you would care to ask I would answer.
>
> In reality, what you point out is actually a non-issue since the hard-rt
> user-land tasks are not allowed to call on normal Linux services. They
> can only call on RTAI services which are exported by an extra soft-int.
> These services are hard-rt, so there's no problem there.

.. which was exactly what I said:

 "..every single spinlock in the kernel assumes that the kernel isn't
  preempted, which means that user apps that can preempt the kernel
  cannot use them."

Karim, I don't _need_ to download RTAI or ask you questions about how it
works, because this is fundamental "RT-101" stuff. This is what priority
inversion is all about: if you make user land more important than the
kernel, it _cannot_ stay RT and use kernel services.

I went on to say:

   "Karim claims to give "user land" hard-real-time abilities, but the
    fact is, it's not "user land" any more. it's a limited shadow, and a
    _perversion_ of what user land is supposed to be all about."

Which certainly should have told you that I understood the limitations of
RTAI very well indeed. And I reject them.

		Linus

