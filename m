Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262493AbVFIWbU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262493AbVFIWbU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 18:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262499AbVFIWbU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 18:31:20 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:27051
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S262493AbVFIWbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 18:31:13 -0400
Date: Thu, 09 Jun 2005 15:31:03 -0700 (PDT)
Message-Id: <20050609.153103.39157619.davem@davemloft.net>
To: gregkh@suse.de
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       nsankar@broadcom.com
Subject: Re: [PATCH] PCI: MSI functionality broken on Serverworks GC chipset
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050609222133.GB12580@kroah.com>
References: <20050609222033.GA12580@kroah.com>
	<20050609222133.GB12580@kroah.com>
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg KH <gregkh@suse.de>
Date: Thu, 9 Jun 2005 15:21:33 -0700

> [PATCH] PCI: MSI functionality broken on Serverworks GC chipset
> 
> MSI functionality is broken on the GC_LE x86 chipset that Serverworks
> developed and that is being used in various platforms today. Broadcom is
> going to push out to the kernel MSI enabled Gigabit drivers (in the very
> near future), and we would like to make sure that MSI does not get
> enabled on any platforms using the GC_LE chipset (device id 0x17).
> Following the AMD 8131 example, I am including a patch to disable MSI
> functionality when a GCNB_LE is detected. Please let me know if there
> are any issues with this. This is a permanent fix for this chipset, as
> the hardware will not be updated.
> 
> Signed-off-by: Narendra Sankar <nsankar@broadcom.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

"Broadcom's driver" already has MSI support and has a self-test that
checks if MSI operates correctly, and will back out of using MSI if
the MSI test does not pass.

So this patch is not needed for proper functioning of that driver.

This changelog description is very misleading, at best.
