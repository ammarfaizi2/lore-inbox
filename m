Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318816AbSG0UIg>; Sat, 27 Jul 2002 16:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318818AbSG0UIg>; Sat, 27 Jul 2002 16:08:36 -0400
Received: from potter.sfbay.redhat.com ([205.180.83.107]:35078 "EHLO
	potter.sfbay.redhat.com") by vger.kernel.org with ESMTP
	id <S318816AbSG0UIe>; Sat, 27 Jul 2002 16:08:34 -0400
To: J Sloan <joe@tmsusa.com>
Cc: vda@port.imtp.ilyichevsk.odessa.ua,
       "Albert D. Cahalan" <acahalan@cs.uml.edu>, linux-kernel@vger.kernel.org
Subject: Re: keep code simple
References: <200207270323.g6R3Nkb39182@saturn.cs.uml.edu>
	<200207271907.g6RJ7ST27551@Port.imtp.ilyichevsk.odessa.ua>
	<3D42F1DA.5060309@tmsusa.com>
From: Aldy Hernandez <aldyh@redhat.com>
Date: 27 Jul 2002 13:24:32 -0700
In-Reply-To: <3D42F1DA.5060309@tmsusa.com>
Message-ID: <m3vg70kjgf.fsf@flamingo.sfbay.redhat.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1.90
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 >> A bit offtopic, but: I heard M$ and Intel compilers beat GCC
 >> by 20-40% in terms of code size. Why GCC is so much behind?
 >> 
 > er...

 > one big reason is that gcc is cross platform, while
 > ms and intel can cut corners and optimize for x86

That and most of gcc's optimizations are done at the RTL level, which
is just a glorified assembler.  IIRC the original GCC optimizer was
based on the U of Arizona optimizer which was just an assembly
optimizer.  Consequently higher lever optimizations, which every
serious compiler (but gcc) do, are unbeknownst to gcc.

If you lower the high level code too much (like gcc does), you loose
certain abstractions such as loops, that could benefit enormously from
high lever optimizations.

Diego Novillo is doing a lot of infrastructure work for gcc so we can
do these high level optimizations, but that's a bit far in the
horizon.

Cheers.

Aldy
