Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263558AbTEIWwJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 18:52:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263566AbTEIWwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 18:52:09 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:29164 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263558AbTEIWwH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 18:52:07 -0400
Date: Fri, 9 May 2003 16:05:42 -0700
From: Greg KH <greg@kroah.com>
To: Max Krasnyansky <maxk@qualcomm.com>
Cc: David Brownell <david-b@pacbell.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: [Bluetooth] HCI USB driver update. Support for SCO over HCI USB.
Message-ID: <20030509230542.GA3267@kroah.com>
References: <200304290317.h3T3HOdA027579@hera.kernel.org> <200304290317.h3T3HOdA027579@hera.kernel.org> <5.1.0.14.2.20030429131303.10d7f330@unixmail.qualcomm.com> <5.1.0.14.2.20030429145523.10c52e50@unixmail.qualcomm.com> <5.1.0.14.2.20030508123858.01c004f8@unixmail.qualcomm.com> <3EBBFC33.7050702@pacbell.net> <1052517124.10458.199.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052517124.10458.199.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 09, 2003 at 03:35:36PM -0700, Max Krasnyansky wrote:
> Ok. Sounds like it should be
> 	uint32_t hcd_cb[16]; // 64 bytes for internal use by HCD
> 	uint32_t drv_cb[2];  // 8  bytes for internal use by USB driver

s/uint32_t/u32/ please.
And if this is going to be used for pointers, why not just say they are
pointers?  Otherwise people are going to have to be careful with 32 vs.
64 bit kernels to not overrun their space.

struct sk_buff uses a char, any reason not to use that here too?  Has
being a char made things more difficult for that structure over time?

thanks,

greg k-h
