Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262821AbSJJCeG>; Wed, 9 Oct 2002 22:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262823AbSJJCeG>; Wed, 9 Oct 2002 22:34:06 -0400
Received: from codepoet.org ([166.70.99.138]:32189 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S262821AbSJJCeE>;
	Wed, 9 Oct 2002 22:34:04 -0400
Date: Wed, 9 Oct 2002 20:39:51 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] O_STREAMING - flag for optimal streaming I/O
Message-ID: <20021010023951.GA11063@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Jamie Lokier <lk@tantalophile.demon.co.uk>,
	Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
References: <20021009152731.GY3045@clusterfs.com> <Pine.LNX.4.44L.0210092045195.22735-100000@imladris.surriel.com> <20021010001641.GE2654@bjl1.asuk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021010001641.GE2654@bjl1.asuk.net>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.19-rmk2, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Oct 10, 2002 at 01:16:41AM +0100, Jamie Lokier wrote:
> Using the _same_ flag on different architectures can simplify the
> kernel source, though.  Just imagine, a set of O_* definitions in
> <linux/fcntl.h> instead of them being duplicated, with different
> definitions, throughout <asm-*/fcntl.h>.

That would be wonderful -- except those asm-*/fcntl.h values are
also duplicated in arch specific include/bits/fcntl.h files in
glibc, uClibc, etc and are compiled into zillions of existing
binaries.  Change it and you break binary compatibility...
So if your going to have a flag day, you will need to coordinate
that change with a bunch of non-kernel people as well.

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
