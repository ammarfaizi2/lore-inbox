Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751677AbVLAKwf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751677AbVLAKwf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 05:52:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751688AbVLAKwf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 05:52:35 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:10762 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751677AbVLAKwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 05:52:34 -0500
Date: Thu, 1 Dec 2005 10:52:27 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: "David S. Miller" <davem@davemloft.net>
Cc: dwmw2@infradead.org, vagabon.xyz@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [NET] Remove ARM dependency for dm9000 driver
Message-ID: <20051201105227.GA19317@flint.arm.linux.org.uk>
Mail-Followup-To: "David S. Miller" <davem@davemloft.net>,
	dwmw2@infradead.org, vagabon.xyz@gmail.com,
	linux-kernel@vger.kernel.org
References: <20051130190224.GE1053@flint.arm.linux.org.uk> <1133426199.4117.179.camel@baythorne.infradead.org> <20051201094111.GA14726@flint.arm.linux.org.uk> <20051201.015115.49187117.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051201.015115.49187117.davem@davemloft.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2005 at 01:51:15AM -0800, David S. Miller wrote:
> From: Russell King <rmk+lkml@arm.linux.org.uk>
> Date: Thu, 1 Dec 2005 09:41:11 +0000
> 
> > In which case why do we restrict floppy to only those machines which
> > could have floppy?  Why do we restrict IDE to only those platforms
> > which may have IDE?
> 
> These two examples require platform level support via
> an asm/*.h header file.
> 
> Whereas the driver's we are talking about use portable
> interfaces that should be available across the board.
> 
> So, bad example.

Not in the IDE case.  Bart restricted IDE to a smaller number of ARM
platforms, plus any that had PCMCIA.  There is no such restriction
in the asm-arm/*.h header files.

if PCMCIA || ARCH_CLPS7500 || ARCH_IOP3XX || ARCH_IXP4XX \
        || ARCH_L7200 || ARCH_LH7A40X || ARCH_PXA || ARCH_RPC \
        || ARCH_S3C2410 || ARCH_SA1100 || ARCH_SHARK || FOOTBRIDGE
source "drivers/ide/Kconfig"
endif

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
