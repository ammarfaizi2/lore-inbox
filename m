Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261295AbVBDXyi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261295AbVBDXyi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 18:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262702AbVBDXtX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 18:49:23 -0500
Received: from mail.kroah.org ([69.55.234.183]:10641 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266358AbVBDXsV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 18:48:21 -0500
Date: Fri, 4 Feb 2005 15:47:34 -0800
From: Greg KH <greg@kroah.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Patch to add usbmon
Message-ID: <20050204234734.GA28862@kroah.com>
References: <20050131212903.6e3a35e5@localhost.localdomain> <20050201071000.GF20783@kroah.com> <20050201222513.358d1db6@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050201222513.358d1db6@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2005 at 10:25:13PM -0800, Pete Zaitcev wrote:
> This patch adds so-called "usbmon", or USB monitoring framework, similar
> to what tcpdump provides for Ethernet. This is an initial version, but
> it should be safe and useful. It adds an overhead of an if () statement
> into submission and giveback paths even when not monitoring, but this
> was deemed a lesser evil than stealth manipulation of function pointers.
> 
> The patch makes two changes to hcd.c which make usbmon more useful:
>  - Change the way we determine that DMA should not be mapped for root
>    hubs, so that usbmon knows easily when it's safe to capture data.
>  - Return exports of usb_bus_list and usb_bus_list_lock for those who
>    wish to build usbmon as a module.
> 
> This version of the patch changes #define to inlines for hooks and
> drops extra mod_ops.
> 
> Signed-off-by: Pete Zaitcev

Applied, thanks.

greg k-h
