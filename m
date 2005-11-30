Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751543AbVK3TRh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751543AbVK3TRh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 14:17:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751545AbVK3TRh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 14:17:37 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:18189 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751543AbVK3TRg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 14:17:36 -0500
Date: Wed, 30 Nov 2005 19:17:11 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Vitaly Wool <vwool@ru.mvista.com>
Cc: linux-kernel@vger.kernel.org, david-b@pacbell.net, dpervushin@gmail.com,
       akpm@osdl.org, greg@kroah.com, basicmark@yahoo.com,
       komal_shah802003@yahoo.com, stephen@streetfiresound.com,
       spi-devel-general@lists.sourceforge.net, Joachim_Jaeger@digi.com
Subject: Re: [PATCH 2.6-git] SPI core refresh
Message-ID: <20051130191710.GF1053@flint.arm.linux.org.uk>
Mail-Followup-To: Vitaly Wool <vwool@ru.mvista.com>,
	linux-kernel@vger.kernel.org, david-b@pacbell.net,
	dpervushin@gmail.com, akpm@osdl.org, greg@kroah.com,
	basicmark@yahoo.com, komal_shah802003@yahoo.com,
	stephen@streetfiresound.com,
	spi-devel-general@lists.sourceforge.net, Joachim_Jaeger@digi.com
References: <20051130195053.713ea9ef.vwool@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051130195053.713ea9ef.vwool@ru.mvista.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2005 at 07:50:53PM +0300, Vitaly Wool wrote:
> The main changes are:
> 
> - Matching rmk's 2.6.14-git5+ changes for device_driver suspend and
>   resume calls

Although it isn't obvious in this patch, I request that you don't use
use struct device_driver function methods directly in your drivers but
add suitable function methods in your spi_driver for probe/remove/
shutdown as required, and arrange for the SPI core to convert from
the generic device driver function methods to spi_driver function
methods.

I'm planning to eliminate all the device_driver function methods
entirely - the probe/remove/shutdown methods will eventually be
moved to bus_type.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
