Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262092AbTLBNsJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 08:48:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbTLBNsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 08:48:09 -0500
Received: from intra.cyclades.com ([64.186.161.6]:4830 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S262092AbTLBNsD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 08:48:03 -0500
Date: Tue, 2 Dec 2003 11:31:00 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Chris Siebenmann <cks@utcc.utoronto.ca>, <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: drivers/char/rtc.c compile failure in current 2.4 BitKeeper
 tree:
In-Reply-To: <20031202000927.GA3109@linux-mips.org>
Message-ID: <Pine.LNX.4.44.0312021130390.13692-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 2 Dec 2003, Ralf Baechle wrote:

> On Mon, Dec 01, 2003 at 07:01:17PM -0500, Chris Siebenmann wrote:
> 
> >  I'm compiling for SMP x86 and getting:
> > 	make[3]: Entering directory `/homes/hawkwind/u0/cks/sys/linux-BK/drivers/char'
> > 	gcc -D__KERNEL__ -I/homes/hawkwind/u0/cks/sys/linux-BK/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686   -nostdinc -iwithprefix include -DKBUILD_BASENAME=rtc  -c -o rtc.o rtc.c
> > 	rtc.c: In function `rtc_init':
> > 	rtc.c:772: `RTC_IOMAPPED' undeclared (first use in this function)
> > 	rtc.c:772: (Each undeclared identifier is reported only once
> > 	rtc.c:772: for each function it appears in.)
> > 	rtc.c:773: `RTC_IO_EXTENT' undeclared (first use in this function)
> > 	rtc.c: In function `rtc_exit':
> > 	rtc.c:873: `RTC_IOMAPPED' undeclared (first use in this function)
> > 	rtc.c:874: `RTC_IO_EXTENT' undeclared (first use in this function)
> > 	make[3]: *** [rtc.o] Error 1
> > 
> > It looks like the MIPS changes require these to be defined in
> > include/asm-*/mc146818rtc.h (or included files) for all architectures
> > (previously RTC_IO_EXTENT was defined in rtc.c and RTC_IOMAPPED didn't
> > exist), but only MIPS has been updated to do this. From looking at the
> > diffs to rtc.c, it looks like the correct additions are just:
> 
> Seems Marcelo didn't (yet?) merge below patch which I had sent to him
> separate from the rtc.c patches ...

Just applied the patch.



