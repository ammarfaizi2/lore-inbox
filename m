Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129506AbRC3Tl1>; Fri, 30 Mar 2001 14:41:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129524AbRC3TlR>; Fri, 30 Mar 2001 14:41:17 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:9518 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S129506AbRC3TlH>; Fri, 30 Mar 2001 14:41:07 -0500
Date: Fri, 30 Mar 2001 13:39:36 -0600 (CST)
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: "Manuel A. McLure" <mmt@unify.com>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.4.3 fails to compile
In-Reply-To: <419E5D46960FD211A2D5006008CAC79902E5C161@pcmailsrv1.sac.unify.com>
Message-ID: <Pine.LNX.3.96.1010330133901.8826V-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 30 Mar 2001, Manuel A. McLure wrote:

> ...
> gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2
> -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2
> -march=athlon  -DMODULE -DMODVERSIONS -include
> /usr/src/linux/include/linux/modversions.h   -c -o buz.o buz.c
> buz.c: In function `v4l_fbuffer_alloc':
> buz.c:188: `KMALLOC_MAXSIZE' undeclared (first use in this function)
> buz.c:188: (Each undeclared identifier is reported only once
> buz.c:188: for each function it appears in.)

Easy solution -- just delete the entire test

	if (size > KMALLOC_MAXSIZE) {
		...
	}



