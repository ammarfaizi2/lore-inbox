Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262995AbUKUAeE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262995AbUKUAeE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 19:34:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261639AbUKUAcc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 19:32:32 -0500
Received: from gate.crashing.org ([63.228.1.57]:61082 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263213AbUKUAKq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 19:10:46 -0500
Subject: Re: Blocking access to a PCI device for "a long time"?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Timothy Miller <miller@techsource.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <419E66D1.8000304@techsource.com>
References: <419E66D1.8000304@techsource.com>
Content-Type: text/plain
Date: Sun, 21 Nov 2004 11:10:11 +1100
Message-Id: <1100995811.27157.46.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> - Make sure that nothing can get confused by the device "going away" on 
> the PCI/AGP bus, using whatever kernel locks are necessary
> - Save PCI config state of device
> - Instruct the FPGA to reload itself
> - Wait many, many, many, many milliseconds
> - Reload PCI config state
> - Unlock and continue
> 
> Other drivers accessing the bus for other devices is PROBABLY not a 
> problem, but nothing can touch the GPU while it's reloading.
> 
> Are there any problems with this approach that would make it a really 
> bad idea?

You should read the thread called [PATCH 1/2] pci: Block config access
during BIST where a similar issues with proposed solution is discussed.

Ben.


