Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131662AbRC3VpT>; Fri, 30 Mar 2001 16:45:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131658AbRC3VpJ>; Fri, 30 Mar 2001 16:45:09 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:26992 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S131654AbRC3Vo7>; Fri, 30 Mar 2001 16:44:59 -0500
Date: Fri, 30 Mar 2001 15:44:13 -0600 (CST)
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: "Manuel A. McLure" <mmt@unify.com>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Kernel 2.4.3 fails to compile
In-Reply-To: <419E5D46960FD211A2D5006008CAC79902E5C163@pcmailsrv1.sac.unify.com>
Message-ID: <Pine.LNX.3.96.1010330154345.8826W-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 30 Mar 2001, Manuel A. McLure wrote:

> Jeff Garzik wrote:
> > On Fri, 30 Mar 2001, Manuel A. McLure wrote:
> > 
> > > ...
> > > gcc -D__KERNEL__ -I/usr/src/linux/include -Wall 
> > -Wstrict-prototypes -O2
> > > -fomit-frame-pointer -fno-strict-aliasing -pipe 
> > -mpreferred-stack-boundary=2
> > > -march=athlon  -DMODULE -DMODVERSIONS -include
> > > /usr/src/linux/include/linux/modversions.h   -c -o buz.o buz.c
> > > buz.c: In function `v4l_fbuffer_alloc':
> > > buz.c:188: `KMALLOC_MAXSIZE' undeclared (first use in this function)
> > > buz.c:188: (Each undeclared identifier is reported only once
> > > buz.c:188: for each function it appears in.)
> > 
> > Easy solution -- just delete the entire test
> > 
> > 	if (size > KMALLOC_MAXSIZE) {
> > 		...
> > 	}
> 
> Thanks, I'll do that. It just seemed strange that the file was being
> compiled in the first place when the config option was not set.

buz is built with CONFIG...ZORAN as well as CONFIG...BUZ.  I dunno if
that's a bug or not...

	Jeff



