Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264559AbTFQEnf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 00:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264569AbTFQEnf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 00:43:35 -0400
Received: from dp.samba.org ([66.70.73.150]:19172 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264559AbTFQEne (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 00:43:34 -0400
Date: Tue, 17 Jun 2003 14:52:07 +1000
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Russell King <rmk@arm.linux.org.uk>, Matthew Wilcox <willy@debian.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: pci_domain_nr vs. /sys/devices
Message-ID: <20030617045207.GB1172@krispykreme>
References: <1055341842.754.3.camel@gaston> <20030611144801.GZ28581@parcelfarce.linux.theplanet.co.uk> <20030611164040.E16643@flint.arm.linux.org.uk> <1055347252.612.4.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1055347252.612.4.camel@gaston>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> Now, we should also fix pci_setup_device to make this naming
> generic to the entire kernel don't you think ? This won't
> affect /proc/bus/pci as it doesn't use the slot_name field
> in pci_dev, but at least it will make naming consistent.
> 
> (That also mean increasing slot_name size in pci.h)

Agreed. I did that in my patch since its important to be able to
uniquely identify a device:

PCI: Enabling device: (0000:21:01.0), cmd 143
PCI: Enabling bus mastering for device 0000:21:01.0
e100: selftest OK.
...
