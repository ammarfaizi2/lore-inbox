Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262407AbRE2OH0>; Tue, 29 May 2001 10:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262358AbRE2OHQ>; Tue, 29 May 2001 10:07:16 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:7435 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S262423AbRE2OHD>;
	Tue, 29 May 2001 10:07:03 -0400
Date: Tue, 29 May 2001 16:07:04 +0200
From: Jens Axboe <axboe@kernel.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [patch] 4GB I/O, cut three
Message-ID: <20010529160704.N26871@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Another day, another version.

Bugs fixed in this version: none
Known bugs in this version: none

In other words, it's perfect of course.

Changes:

- Added ide-dma segment coalescing
- Only print highmem I/O enable info when HIGHMEM is actually set

Please give it a test spin, especially if you have 1GB of RAM or more.
You should see something like this when booting:

hda: enabling highmem I/O
...
SCSI: channel 0, id 0: enabling highmem I/O

depending on drive configuration etc.

Plea to maintainers of the different architectures: could you please add
the arch parts to support this? This includes:

- memory zoning at init time
- page_to_bus
- pci_map_page / pci_unmap_page
- set_bh_sg
- KM_BH_IRQ (for HIGHMEM archs)

I think that's it, feel free to send me questions and (even better)
patches.

-- 
Jens Axboe

