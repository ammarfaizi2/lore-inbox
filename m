Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318607AbSHLCb2>; Sun, 11 Aug 2002 22:31:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318608AbSHLCb2>; Sun, 11 Aug 2002 22:31:28 -0400
Received: from waste.org ([209.173.204.2]:20135 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S318607AbSHLCb1>;
	Sun, 11 Aug 2002 22:31:27 -0400
Date: Sun, 11 Aug 2002 21:35:05 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Keith Owens <kaos@ocs.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: Unix-domain sockets - abstract addresses 
In-Reply-To: <9131.1028945953@ocs3.intra.ocs.com.au>
Message-ID: <Pine.LNX.4.44.0208112132510.25011-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Aug 2002, Keith Owens wrote:

> On Fri, 09 Aug 2002 18:41:04 -0700 (PDT),
> "David S. Miller" <davem@redhat.com> wrote:
> >   From: Keith Owens <kaos@ocs.com.au>
> >   Date: Sat, 10 Aug 2002 11:35:04 +1000
> >
> >   af_unix.c is linked into unix.o so we have -DKBUILD_MODNAME=unix.  Alas
> >   we also have -Dunix=1.  __stringify(KBUILD_MODNAME) -> __stringify(unix) ->
> >   "1" instead of "unix".
> >
> >This seems really tacky.  There must be a better way to do this.
> >Perhaps prepending some constant string prefix to these module
> >names such that they will not collide with the namespace in
> >this way.  For example, "kmod_".
>
> Adding a constant prefix to every label and string will increase the
> size of the kernel.  I would much rather find a way for cpp to strip
> quotes from a #define, then -DKBUILD_OBJECT=\"unix\" has no problems.
> But I don't know any cpp construct to convert KBUILD_OBJECT ("unix") to
> bare 'unix' without the quotes.  Undefining conflicting names is tacky
> but it has the least (zero) impact on the kernel size.

Might it be simpler to change the overall module name? unix.o is an
especially poor choice of names, compiler defines aside.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

