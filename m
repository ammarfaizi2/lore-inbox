Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263225AbSITRTM>; Fri, 20 Sep 2002 13:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263246AbSITRTM>; Fri, 20 Sep 2002 13:19:12 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:17427 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S263225AbSITRTM>; Fri, 20 Sep 2002 13:19:12 -0400
Date: Fri, 20 Sep 2002 13:16:57 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Jakub Jelinek <jakub@redhat.com>
cc: Ulrich Drepper <drepper@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
In-Reply-To: <20020920121525.A21220@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.3.96.1020920131456.29602B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Sep 2002, Jakub Jelinek wrote:

> On Fri, Sep 20, 2002 at 11:43:15AM -0400, Bill Davidsen wrote:
> > > Unless major flaws in the design are found this code is intended to
> > > become the standard POSIX thread library on Linux system and it will
> > > be included in the GNU C library distribution.
> > 
> > If the comment that this doesn't work with the stable kernel is correct, I
> > consider that a pretty major flaw. Unlike the kernel and NGPT which are
> > developed using an open source model with lots of eyes on the WIP, this
> > was done and then released whole with the decision to include it in the
> > standard library already made. Having any part of glibc not work with the
> > current stable kernel doesn't seem like such a hot idea, honestly.
> 
> glibc supports .note.ABI-tag notes for libraries, so there is no problem
> with having NPTL libpthread.so.0 --enable-kernel=2.5.36 in say
> /lib/i686/libpthread.so.0 and linuxthreads --enable-kernel=2.2.1 in
> /lib/libpthread.so.0. The dynamic linker will then choose based
> on currently running kernel.
> (well, ATM because of libc tsd DL_ERROR --without-tls ld.so cannot be used
> with --with-tls libs and vice versa, but that is beeing worked on).
> 
> That's similar to non-FLOATING_STACK and FLOATING_STACK linuxthreads,
> the latter can be used with 2.4.8+ or something kernels on IA-32.

Good point, I had forgotten that! It will be somewhat large having both,
but presumably someone who really worried about it would build a subset.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

