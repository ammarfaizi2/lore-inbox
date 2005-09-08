Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932180AbVIHGhj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbVIHGhj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 02:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbVIHGhj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 02:37:39 -0400
Received: from rwcrmhc13.comcast.net ([216.148.227.118]:30336 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1751091AbVIHGhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 02:37:38 -0400
Subject: Re: Kernel 2.6.13 repeated ACPI events?
From: Len Brown <len.brown@intel.com>
To: Manuel Lauss <mano@roarinelk.homelinux.net>
Cc: acpi-devel@lists.sourceforge.net, Justin Piszcz <jpiszcz@lucidpixels.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050905130643.GA30428@roarinelk.homelinux.net>
References: <20050905130643.GA30428@roarinelk.homelinux.net>
Content-Type: text/plain
Date: Thu, 08 Sep 2005 02:39:18 -0400
Message-Id: <1126161558.21723.9.camel@toshiba>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-09-05 at 09:06 -0400, Manuel Lauss wrote:
> On Mon, Sep 05, 2005 at 08:54:59AM -0400, Justin Piszcz wrote:
> > I have a box where I keep getting this in dmesg:
> >
> > ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKD] -> GSI 5 (level,
> low)
> > -> IRQ 5
> > ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKD] -> GSI 5 (level,
> low)
> > -> IRQ 5
> > ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKD] -> GSI 5 (level,
> low)
> > -> IRQ 5

> 
> > 01:00.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX
> [Cyclone]

This is from the driver repeatedly calling pci_enable_device().
Can you instrument the driver to find out why?

cheers,
-Len


