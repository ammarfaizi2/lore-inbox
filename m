Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269463AbRHaXZU>; Fri, 31 Aug 2001 19:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269752AbRHaXZK>; Fri, 31 Aug 2001 19:25:10 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:11021 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S269463AbRHaXZB>;
	Fri, 31 Aug 2001 19:25:01 -0400
Date: Fri, 31 Aug 2001 16:23:04 -0700
From: Greg KH <greg@kroah.com>
To: jeff millar <jeff@wa1hco.mv.com>
Cc: Carlos E Gorges <carlos@techlinux.com.br>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Hardware detection tool 0.2
Message-ID: <20010831162303.A23689@kroah.com>
In-Reply-To: <01083019402502.01265@skydive.techlinux> <20010830161809.A19258@kroah.com> <002801c13270$86592680$0201a8c0@home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <002801c13270$86592680$0201a8c0@home>; from jeff@wa1hco.mv.com on Fri, Aug 31, 2001 at 06:58:59PM -0400
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2001 at 06:58:59PM -0400, jeff millar wrote:
> 
> One reason: Not all hardware has the signals needed to detect when a card
> gets plugged or unplugged.  Consider legacy cPCI systems.  The don't have
> the Hot Swap extensions or backplane hot swap control.  The only way to find
> the cards is to periodically scan the bus for new cards, cards that
> disappeared, or requests for Hot Swap.

But the driver for those devices have a struct pci_driver object that
they use to register themselves with the PCI subsystem, right?  The
MODULE_DEVICE_TABLE uses the id_table structure in the struct pci_driver
object.  That's all, it isn't necessarily a hotplug specific thing.

And having that MODULE_DEVICE_TABLE for those drivers will allow the
kernel to load those modules when the bus is scanned for new cards, like
on boot :)

thanks,

greg k-h
