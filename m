Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271864AbRIDAUH>; Mon, 3 Sep 2001 20:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271863AbRIDAT6>; Mon, 3 Sep 2001 20:19:58 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:34018 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S271864AbRIDATk>; Mon, 3 Sep 2001 20:19:40 -0400
Date: Mon, 3 Sep 2001 20:20:00 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200109040020.f840K0e00860@devserv.devel.redhat.com>
To: adam@yggdrasil.com, linux-kernel@vger.kernel.org
Subject: Re: pci_alloc_consistent for small allocations?
In-Reply-To: <mailman.999443581.14164.linux-kernel2news@redhat.com>
In-Reply-To: <mailman.999443581.14164.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	In looking at the ieee1394 OHCI driver, I noticed that it
> appears to make 104 calls to pci_alloc_consistent for data structures
> that are 16 or 64 bytes.  Currently, on x86, pci_alloc_consistent
> allocates at least one full page per call, so it looks like the
> ohci1394 driver allocates 416kB per controller as a result of these
> data structures.

Sounds you are looking at a very obsolete codebase -or-
something backed out pci_pool_alloc()/pci_pool_free()
from the recent kernel...

If you can reproduce this on 2.4.8, send me a note
with detailed description of whatever you were doing
to get your number 104, I'll fix or disspel it.

-- Pete
