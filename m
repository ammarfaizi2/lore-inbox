Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264912AbTFLRWA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 13:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264913AbTFLRWA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 13:22:00 -0400
Received: from ip68-107-142-198.tc.ph.cox.net ([68.107.142.198]:24463 "EHLO
	opus.bloom.county") by vger.kernel.org with ESMTP id S264912AbTFLRV6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 13:21:58 -0400
Date: Thu, 12 Jun 2003 10:35:41 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Matthew Wilcox <willy@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Consolidate binfmt choices in Kconfig
Message-ID: <20030612173541.GG828@ip68-0-152-218.tc.ph.cox.net>
References: <20030612172011.GO30843@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030612172011.GO30843@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 12, 2003 at 06:20:11PM +0100, Matthew Wilcox wrote:

> The full patch is around 60k, and is available from
> http://ftp.linux.org.uk/pub/linux/willy/patches/binfmt-Kconfig.diff
> 
>  21 files changed, 117 insertions(+), 922 deletions(-)
> 
> It's very repetitive, so to give a flavour for it, here's i386, m68knommu
> and fs/Kconfig.binfmt.  I rewrote the BINFMT_AOUT helptext to bring it
> into this decade.
> 
> Comments welcomed; I'll send it to Linus tomorrow if I don't hear anything.

Just a nit:

> Index: fs/Kconfig.binfmt
> ===================================================================
[snip]
> +config BINFMT_FLAT
> +	tristate "Kernel support for flat binaries"
> +	depends on !MMU
> +	help
> +	  Support uClinux FLAT format binaries.
> +
> +config BINFMT_ZFLAT
> +	bool "  Enable ZFLAT support"
> +	depends on BINFMT_FLAT
> +	help
> +	  Support FLAT format compressed binaries

Shouldn't that just be:
bool "Enable ZFLAT support"
as the config bits take care of indentation now?

-- 
Tom Rini
http://gate.crashing.org/~trini/
