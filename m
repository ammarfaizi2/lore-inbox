Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262629AbTIEOzP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 10:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262587AbTIEOzP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 10:55:15 -0400
Received: from www.inreko.ee ([195.222.18.2]:5126 "EHLO www.inreko.ee")
	by vger.kernel.org with ESMTP id S262629AbTIEOzJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 10:55:09 -0400
Date: Fri, 5 Sep 2003 17:54:53 +0300
From: Marko Kreen <marko@l-t.ee>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OOPS] 2.4.22 / HPT372N
Message-ID: <20030905145452.GA24201@l-t.ee>
References: <20030904190426.GA31977@l-t.ee> <1062712012.22550.72.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1062712012.22550.72.camel@dhcp23.swansea.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 04, 2003 at 10:46:53PM +0100, Alan Cox wrote:
> On Iau, 2003-09-04 at 20:07, Marko Kreen wrote:
> > As i used the pen&paper method for oops tracking i dont have
> > full oops.
> > 
> > In hpt366.c function hpt372_tune_chipset line 427:
> > 
> >        list_conf = pci_bus_clock_list(speed,
> >                         (struct chipset_bus_clock_list_entry *)
> 
> I thought I'd fixed that crash case but it seems your system is over
> clocked.
> 
> FREQ: 85 PLL: 41
> hpt: no known IDE timings,
> 
> so your PCI bus is running at somewhere about 35Mhz and outside the
> drivers safe threshold. 

Thats surprising, nobody has intentionally overclocked it.

Now we did some experimenting with it and no BIOS settings seem
to affect the FREQ numbers. (Lower CPU/mem speed, 50/25 AGP/PCI speed.)
The FREQ still stays fixed at 85.

Motherboard is EP-4PDA2+.

Any idea how to remove the overclocking?  Otherwise it seems
like driver bug to me.

-- 
marko

