Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137166AbREKQ23>; Fri, 11 May 2001 12:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137167AbREKQ2I>; Fri, 11 May 2001 12:28:08 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:54370 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S137166AbREKQ1y>; Fri, 11 May 2001 12:27:54 -0400
Date: Fri, 11 May 2001 18:27:39 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: x86 bootmem corruption
Message-ID: <20010511182739.S30355@athlon.random>
In-Reply-To: <20010511180737.Q30355@athlon.random> <E14yFci-0001Ho-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E14yFci-0001Ho-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, May 11, 2001 at 05:18:35PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 11, 2001 at 05:18:35PM +0100, Alan Cox wrote:
> > reserved.  This is the fix against 2.4.5pre1. This might explain weird
> > crashes and "reserved twice" error messages at boot on highmem systems.
> 
> Reserved twice occurs for two known reasons
> 
> BIOS reporting the same region twice or overlaps (fixed in -ac sent to Linus)
> find_smp_config blindly reserves pages that may already be marked as ROM and
> thus reserved anyway

when it happens because of a double reserve that's fine I know, it _can_
be harmless, I'm not trying to hide those messages. What I'm saying is
that it can _also_ indicate somebody allocated the page before we reserved
it and currently x86 allocates from the bootmem allocator before
reserving all its pages, that's a bug and I provided the fix.

Andrea
