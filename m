Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315457AbSHNTPn>; Wed, 14 Aug 2002 15:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319268AbSHNTPm>; Wed, 14 Aug 2002 15:15:42 -0400
Received: from d12lmsgate.de.ibm.com ([195.212.91.199]:64131 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id <S315457AbSHNTPm>; Wed, 14 Aug 2002 15:15:42 -0400
Content-Type: text/plain; charset=US-ASCII
From: Arnd Bergmann <arnd@bergmann-dalldorf.de>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: S390 vs S390x, was Re: [kbuild-devel] Re: [patch] kernel config 3/N - move sound into drivers/media
Date: Wed, 14 Aug 2002 23:18:13 +0200
User-Agent: KMail/1.4.2
Cc: linux-kernel@vger.kernel.org
References: <20020814043558.GN761@cadcamlab.org> <200208141921.58931.arnd@bergmann-dalldorf.de> <20020814191615.A22462@infradead.org>
In-Reply-To: <20020814191615.A22462@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208142318.13667.arnd@bergmann-dalldorf.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 14 August 2002 20:16, Christoph Hellwig wrote:
> > and changing all the documentation referring to arch/s390x?
>
> How much documentation outside the kernel tree knows about it?

There are some books about Linux on s390/zSeries that are supposed
to be kept up to date with each of our "code drops" that happen
about twice a year. There probably isn't that much reference
to "s390x" since that's not an official IBM marketing term, but 
still they'd have to be audited. OTOH, there are other far bigger
documentation changes for 2.6, so having only one architecture might 
actually save some duplicated work even for the documentation.

> > We do indeed want to merge include/asm-s390 include/asm-s390x, which
> > would help building a compiler that supports both on s390x,
>
> I think it's a good idea but don't understand the compiler depency.  Why
> do you need asm-s390 and asm-s390x to be the same to have an compiler that
> works for 32bit and 64bit mode?  Today e.g. the sparc and x86 compilers
> can support both modes with very different kernel headers.

Ok. So what happens there if a user space program e.g. does #include
<asm/page.h>? Where does that go instead of /usr/include/asm/page.h?

	Arnd <><
