Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262037AbVGZSlX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262037AbVGZSlX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 14:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262033AbVGZSif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 14:38:35 -0400
Received: from [69.55.234.183] ([69.55.234.183]:27627 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262018AbVGZSg2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 14:36:28 -0400
Date: Tue, 26 Jul 2005 10:50:14 -0700
From: Greg KH <greg@kroah.com>
To: Kumar Gala <galak@freescale.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: PCI: fix up errors after dma bursting patch and CONFIG_PCI=n -- bug?
Message-ID: <20050726175014.GB1493@kroah.com>
References: <Pine.LNX.4.61.0507252350390.7078@nylon.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0507252350390.7078@nylon.am.freescale.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2005 at 11:52:43PM -0500, Kumar Gala wrote:
> Andrew,
> 
> In the patch from:
> 
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0506.3/0985.html
> 
> Is the the following line suppose inside the if CONFIG_PCI=n
> 
>   #define pci_dma_burst_advice(pdev, strat, strategy_parameter) do { } while (0)
> 
> Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

Hm, how did that work?

Bah, that pci.h file needs some major cleanups, I'll apply this patch
and clean up the rest to make it more sane.

thanks,

greg k-h
