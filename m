Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264989AbUFAMCx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264989AbUFAMCx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 08:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265005AbUFAMCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 08:02:53 -0400
Received: from panda.sul.com.br ([200.219.150.4]:10001 "EHLO panda.sul.com.br")
	by vger.kernel.org with ESMTP id S265003AbUFAMCv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 08:02:51 -0400
Date: Tue, 1 Jun 2004 09:00:19 -0300
To: Kevin Bube <k.bube@web.de>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: 2.4.26 fails to detect two Realtek cards
Message-ID: <20040601120019.GN2159@cathedrallabs.org>
References: <m1acznpz6c.fsf@ntcora.icbm.uni-oldenburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1acznpz6c.fsf@ntcora.icbm.uni-oldenburg.de>
From: aris@cathedrallabs.org (Aristeu Sergio Rozanski Filho)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,
> May 26 19:34:03 daisy kernel: 8139cp: 10/100 PCI Ethernet driver v1.1 (Aug 30, 2003)
> May 26 19:34:03 daisy kernel: 8139cp: pci dev 00:0c.0 (id 10ec:8139 rev 10) is not an 8139C+ compatible chip
> May 26 19:34:03 daisy kernel: 8139cp: Try the "8139too" driver instead.
> May 26 19:34:03 daisy kernel: 8139too Fast Ethernet driver 0.9.26
> May 26 19:34:03 daisy kernel: PCI: Found IRQ 5 for device 00:0c.0
> May 26 19:34:03 daisy kernel: PCI: Sharing IRQ 5 with 00:0d.0
> May 26 19:34:03 daisy kernel: eth0: RealTek RTL8139 at 0xc480d000, 00:50:fc:f6:9e:39, IRQ 5
> May 26 19:34:03 daisy kernel: eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
> 
> [...]
> 
> dmesg from 2.4.18-bf24
> 
> May 26 17:06:33 daisy kernel: ne2k-pci.c:v1.02 10/19/2000 D. Becker/P. Gortmaker
> May 26 17:06:33 daisy kernel:   http://www.scyld.com/network/ne2k-pci.html
> May 26 17:06:33 daisy kernel: PCI: Found IRQ 12 for device 00:0a.0
> May 26 17:06:33 daisy kernel: eth0: RealTek RTL-8029 found at 0xd800, IRQ 12, 00:20:18:B8:B7:38.
> May 26 17:06:33 daisy kernel: 8139cp 10/100 PCI Ethernet driver v0.0.6 (Nov 19, 2001)
> May 26 17:06:33 daisy kernel: 8139cp: pci dev 00:0c.0 (id 10ec:8139 rev 10) is not an 8139C+ compatible chip
> May 26 17:06:33 daisy kernel: 8139cp: Try the "8139too" driver instead.
> May 26 17:06:33 daisy kernel: 8139too Fast Ethernet driver 0.9.24
> May 26 17:06:34 daisy kernel: PCI: Found IRQ 5 for device 00:0c.0
> May 26 17:06:34 daisy kernel: PCI: Sharing IRQ 5 with 00:0d.0
> May 26 17:06:34 daisy kernel: eth1: RealTek RTL8139 Fast Ethernet at 0xc481a000, 00:50:fc:f6:9e:39, IRQ 5
> May 26 17:06:34 daisy kernel: eth1:  Identified 8139 chip type 'RTL-8139C'
I guess you forgot to include ne2k-pci driver in your new kernel
configuration. 8139too handles rtl8139 (100Mbps) cards and ne2k-pci your rtl8029 (10Mbps)

-- 
Aristeu

