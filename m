Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272822AbRIPVnP>; Sun, 16 Sep 2001 17:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272843AbRIPVnF>; Sun, 16 Sep 2001 17:43:05 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:58892 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S272822AbRIPVmu>;
	Sun, 16 Sep 2001 17:42:50 -0400
Date: Sun, 16 Sep 2001 23:43:07 +0200
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: arjanv@redhat.com, "David S. Miller" <davem@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: [patch] block highmem zero bounce v14
Message-ID: <20010916234307.A12270@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've uploaded a new version of the patch that allows direct I/O to
highmem memory without resorting to bouncing to lower memory. Changes
since last time include:

- Sync pci64-2.4.10p4 with davem (me)

- Fix megaraid virt_to_bus on pci_alloc_consistent (!) (Arjan)

- Fix ide-dma not doing the right thing with private bh submissions that
  aren't necessarily b_page based (me)

- Fix ide-scsi scatter-gather highmem (me)

- Fix IDE+SCSI highmem enable bug (me)

- Limit I/O highmem enable messages a bit (me)

It's against 2.4.10-pre9 and can be found right here:

*.kernel.org/pub/linux/kernel/people/axboe/patches/2.4.10-pre9/block-highmem-all-14

-- 
Jens Axboe

