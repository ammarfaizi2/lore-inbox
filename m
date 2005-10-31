Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964862AbVJaXNt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964862AbVJaXNt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 18:13:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964887AbVJaXNs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 18:13:48 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:8464 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S964862AbVJaXNr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 18:13:47 -0500
Date: Mon, 31 Oct 2005 23:13:42 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Matt Mackall <mpm@selenic.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 19/20] inflate: (arch) use proper linking
Message-ID: <20051031231342.GB1710@flint.arm.linux.org.uk>
Mail-Followup-To: Matt Mackall <mpm@selenic.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
References: <19.196662837@selenic.com> <20.196662837@selenic.com> <20051031224501.GG20452@flint.arm.linux.org.uk> <20051031230233.GE4367@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051031230233.GE4367@waste.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2005 at 03:02:33PM -0800, Matt Mackall wrote:
> On Mon, Oct 31, 2005 at 10:45:01PM +0000, Russell King wrote:
> > On Mon, Oct 31, 2005 at 02:54:52PM -0600, Matt Mackall wrote:
> > > inflate: remove include of lib/inflate.c and use proper linking
> > > 
> > > - make free_mem_ptr vars nonstatic
> > > - make gunzip nonstatic
> > > - add gunzip prototype to new inflate.h
> > > - add per-arch Makefile bits
> > > - change inflate.c includes to inflate.h includes
> > > - change NO_INFLATE_MALLOC to CORE
> > > - compile core kernel version of inflate with -DCORE
> > 
> > We need to build inflate.c with -Dstatic= to disable static data, 
> > and text so that we get the correct binary layout for ARM PIC
> > decompressors.  This patch breaks that.
> 
> So.. we need to add CFLAGS_inflate.o := -Dstatic=? Or is more needed?

I think that'll do.  Trying it in practice will tell though.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
