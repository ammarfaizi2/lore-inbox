Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751434AbWEDHym@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434AbWEDHym (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 03:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750927AbWEDHym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 03:54:42 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:62472 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750754AbWEDHym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 03:54:42 -0400
Date: Thu, 4 May 2006 08:54:33 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, Pierre Ossman <drzeus-list@drzeus.cx>,
       Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: Re: MMC: 2/2 Fix MMC_POWER_UP on some OMAP boards
Message-ID: <20060504075433.GA2839@flint.arm.linux.org.uk>
Mail-Followup-To: Tony Lindgren <tony@atomide.com>,
	linux-kernel@vger.kernel.org, Pierre Ossman <drzeus-list@drzeus.cx>,
	Carlos Aguiar <carlos.aguiar@indt.org.br>
References: <20060504072439.GE8664@atomide.com> <20060504072630.GF8664@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060504072630.GF8664@atomide.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04, 2006 at 12:26:30AM -0700, Tony Lindgren wrote:
> MMC spec says that we must not enable clock prior to the power
> stabilizing. But at least omap16xx needs clock divisor configured
> during MMC_POWER_UP.

In which case it's probably better to treat MMC_POWER_UP the same as
MMC_POWER_OFF and just use MMC_POWER_ON and wait for your host to
complete it's power stabilisation.  No need for this additional
complexity.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
