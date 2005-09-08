Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751336AbVIHHqq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbVIHHqq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 03:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbVIHHqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 03:46:45 -0400
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:34575 "EHLO
	roarinelk.homelinux.net") by vger.kernel.org with ESMTP
	id S1751336AbVIHHqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 03:46:45 -0400
Date: Thu, 8 Sep 2005 09:46:40 +0200
From: Manuel Lauss <mano@roarinelk.homelinux.net>
To: Len Brown <len.brown@intel.com>
Cc: acpi-devel@lists.sourceforge.net, Justin Piszcz <jpiszcz@lucidpixels.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.13 repeated ACPI events?
Message-ID: <20050908074640.GA2043@roarinelk.homelinux.net>
References: <20050905130643.GA30428@roarinelk.homelinux.net> <1126161558.21723.9.camel@toshiba>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1126161558.21723.9.camel@toshiba>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2005 at 02:39:18AM -0400, Len Brown wrote:
> On Mon, 2005-09-05 at 09:06 -0400, Manuel Lauss wrote:
> > On Mon, Sep 05, 2005 at 08:54:59AM -0400, Justin Piszcz wrote:
> > > I have a box where I keep getting this in dmesg:
> > >
> > > ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKD] -> GSI 5 (level,
> > low)
> > > -> IRQ 5
> > > ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKD] -> GSI 5 (level,
> > low)
> > > -> IRQ 5
> > > ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKD] -> GSI 5 (level,
> > low)
> > > -> IRQ 5
> 
> > 
> > > 01:00.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX
> > [Cyclone]
> 
> This is from the driver repeatedly calling pci_enable_device().
> Can you instrument the driver to find out why?

At least in my case, I believe it's a BIOS/Device issue. The BIOS itself
lists the 3c905b several times before booting the OS. When this 
occurs, neither linux nor windows can persuade the 3c905 to work.
Another thing, the motherboard in question is blacklisted by acpi
(Asus P2B-S)

-- 
 Manuel Lauss.
