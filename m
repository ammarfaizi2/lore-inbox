Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261190AbRE3Os3>; Wed, 30 May 2001 10:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261247AbRE3OsT>; Wed, 30 May 2001 10:48:19 -0400
Received: from [195.184.98.160] ([195.184.98.160]:14610 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261190AbRE3OsL>;
	Wed, 30 May 2001 10:48:11 -0400
Date: Wed, 30 May 2001 16:46:19 +0200
From: Jens Axboe <axboe@kernel.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Mark Hemment <markhe@veritas.com>
Subject: [patch] 4GB I/O, cut four
Message-ID: <20010530164619.H17136@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Changes in this release:

- Don't merge requests with ->special set. Not a highmem introduced bug.
  (discovered by Mark Hemment)

- __scsi_end_request didn't decrement hard_nr_sectors correctly. Not a
  highmem introduced bug. (discovered by Mark Hemment)

- Modular IDE/SCSI needs kmap_prot and kmap_pte exported (discovered by
  Arjan van de Ven)

- Add qlogicfc as highmem capable. Hopefully a merge of the newer
  version will carry this flag forward. (tested by Mark Hemment)

That means there is a new block-highmem-3 and scsi-high-3, the rest
remains the same. Get it all in block-highmem-all-4 if you want.

For 2.4.5:

*.kernel.org/pub/linux/kernel/people/axboe/patches/2.4.5/

or for 2.4.5-ac4 (just one big patch, sorry)

*.kernel.org/pub/linux/kernel/people/axboe/patches/2.4.5-ac4/

-- 
Jens Axboe

