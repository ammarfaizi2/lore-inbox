Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262323AbVBQT7l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262323AbVBQT7l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 14:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbVBQT7d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 14:59:33 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:58634 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262323AbVBQT6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 14:58:54 -0500
Date: Thu, 17 Feb 2005 19:58:51 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Frank Buss <fb@frank-buss.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problems with dma_mmap_writecombine on mach-pxa
Message-ID: <20050217195851.B22752@flint.arm.linux.org.uk>
Mail-Followup-To: Frank Buss <fb@frank-buss.de>,
	linux-kernel@vger.kernel.org
References: <20050217181241.A22752@flint.arm.linux.org.uk> <20050217191436.942345B874@frankbuss.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050217191436.942345B874@frankbuss.de>; from fb@frank-buss.de on Thu, Feb 17, 2005 at 08:14:34PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2005 at 08:14:34PM +0100, Frank Buss wrote:
> > Please try this (and revert your changes):
> 
> thanks, this could fix the bug with the vm_pgoff, but I don't think this
> will fix the problem with the ignored memory access after the first
> PAGE_SIZE from the mapped memory. I'll try it tommorow, when I'm again at my
> customers site, where I have access to the board.

Since we map the whole lot in one go, if you get one page, there's no
reason why you shouldn't get the lot.  This is why I'm wondering if
it has something to do with your other modifications.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
