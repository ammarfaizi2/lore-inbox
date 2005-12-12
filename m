Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751175AbVLLPtm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbVLLPtm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 10:49:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbVLLPtm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 10:49:42 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:32010 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751175AbVLLPtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 10:49:41 -0500
Date: Mon, 12 Dec 2005 15:49:25 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Vitaly Wool <vwool@ru.mvista.com>
Cc: linux-kernel@vger.kernel.org, david-b@pacbell.net, dpervushin@gmail.com,
       akpm@osdl.org, greg@kroah.com, basicmark@yahoo.com,
       komal_shah802003@yahoo.com, stephen@streetfiresound.com,
       spi-devel-general@lists.sourceforge.net, Joachim_Jaeger@digi.com
Subject: Re: [PATCH 2.6-git 1/4] SPI core refresh: SPI core patch
Message-ID: <20051212154925.GA19481@flint.arm.linux.org.uk>
Mail-Followup-To: Vitaly Wool <vwool@ru.mvista.com>,
	linux-kernel@vger.kernel.org, david-b@pacbell.net,
	dpervushin@gmail.com, akpm@osdl.org, greg@kroah.com,
	basicmark@yahoo.com, komal_shah802003@yahoo.com,
	stephen@streetfiresound.com,
	spi-devel-general@lists.sourceforge.net, Joachim_Jaeger@digi.com
References: <20051212182026.4e393d5a.vwool@ru.mvista.com> <20051212182249.018daa1b.vwool@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051212182249.018daa1b.vwool@ru.mvista.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Only two comments this time.

On Mon, Dec 12, 2005 at 06:22:49PM +0300, Vitaly Wool wrote:
> +static int spi_bus_suspend(struct device * dev, pm_message_t message)
> +{
> +	int ret = 0;
> +
> +	if (dev && dev->driver && TO_SPI_DRIVER(dev->driver)->suspend ) {

dev will always be non-NULL here.

> +static int spi_bus_resume(struct device * dev)
> +{
> +	int ret = 0;
> +
> +	if (dev && dev->driver && TO_SPI_DRIVER(dev->driver)->suspend ) {

Ditto.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
