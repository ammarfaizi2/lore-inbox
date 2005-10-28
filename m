Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751387AbVJ1H52@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbVJ1H52 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 03:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751428AbVJ1H52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 03:57:28 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:64528 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751387AbVJ1H51 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 03:57:27 -0400
Date: Fri, 28 Oct 2005 08:57:21 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: John Bowler <jbowler@acm.org>
Cc: "'Deepak Saxena'" <dsaxena@plexity.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.14 include/asm-arm/arch-ixp4xx/io.h: eliminate warning for pointer passed to integral function argument
Message-ID: <20051028075721.GF5044@flint.arm.linux.org.uk>
Mail-Followup-To: John Bowler <jbowler@acm.org>,
	'Deepak Saxena' <dsaxena@plexity.net>, linux-kernel@vger.kernel.org
References: <001001c5db87$85a55500$1001a8c0@kalmiopsis>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001001c5db87$85a55500$1001a8c0@kalmiopsis>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2005 at 11:19:14PM -0700, John Bowler wrote:
> Fix for a compiler warning, this wasn't apparent in 2.6.12, I
> believe the compiler options have been changed (somewhere) so
> that passing a (void*) to a (u32) argument is now warned.

readb/writeb and friends take a "void __iomem *".  You should
arrange the __ixp4xx versions to take that.

> This accounts for the majority of the warnings in my builds of
> the 2.6.14 kernel for NSLU2.

If you want to see why, grab sparse and build your kernel with C=1.

PS, please do not copy both linux-kernel and linux-arm-kernel.  It's
bad taste to send a message to an open mailing list and a members only
list.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
