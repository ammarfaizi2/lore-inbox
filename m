Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261196AbULMWJw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbULMWJw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 17:09:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261197AbULMWJw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 17:09:52 -0500
Received: from h142-az.mvista.com ([65.200.49.142]:25240 "HELO
	xyzzy.farnsworth.org") by vger.kernel.org with SMTP id S261196AbULMWJu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 17:09:50 -0500
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Mon, 13 Dec 2004 15:09:49 -0700
To: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, Russell King <rmk@arm.linux.org.uk>,
       Manish Lachwani <mlachwani@mvista.com>,
       Brian Waite <brian@waitefamily.us>,
       "Steven J. Hill" <sjhill@realitydiluted.com>
Subject: [PATCH] mv643xx_eth support for platform device interface + more
Message-ID: <20041213220949.GA19609@xyzzy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In porting the mv643xx ethernet driver for use by PPC, I modified it
to use the platform device interface, fixed the hardware checksum support
and did some miscellaneous bug fixes and cleanups.

I'll follow up with these six patches:
	
 1 Remove redundant or useless code.
 2 Replace fixed count spins with waits on hardware status bits
 3 Fix code to enable hardware checksum generation for TX packets
 4 Convert from pci_map_* to dma_map_* interface
 5 Add support for platform device interface
 6 Add support for several configurable parameters via platform device

Of these patches, the only one that changes the driver interface is patch 5.

I don't have any MIPS hardware, so I'd appreciate testing by those who do.

I have some additional cleanups, but I want to get these in the queue
or at least get feedback first.

Thanks,
-Dale Farnsworth
