Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131158AbRC3UNs>; Fri, 30 Mar 2001 15:13:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131486AbRC3UNh>; Fri, 30 Mar 2001 15:13:37 -0500
Received: from umail.unify.com ([204.163.170.2]:35819 "EHLO umail.unify.com")
	by vger.kernel.org with ESMTP id <S131158AbRC3UNY>;
	Fri, 30 Mar 2001 15:13:24 -0500
Message-ID: <419E5D46960FD211A2D5006008CAC79902E5C163@pcmailsrv1.sac.unify.com>
From: "Manuel A. McLure" <mmt@unify.com>
To: "'Jeff Garzik'" <jgarzik@mandrakesoft.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Kernel 2.4.3 fails to compile
Date: Fri, 30 Mar 2001 12:12:09 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> On Fri, 30 Mar 2001, Manuel A. McLure wrote:
> 
> > ...
> > gcc -D__KERNEL__ -I/usr/src/linux/include -Wall 
> -Wstrict-prototypes -O2
> > -fomit-frame-pointer -fno-strict-aliasing -pipe 
> -mpreferred-stack-boundary=2
> > -march=athlon  -DMODULE -DMODVERSIONS -include
> > /usr/src/linux/include/linux/modversions.h   -c -o buz.o buz.c
> > buz.c: In function `v4l_fbuffer_alloc':
> > buz.c:188: `KMALLOC_MAXSIZE' undeclared (first use in this function)
> > buz.c:188: (Each undeclared identifier is reported only once
> > buz.c:188: for each function it appears in.)
> 
> Easy solution -- just delete the entire test
> 
> 	if (size > KMALLOC_MAXSIZE) {
> 		...
> 	}

Thanks, I'll do that. It just seemed strange that the file was being
compiled in the first place when the config option was not set.

--
Manuel A. McLure - Unify Corp. Technical Support <mmt@unify.com>
Space Ghost: "Hey, what happened to the-?" Moltar: "It's out." SG: "What
about-?" M: "It's fixed." SG: "Eh, good. Good."
