Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264254AbTLYJtq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 04:49:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264261AbTLYJtq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 04:49:46 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:51982 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264254AbTLYJtn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 04:49:43 -0500
Date: Thu, 25 Dec 2003 09:49:37 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: "Zhu, Yi" <yi.zhu@intel.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix make kernel rpm bug
Message-ID: <20031225094937.A11396@flint.arm.linux.org.uk>
Mail-Followup-To: "Zhu, Yi" <yi.zhu@intel.com>,
	Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
References: <3ACA40606221794F80A5670F0AF15F840254C76E@PDSMSX403.ccr.corp.intel.com> <Pine.LNX.4.44.0312251254240.16528-100000@mazda.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0312251254240.16528-100000@mazda.sh.intel.com>; from yi.zhu@intel.com on Thu, Dec 25, 2003 at 02:58:14PM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 25, 2003 at 02:58:14PM +0800, Zhu, Yi wrote:
> On Thu, 25 Dec 2003, Jeff Garzik wrote:
> > hmmm, I don't think $(ARCH) makes the rpm --target strings in all
> > cases..
> 
> From rpm man page --target PLATFORM will interpret PLATFORM as
> arch-vendor-os and set %_target, %_target_cpu, %_target_os accordingly.
> In this case only arch is set, so vendor and os will remain as default.
> 
> If you still think it is too implicit, how about change as below? In case
> you want set RPM_VENDOR_OS to something like "-unknown-linux".

What Jeff means is that $(ARCH) may not be what rpm calls the
architecture.  For instance, the kernel has "arm" but RPM has
"armv3l" "armv4l" etc, but doesn't know what "arm" is.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
