Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261581AbSKGUoU>; Thu, 7 Nov 2002 15:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265973AbSKGUoU>; Thu, 7 Nov 2002 15:44:20 -0500
Received: from air-2.osdl.org ([65.172.181.6]:5533 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261581AbSKGUoU>;
	Thu, 7 Nov 2002 15:44:20 -0500
Date: Thu, 7 Nov 2002 12:51:16 -0800
From: Dave Olien <dmo@osdl.org>
To: linux-kernel@vger.kernel.org
Cc: mochel@osdl.org
Subject: [BUG] 2.5.46 reloading a block device module doesn't probe devices
Message-ID: <20021107125116.A16707@acpi.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I just converted the DAC960 driver in 2.5.46 to use the pci_register_driver()
to discover devices.

I've been experimenting loading the DAC960 driver module, unloading
the module, and then loading it again.  I get curious behavior.
The load, unload seem to work fine.

The reload also APPEARS to succeed. The insmod command completes
with a successful status.

But the second loading of the driver never calls the driver's probe routines.
I added printfs, and determined that the module_init() function
DOES get called the second time.  But a printf in the probe() routine
doesn't show up the second time.

Has there been a patch recently for this problem?

Thanks!

Dave Olien

