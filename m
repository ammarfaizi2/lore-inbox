Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750709AbVH1RjJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbVH1RjJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 13:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750710AbVH1RjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 13:39:09 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:39691 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750709AbVH1RjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 13:39:08 -0400
Date: Sun, 28 Aug 2005 18:39:02 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Deepak Saxena <dsaxena@plexity.net>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Allow for arch-specific IOREMAP_MAX_ORDER
Message-ID: <20050828183902.D14294@flint.arm.linux.org.uk>
Mail-Followup-To: Deepak Saxena <dsaxena@plexity.net>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20050824221202.GA28977@plexity.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050824221202.GA28977@plexity.net>; from dsaxena@plexity.net on Wed, Aug 24, 2005 at 03:12:02PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2005 at 03:12:02PM -0700, Deepak Saxena wrote:
> Version 6 of the ARM architecture introduces the concept of 16MB pages
> (supersections) and 36-bit (40-bit actually, but nobody uses this)
> physical addresses. 36-bit addressed memory and I/O and ARMv6 can
> only be mapped using supersections and the requirement on these is
> that both virtual and physical addresses be 16MB aligned.

Have we sorted out how we handle the issue of IO vs memory outside the
normal 4GB?  We can only map one or other depending on how the domains
are setup and get the correct permission behaviour.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
