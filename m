Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264098AbUGFQOE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264098AbUGFQOE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 12:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264097AbUGFQOD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 12:14:03 -0400
Received: from slimnet.xs4all.nl ([194.109.194.192]:55514 "EHLO slimnas.slim")
	by vger.kernel.org with ESMTP id S264098AbUGFQOA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 12:14:00 -0400
Subject: Re: 2.6.7-mm3 USB ehci IRQ problem
From: Jurgen Kramer <gtm.kramer@inter.nl.net>
To: Len Brown <len.brown@intel.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1089062128.15675.122.camel@dhcppc4>
References: <A6974D8E5F98D511BB910002A50A6647615FEF3E@hdsmsx403.hd.intel.com>
	 <1089054167.15653.51.camel@dhcppc4>  <1089058581.2496.9.camel@paragon.slim>
	 <1089059612.3589.5.camel@paragon.slim> <1089062128.15675.122.camel@dhcppc4>
Content-Type: text/plain
Message-Id: <1089130549.3160.2.camel@paragon.slim>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 06 Jul 2004 18:15:49 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-07-05 at 23:15, Len Brown wrote:
> On Mon, 2004-07-05 at 16:33, Jurgen Kramer wrote:
> > On Mon, 2004-07-05 at 22:16, Jurgen Kramer wrote:
> > > On Mon, 2004-07-05 at 21:02, Len Brown wrote:
> > > > On Sun, 2004-06-27 at 08:02, Jurgen Kramer wrote:
> 
> > 2.6.7 vanilly results are in. The results are...it works..
> 
> great!  Now if you can apply this patch to 2.6.7 and tell me if
> it is ACPI that broke EHCI for you in -mm5 or something else:
> 
> http://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.6.7-mm5/broken-out/bk-acpi.patch
> 
Alright, still looks good:

<snip>
ACPI: Subsystem revision 20040615
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
<snip>
ehci_hcd 0000:00:1d.7: EHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 23, pci mem f881dc00
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
USB Universal Host Controller Interface driver v2.2
<snip>

So it doesn't look like a ACPI problem.

Jurgen


