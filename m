Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261500AbVAUAQX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbVAUAQX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 19:16:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261934AbVAUAO2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 19:14:28 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:14846 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262201AbVAUAMU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 19:12:20 -0500
Date: Thu, 20 Jan 2005 16:08:22 -0800
From: Greg KH <greg@kroah.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: John Mock <kd6pag@qsl.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc1 vs. PowerMac 8500/G3 (and VAIO laptop) [usb-storage oops]
Message-ID: <20050121000822.GA14580@kroah.com>
References: <E1CrPQ4-0000pW-00@penngrove.fdns.net> <1106210408.6932.27.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1106210408.6932.27.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2005 at 08:40:07AM +0000, David Woodhouse wrote:
> On Wed, 2005-01-19 at 15:39 -0800, John Mock wrote:
> > New to 2.6.11-rc1 is that 'lsusb' exhibits 'endian' problems on the
> > PowerMac.
> 
> Is that really new to 2.6.11-rc1? The kernel byte-swaps the bcdUSB,
> idVendor, idProduct, and bcdDevice fields in the device descriptor. It
> should probably swap them back before copying it up to userspace.

Doh, sorry for missing this one.  I've applied your patch to my trees,
and will show up in the next -mm release.

thanks.

greg k-h
