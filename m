Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265683AbSJXVpY>; Thu, 24 Oct 2002 17:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265684AbSJXVpY>; Thu, 24 Oct 2002 17:45:24 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:56593 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265683AbSJXVpX>;
	Thu, 24 Oct 2002 17:45:23 -0400
Date: Thu, 24 Oct 2002 14:49:52 -0700
From: Greg KH <greg@kroah.com>
To: Scott Murray <scottm@somanetworks.com>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       KOCHI Takayoshi <t-kouchi@mvf.biglobe.ne.jp>, jung-ik.lee@intel.com,
       tony.luck@intel.com, pcihpd-discuss@lists.sourceforge.net,
       linux-ia64@linuxia64.org, linux-kernel@vger.kernel.org
Subject: Re: [Pcihpd-discuss] Re: PCI Hotplug Drivers for 2.5
Message-ID: <20021024214952.GK25159@kroah.com>
References: <20021024165411.GG22654@kroah.com> <Pine.LNX.4.33.0210241300220.10937-100000@rancor.yyz.somanetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0210241300220.10937-100000@rancor.yyz.somanetworks.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2002 at 01:44:06PM -0400, Scott Murray wrote:
> 
> I don't know if you looked at my cPCI driver patch in detail, but it uses
> the setup-*.c code for all of its resource management.

I'm sorry, but I only glanced at it and missed this point.

> The only things that were really missing in 2.4.x were:
> 
> - exports of a few things, most notably pci_scan_bridge
> - code to update the resource windows of a newly added bridge (recursively)
> - a pci_write_bridge_bases
> - PCI resource reservation to allow hot insertion on dumb cPCI hardware
> - on x86, the smarts to work back to the root PCI bus to figure out the
>   IRQ pin to use when looking in the pirq table

All of these seem like things that should belong in the setup-*.c files
for others to use.

> Since I've been swamped with other stuff, I just started finally porting
> my cPCI stuff to 2.5 yesterday. :(  I think I can get it up and running
> relatively quickly, but figuring out Ivan's newer hotplug helper code
> and how to take advantage of it might take me a couple of days.

Nice, I was wondering what happened.  I'll go dig up your older patch
and take a closer look at it.

thanks,

greg k-h
