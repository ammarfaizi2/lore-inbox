Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319261AbSHNSMX>; Wed, 14 Aug 2002 14:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319262AbSHNSMX>; Wed, 14 Aug 2002 14:12:23 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:52497 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S319261AbSHNSMW>; Wed, 14 Aug 2002 14:12:22 -0400
Date: Wed, 14 Aug 2002 19:16:15 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Arnd Bergmann <arnd@bergmann-dalldorf.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: S390 vs S390x, was Re: [kbuild-devel] Re: [patch] kernel config 3/N - move sound into drivers/media
Message-ID: <20020814191615.A22462@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Arnd Bergmann <arnd@bergmann-dalldorf.de>,
	linux-kernel@vger.kernel.org
References: <20020814043558.GN761@cadcamlab.org> <200208141256.27680.arnd@bergmann-dalldorf.de> <20020814132011.A13932@infradead.org> <200208141921.58931.arnd@bergmann-dalldorf.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200208141921.58931.arnd@bergmann-dalldorf.de>; from arnd@bergmann-dalldorf.de on Wed, Aug 14, 2002 at 07:21:58PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2002 at 07:21:58PM +0200, Arnd Bergmann wrote:
> I also had the idea to unify the two (actually have tried a few months ago
> but did not bring it to a clean end), but was not really sure if it was a 
> good one. Do you think it is worth the effort of merging the existing code

I think it's worth the effort.  Especially if IBM wants to keep the 32 (31)bit
port alife long-term.  Having two codebases that are mostly the same doesn't
sound like a good idea for fix propagation to me.

> and changing all the documentation referring to arch/s390x?

How much documentation outside the kernel tree knows about it?

> We do indeed want to merge include/asm-s390 include/asm-s390x, which would
> help building a compiler that supports both on s390x,

I think it's a good idea but don't understand the compiler depency.  Why
do you need asm-s390 and asm-s390x to be the same to have an compiler that
works for 32bit and 64bit mode?  Today e.g. the sparc and x86 compilers
can support both modes with very different kernel headers.

I don't see how you want to make the s390x port refer to include/asm-s390
easily when ARCH is still s390x..
