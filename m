Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319301AbSHNUx4>; Wed, 14 Aug 2002 16:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319326AbSHNUxd>; Wed, 14 Aug 2002 16:53:33 -0400
Received: from d12lmsgate-3.de.ibm.com ([195.212.91.201]:52377 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id <S319301AbSHNUuA>; Wed, 14 Aug 2002 16:50:00 -0400
Content-Type: text/plain; charset=US-ASCII
From: Arnd Bergmann <arnd@bergmann-dalldorf.de>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: S390 vs S390x, was Re: [kbuild-devel] Re: [patch] kernel config 3/N - move sound into drivers/media
Date: Thu, 15 Aug 2002 00:52:31 +0200
User-Agent: KMail/1.4.2
Cc: linux-kernel@vger.kernel.org
References: <20020814043558.GN761@cadcamlab.org> <200208142318.13667.arnd@bergmann-dalldorf.de> <20020814202211.A23853@infradead.org>
In-Reply-To: <20020814202211.A23853@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208150052.31762.arnd@bergmann-dalldorf.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 14 August 2002 21:22, Christoph Hellwig wrote:
> On Wed, Aug 14, 2002 at 11:18:13PM +0200, Arnd Bergmann wrote:
> > Ok. So what happens there if a user space program e.g. does #include
> > <asm/page.h>? Where does that go instead of /usr/include/asm/page.h?
>
> First:  Userspace including asm/* headers is BROKEN.  But as we have lots
> of broken userspace we still to have to support that for some time.  The
And since in particular glibc is still part of this brokenness, every
sufficiently large user space program accesses them in some way...

> solution is to have a wrapper that includes either asm-<b> or asm-<a>
> depending on some cpp symbol.  Look at redhat's old kernel rpms for an
> example.
ok, so it does not work with the default kernel headers copied to 
/usr/include but some extra tweaking. Making the two include/asm-*/ trees
identical is just another way of getting to the same result.

	Arnd <><
