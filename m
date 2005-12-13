Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964995AbVLMRbk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964995AbVLMRbk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 12:31:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbVLMRbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 12:31:40 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:1291 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751213AbVLMRbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 12:31:39 -0500
Date: Tue, 13 Dec 2005 17:31:12 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: Simon Richter <Simon.Richter@hogyros.de>, linux-kernel@vger.kernel.org,
       tony.luck@intel.com, linux-ia64@vger.kernel.org, matthew@wil.cx,
       grundler@parisc-linux.org, parisc-linux@parisc-linux.org,
       paulus@samba.org, linuxppc-dev@ozlabs.org, lethal@linux-sh.org,
       kkojima@rr.iij4u.or.jp, dwmw2@infradead.org,
       linux-mtd@lists.infradead.org
Subject: Re: [2.6 patch] defconfig's shouldn't set CONFIG_BROKEN=y
Message-ID: <20051213173112.GA24094@flint.arm.linux.org.uk>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	Simon Richter <Simon.Richter@hogyros.de>,
	linux-kernel@vger.kernel.org, tony.luck@intel.com,
	linux-ia64@vger.kernel.org, matthew@wil.cx,
	grundler@parisc-linux.org, parisc-linux@parisc-linux.org,
	paulus@samba.org, linuxppc-dev@ozlabs.org, lethal@linux-sh.org,
	kkojima@rr.iij4u.or.jp, dwmw2@infradead.org,
	linux-mtd@lists.infradead.org
References: <20051211185212.GQ23349@stusta.de> <20051211192109.GA22537@flint.arm.linux.org.uk> <20051211193118.GR23349@stusta.de> <20051211194437.GB22537@flint.arm.linux.org.uk> <20051213001028.GS23349@stusta.de> <439ECDCC.80707@hogyros.de> <20051213140001.GG23349@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051213140001.GG23349@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2005 at 03:00:01PM +0100, Adrian Bunk wrote:
> defconfig files are virtually never a configuration for the kernel they 
> are shipped with since they aren't updated every time some configuration 
> option is changed.
> 
> Consider a defconfig with CONFIG_BROKEN=n, and a driver that is enabled 
> in this defconfig gets for some reason marked as broken in the Kconfig 
> file - this will give exactly the same result as the one you describe.

Adrian,

The defconfig files in arch/arm/configs are for platform configurations
and are provided by the platform maintainers as a _working_ configuration
for their platform.  They're not "defconfigs".  They got called
"defconfigs" as a result of the kbuild "cleanups".  Please don't confuse
them as such.

If, in order to have a working platform configuration, they deem that
CONFIG_BROKEN must be enabled, then that's the way it is.

Therefore, I request that either you leave the ARM platform configurations
well alone, or follow the advice I've given so that we can _properly_
assess the impact of your changes.

Thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
