Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751056AbWH1Pqi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056AbWH1Pqi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 11:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbWH1Pqi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 11:46:38 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:14600 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750801AbWH1Pqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 11:46:37 -0400
Date: Mon, 28 Aug 2006 17:46:35 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andi Kleen <ak@suse.de>
Cc: Arnd Bergmann <arnd@arndb.de>, David Woodhouse <dwmw2@infradead.org>,
       David Miller <davem@davemloft.net>, linux-arch@vger.kernel.org,
       jdike@addtoit.com, B.Steinbrink@gmx.de, arjan@infradead.org,
       chase.venters@clientec.com, akpm@osdl.org, rmk+lkml@arm.linux.org.uk,
       rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] remove all remaining _syscallX macros
Message-ID: <20060828154634.GA3450@stusta.de>
References: <200608281003.02757.ak@suse.de> <1156759232.5340.36.camel@pmac.infradead.org> <200608281606.00602.arnd@arndb.de> <200608281642.21737.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608281642.21737.ak@suse.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2006 at 04:42:21PM +0200, Andi Kleen wrote:
> On Monday 28 August 2006 16:05, Arnd Bergmann wrote:
> 
> > The patch below should address both these issues, as long as the libc
> > has a working implementation of syscall(2).
> 
> I would prefer the _syscall() macros to stay independent of the 
> actual glibc version. Or what do you do otherwise on a system
> with old glibc? Upgrading glibc is normally a major PITA.

This would only be required if you'd upgrade the userspace kernel 
headers on this system to a version not matching the ones glibc was 
built against - and this has never been considered a good idea
(it should work in theory, but not with our current header mess).

> -Andi

cu
Adrian

-- 

    Gentoo kernels are 42 times more popular than SUSE kernels among
    KLive users  (a service by SUSE contractor Andrea Arcangeli that
    gathers data about kernels from many users worldwide).

       There are three kinds of lies: Lies, Damn Lies, and Statistics.
                                                    Benjamin Disraeli

