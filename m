Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291144AbSBLPsv>; Tue, 12 Feb 2002 10:48:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291145AbSBLPsl>; Tue, 12 Feb 2002 10:48:41 -0500
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:273 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S291144AbSBLPsa>; Tue, 12 Feb 2002 10:48:30 -0500
Date: Tue, 12 Feb 2002 15:48:16 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Daniel Stodden <stodden@in.tum.de>
Cc: "David S. Miller" <davem@redhat.com>, groudier@free.fr,
        alan@lxorguk.ukuu.org.uk, zaitcev@redhat.com,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: pci_pool reap?
Message-ID: <20020212154816.E31425@flint.arm.linux.org.uk>
In-Reply-To: <E16a6sw-0005Jw-00@the-village.bc.nu> <20020210211352.Q1910-100000@gerard> <20020211.184412.35663889.davem@redhat.com> <1013528224.2240.245.camel@bitch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1013528224.2240.245.camel@bitch>; from stodden@in.tum.de on Tue, Feb 12, 2002 at 04:36:34PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2002 at 04:36:34PM +0100, Daniel Stodden wrote:
> ARM does GFP_KERNEL, and then __ioremaps the underlying pages.
> ugh. is that the only way to get the area coherent?

Yes.  Cache bits are in the page tables, and it would be idiotic to
manipulate the cache bits on a 1MB granularity over the kernel
direct mapped space.

> furthermore i don't see why this could not be interrupt safe.

GFP_KERNEL in the page table allocation functions mainly.  We've been
around and around this recently on this mailing list, so I'm not going
to say anything further.  I don't want another long discussion about
this subject taking my time away from doing real work on ARM.  If you're
really interested in the outcome, please examine the lkml archives.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

