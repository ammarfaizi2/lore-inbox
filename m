Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750866AbWADSEh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750866AbWADSEh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 13:04:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbWADSEh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 13:04:37 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:32777 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750866AbWADSEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 13:04:36 -0500
Date: Wed, 4 Jan 2006 18:04:25 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Gyorgy Jeney <nog.lkml@gmail.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, linux-kernel@vger.kernel.org,
       linux-serial@vger.kernel.org
Subject: Re: [patch][rfc] 8250_early: Too early for ioremap
Message-ID: <20060104180425.GB3119@flint.arm.linux.org.uk>
Mail-Followup-To: Gyorgy Jeney <nog.lkml@gmail.com>,
	Bjorn Helgaas <bjorn.helgaas@hp.com>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
References: <221e0ff70601010712l3ee799c0n@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <221e0ff70601010712l3ee799c0n@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 01, 2006 at 04:12:21PM +0100, Gyorgy Jeney wrote:
> Let the individual architectures define the function to use to remap the
> mmio-range that will be used by the 8250_early driver.  This is needed
> because, the default, ioremap() is non-functional when the 8250_early
> driver initialises.

Isn't there some other way this can be handled?  Can't this be hidden
in the architectures ioremap where it's a problem?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
