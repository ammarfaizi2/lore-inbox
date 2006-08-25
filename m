Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932394AbWHYUX0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932394AbWHYUX0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 16:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932408AbWHYUX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 16:23:26 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:41350 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932394AbWHYUXZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 16:23:25 -0400
Subject: Re: New serial speed handling: First implementation
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
In-Reply-To: <20060825174131.GA725@flint.arm.linux.org.uk>
References: <1156518953.3007.247.camel@localhost.localdomain>
	 <20060825174131.GA725@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 25 Aug 2006 21:44:57 +0100
Message-Id: <1156538697.3007.256.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-08-25 am 18:41 +0100, ysgrifennodd Russell King:
> On Fri, Aug 25, 2006 at 04:15:53PM +0100, Alan Cox wrote:
> > diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc4-mm2/include/asm-i386/ioctls.h linux-2.6.18-rc4-mm2/include/asm-i386/ioctls.h
> > --- linux.vanilla-2.6.18-rc4-mm2/include/asm-i386/ioctls.h	2006-08-21 14:17:52.000000000 +0100
> > +++ linux-2.6.18-rc4-mm2/include/asm-i386/ioctls.h	2006-08-25 11:23:20.000000000 +0100
> > @@ -47,6 +47,12 @@
> >  #define TIOCSBRK	0x5427  /* BSD compatibility */
> >  #define TIOCCBRK	0x5428  /* BSD compatibility */
> >  #define TIOCGSID	0x5429  /* Return the session ID of FD */
> > +
> > +#define TCGETS2		0x542A
> > +#define TCSETS2		0x542B
> > +#define TCSETSW2	0x542C
> > +#define TCSETSF2	0x542D
> > +
> 
> Wouldn't it be better to use the _IO* macros to define these new ioctls?
> Ditto for other architectures.

That really is up to you. For x86/x86-64 it would break the internal
consistency.

