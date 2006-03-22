Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751047AbWCVSZW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751047AbWCVSZW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 13:25:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751052AbWCVSZW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 13:25:22 -0500
Received: from waste.org ([64.81.244.121]:21208 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1751042AbWCVSZV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 13:25:21 -0500
Date: Wed, 22 Mar 2006 12:25:04 -0600
From: Matt Mackall <mpm@selenic.com>
To: akpm@osdl.org
Cc: rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: + serial-mystery-kbuild-fix.patch added to -mm tree
Message-ID: <20060322182504.GL31656@waste.org>
References: <200603211203.k2LC3cm1005618@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603211203.k2LC3cm1005618@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2006 at 04:00:29AM -0800, akpm@osdl.org wrote:
> 
> My kingdom for a changelog!

Still wanting one? I think it should be:

Allow disabling serial PCI and PNP support for embedded systems.

> +config SERIAL_8250_PCI
> +	tristate "8250/16550 PCI device support" if EMBEDDED
> +	depends on SERIAL_8250 && PCI
> +	default y
> +	help
> +	  This builds standard PCI serial support. You may be able to
> +	  disable this feature if you only need legacy serial support.
> +	  Saves about 9K.
> +
> +config SERIAL_8250_PNP
> +	tristate "8250/16550 PNP device support" if EMBEDDED
> +	depends on SERIAL_8250 && PNP
> +	default y

This wants some help text. Like:

    This builds standard PNP serial support. You may be able to
    disable this feature if you only need legacy serial support.

-- 
Mathematics is the supreme nostalgia of our time.
