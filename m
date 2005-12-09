Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932108AbVLIPNx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbVLIPNx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 10:13:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbVLIPNx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 10:13:53 -0500
Received: from nevyn.them.org ([66.93.172.17]:21184 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S932108AbVLIPNx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 10:13:53 -0500
Date: Fri, 9 Dec 2005 10:13:48 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Olaf Hering <olh@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Sachin Sant <sachinp@in.ibm.com>
Subject: Re: [PATCH] Adding ctrl-o sysrq hack support to 8250 driver
Message-ID: <20051209151348.GA12815@nevyn.them.org>
Mail-Followup-To: Olaf Hering <olh@suse.de>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, Sachin Sant <sachinp@in.ibm.com>
References: <20051209140559.GA23868@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051209140559.GA23868@suse.de>
User-Agent: Mutt/1.5.8i
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

And... you're going to make it impossible to run ppp over the serial
console port.  For everyone, not just your big POWER4 boxes.  As far as
I know, if you turn off the printk log level, this should work just
fine today.

-- 
Daniel Jacobowitz
CodeSourcery, LLC
