Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283049AbRLDLFr>; Tue, 4 Dec 2001 06:05:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283046AbRLDLFi>; Tue, 4 Dec 2001 06:05:38 -0500
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:47887 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S283058AbRLDLFX>; Tue, 4 Dec 2001 06:05:23 -0500
Date: Tue, 4 Dec 2001 11:04:35 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Frank Cornelis <fcorneli@elis.rug.ac.be>
Cc: Linux Kernel Mailing list <linux-kernel@vger.kernel.org>
Subject: Re: misc_cache_init
Message-ID: <20011204110435.C18147@flint.arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.33.0112031324470.19914-100000@trappist.elis.rug.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0112031324470.19914-100000@trappist.elis.rug.ac.be>; from fcorneli@elis.rug.ac.be on Mon, Dec 03, 2001 at 01:36:04PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2001 at 01:36:04PM +0100, Frank Cornelis wrote:
> I looked at some past kernel mailings and it seems like some archs need 
> specific caches and others don't. In order to provide these 
> functionalities I suggest to add somewhere to init/main.c
> 	misc_cache_init();
> and provide an initial
> 	#define misc_cache_init() do {} while (0)
> for every architecture.
> Anyone agrees on this?

We already have this under a slightly different name (Alan didn't merge it
into Linus' kernel though from what I remember): pgtable_cache_init.

This was used in -ac to initialise the ARM PTE slab, as well as the x86
PAE slabs immediately after the call to kmem_cache_sizes_init.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

