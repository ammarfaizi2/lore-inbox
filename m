Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131386AbRD2UWG>; Sun, 29 Apr 2001 16:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136347AbRD2UVZ>; Sun, 29 Apr 2001 16:21:25 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:21254 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S136338AbRD2UTi>; Sun, 29 Apr 2001 16:19:38 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: X15 alpha release: as fast as TUX but in user space (fwd)
Date: 29 Apr 2001 13:19:28 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9cht0g$jcn$1@cesium.transmeta.com>
In-Reply-To: <3AEBF782.1911EDD2@mandrakesoft.com> <Pine.LNX.4.33.0104290914260.14261-100000@twinlark.arctic.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.33.0104290914260.14261-100000@twinlark.arctic.org>
By author:    dean gaudet <dean-list-linux-kernel@arctic.org>
In newsgroup: linux.dev.kernel
>
> On Sun, 29 Apr 2001, Jeff Garzik wrote:
> 
> > "H. Peter Anvin" wrote:
> > > We discussed this at the Summit, not a year or two ago.  x86-64 has
> > > it, and it wouldn't be too bad to do in i386... just noone did.
> >
> > It came up long before that.  I refer to the technique in a post dated
> > Nov 17, even though I can't find the original.
> > http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg13584.html
> >
> > Initiated by a post from (iirc) Dean Gaudet, we found out that
> > gettimeofday was one particular system call in the Apache fast path that
> > couldn't be optimized well, or moved out of the fast path.  After a
> > couple of suggestions for improving things, Linus chimed in with the
> > magic page suggestion.
> 
> heheh.  i can't claim that i was the first ever to think of this.  but
> here's the post i originally made on the topic.  iirc a few folks said
> "security horror!"... then last year ingo and linus (and probably others)
> came up with a scheme everyone was happy with.
> 
> i was kind of solving a different problem with the code page though -- the
> ability to use rdtsc on SMP boxes with processors of varying speeds and
> synchronizations.
> 

The thing that made me say we discussed this last month was Richard's
comment that it had already been implemented (which it has, by Andrea,
for x86-64.)  The idea of doing it for i386 has been kicked around for
years, originally as a way to handle INT 0x80 vs SYSENTER vs SYSCALL,
which I think is part of why it never got implemented, since handling
multiple flavours of system calls apparently causes some pain in the
system call entry/exit path.

The handling of a few things like gettimeofday etc. was something we
observed could be added on top at that time, but was largely
considered secondary.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
