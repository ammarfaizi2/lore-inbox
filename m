Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262786AbVAFJM3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262786AbVAFJM3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 04:12:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262787AbVAFJM2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 04:12:28 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:9739 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262786AbVAFJMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 04:12:24 -0500
Date: Thu, 6 Jan 2005 09:12:20 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [2.6] Clean up SL811 headers
Message-ID: <20050106091220.A23845@flint.arm.linux.org.uk>
Mail-Followup-To: Kyle Moffett <mrmacman_g4@mac.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <8A1C5ED3-5F82-11D9-B39F-000393ACC76E@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <8A1C5ED3-5F82-11D9-B39F-000393ACC76E@mac.com>; from mrmacman_g4@mac.com on Wed, Jan 05, 2005 at 08:30:25PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2005 at 08:30:25PM -0500, Kyle Moffett wrote:
> The USB SL811 host has a structure stuck in linux/usb_sl811.h  As this
> structure is kernel private and only used by a single piece of code, 
> this
> patch moves it to the header file from which it is used, deleting the 
> old one.
> 
> Signed-off-by: Kyle Moffett <mrmacman_g4@mac.com>

No.  It's platform data.  That means that platforms, (eg, arch/arm/mach-pxa)
are expected to supply it to the SL811 driver.

linux/usb_sl811.h is the correct location for it.  The platforms which
use it are not merged just yet, but the SL811 driver is a recent merge
in preparation of this happening.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
