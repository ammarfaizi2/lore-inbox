Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265225AbTFVSmh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 14:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265402AbTFVSmh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 14:42:37 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:13952 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S265225AbTFVSme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 14:42:34 -0400
Date: Sun, 22 Jun 2003 20:03:50 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200306221903.h5MJ3oMi000585@81-2-122-30.bradfords.org.uk>
To: akpm@digeo.com, phillips@arcor.de
Subject: Re: GCC speed (was [PATCH] Isapnp warning)
Cc: acme@conectiva.com.br, alan@lxorguk.ukuu.org.uk, cw@f00f.org,
       geert@linux-m68k.org, linux-kernel@vger.kernel.org, perex@suse.cz,
       torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> No.  Compilation inefficiency directly harms programmer efficiency and the
> quality and volume of code the programmer produces.  These are surely the
> most important things by which a toolchain's usefulness should be judged.
>
> I compile with -O1 all the time and couldn't care the teeniest little bit
> about the performance of the generated code - it just doesn't matter.
>
> I'm happy allowing those thousands of people who do not compile kernels all
> the time to shake out any 3.2/3.3 compilation problems.
>
>
> Compilation inefficiency is the most serious thing wrong with gcc.

Code for hardware that almost nobody has anymore isn't easily tested
for subtle compilation errors.

The math emulation code didn't even compile for a while, and that went
unnoticed.  IFF there are substantial benefits to dropping 2.95.3
should we risk drivers for things like obscure SCSI cards being
mis-compiled and randomly corrupting data.

There _must_ be hardware that nobody has tested a gcc 3 compiled
kernel on.

All 2.5.X trees, and most 2.4.x trees have had a _lot_ of testing with
GCC 2.95.3, in a lot of different environments.  Especially in the
case of 2.4.X, a lot of that code hasn't seen significant changes in
the last year or so, and those code paths have been shown to be very
stable with gcc 2.95.3.

Eliminating gcc 2.95.3 support when a lot of people are still using
it, and having a large number of users migrate to gcc 3.3 could
uncover subtle compiler bugs a month or two later, and we'd end up
having to either live with that, or add support for gcc 2.95.3 back
in.

John.
