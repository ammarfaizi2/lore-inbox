Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262080AbUGEUlY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262080AbUGEUlY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 16:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262279AbUGEUlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 16:41:24 -0400
Received: from fmr11.intel.com ([192.55.52.31]:672 "EHLO
	fmsfmr004.fm.intel.com") by vger.kernel.org with ESMTP
	id S262080AbUGEUlS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 16:41:18 -0400
Subject: Re: libata: 2.6.7-bk6,12 hang with ata_piix in combined mode; -bk5
	ok
From: Len Brown <len.brown@intel.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615FF44B@hdsmsx403.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615FF44B@hdsmsx403.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1089059982.15671.86.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 05 Jul 2004 16:39:42 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-06-29 at 21:20, Jeff Garzik wrote:
> On Tue, Jun 29, 2004 at 08:54:20PM -0400, Bill Rugolsky Jr. wrote:
> > ata_piix: combined mode detected
> > ACPI: PCI interrupt 0000:1f.2[A]: no GSI
> [...]
> >  sda:<3>ata1: command 0x25 timeout, stat 0xd0 host_stat 0x64
> 
> 
> I wonder what "no GSI" is.

It means that the ACPI PCI Routing Table (_PRT)
did not have an entry for this PCI device.

This is very common for IDE, which
can't decide if it is a real PCI device
or a legacy device; and the driver
is hard-coded to IRQ14, 15 anyway.

Linux is actually sort of exposed
WRT motherboard devices, because
while Linux/ACPI finds the PCI
resources, it doesn't look for
the legacy resource, which
is where on this board IDE lives.

-Len



