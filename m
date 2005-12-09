Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751335AbVLIOK7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbVLIOK7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 09:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbVLIOK7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 09:10:59 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:19466 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751335AbVLIOK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 09:10:58 -0500
Date: Fri, 9 Dec 2005 14:10:49 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Olaf Hering <olh@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Sachin Sant <sachinp@in.ibm.com>
Subject: Re: [PATCH] Adding ctrl-o sysrq hack support to 8250 driver
Message-ID: <20051209141049.GA31708@flint.arm.linux.org.uk>
Mail-Followup-To: Olaf Hering <olh@suse.de>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, Sachin Sant <sachinp@in.ibm.com>
References: <20051209140559.GA23868@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051209140559.GA23868@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2005 at 03:05:59PM +0100, Olaf Hering wrote:
> 
> If you can queue this up in -mm for a decade or two, just to make sure
> it doesnt make some setup unhappy.
> 
> 
> a POWER4 system in 'full-system-partition' mode has the console device
> on ttyS0. But the user interface to the Linux system console may still
> be on the hardware management console (HMC). If this is the case, there
> is no way to send a break to trigger a sysrq.
> Other setups do already use 'ctrl o' to trigger sysrq. This includes iSeries
> virtual console on tty1, and pSeries LPAR console on hvc0 or hvsi0.
> 
> 'ctrl o' is currently mapped to 'flush output', see 'stty -a'

I still strongly disagree with the idea of using a well defined
control character which already has an expected purpose for this.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
