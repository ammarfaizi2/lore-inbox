Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318638AbSHLC4O>; Sun, 11 Aug 2002 22:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318641AbSHLC4O>; Sun, 11 Aug 2002 22:56:14 -0400
Received: from rj.sgi.com ([192.82.208.96]:49341 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S318638AbSHLC4N>;
	Sun, 11 Aug 2002 22:56:13 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: Unix-domain sockets - abstract addresses 
In-reply-to: Your message of "Sun, 11 Aug 2002 21:35:05 EST."
             <Pine.LNX.4.44.0208112132510.25011-100000@waste.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 12 Aug 2002 12:59:53 +1000
Message-ID: <649.1029121193@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Aug 2002 21:35:05 -0500 (CDT), 
Oliver Xymoron <oxymoron@waste.org> wrote:
>> >   From: Keith Owens <kaos@ocs.com.au>
>> >   Date: Sat, 10 Aug 2002 11:35:04 +1000
>> >
>> >   af_unix.c is linked into unix.o so we have -DKBUILD_MODNAME=unix.  Alas
>> >   we also have -Dunix=1.  __stringify(KBUILD_MODNAME) -> __stringify(unix) ->
>> >   "1" instead of "unix".
>
>Might it be simpler to change the overall module name? unix.o is an
>especially poor choice of names, compiler defines aside.

I prefer that option, expect that it changes the name of a module.  Not
that we haven't done that before ...

A module name of af_unix would be much better, like af_packet.  It
would require changing the name of af_unix.c (source and conglomerate
objects cannot have the same basename) and a change to modutils to map
net-pf-1 to af_unix.

