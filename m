Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265483AbUFSKoU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265483AbUFSKoU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 06:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265487AbUFSKoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 06:44:20 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:62988 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S265483AbUFSKoS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 06:44:18 -0400
Date: Sat, 19 Jun 2004 20:44:07 +1000
To: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: mtime in the future
Message-ID: <20040619104407.GA1266@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus:

It would be nice to have the BK mtime on these files fixed:

$ find . -mtime -0 | xargs ls -l
-rw-r--r--    2 herbert  greathan    11264 Oct  7  2004 ./drivers/base/class.c
-rw-r--r--    2 herbert  greathan    10639 Apr 29  2021 ./drivers/pci/hotplug/rpaphp_pci.c
-rw-r--r--    2 herbert  greathan     5076 Apr 29  2021 ./drivers/pci/hotplug/rpaphp_slot.c
-rw-r--r--    2 herbert  greathan     3292 Apr 29  2021 ./drivers/pci/hotplug/rpaphp_vio.c
-rw-r--r--    2 herbert  greathan     6204 Oct  7  2004 ./include/linux/kobject.h
-rw-r--r--    2 herbert  greathan    13737 Oct  7  2004 ./lib/kobject.c
$

Some tools get quite confused by these things.

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
