Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132686AbRDUPcR>; Sat, 21 Apr 2001 11:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132690AbRDUPcI>; Sat, 21 Apr 2001 11:32:08 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:61451 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132686AbRDUPb7>; Sat, 21 Apr 2001 11:31:59 -0400
Subject: Re: [BUG] lvm beta7 and ac11 problems
To: tomlins@cam.org (Ed Tomlinson)
Date: Sat, 21 Apr 2001 16:33:41 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, linux-openlvm@nl.linux.org,
        linux-lvm@sistina.com, alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <01042110002200.00707@oscar> from "Ed Tomlinson" at Apr 21, 2001 10:00:22 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14qzOK-0003qE-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> building a kernel with 2.4.3-ac11 and lvm beta7 + vfs_locking_patch-2.4.2 yields:
> 
> oscar# depmod -ae 2.4.3-ac11 
> depmod: *** Unresolved symbols in /lib/modules/2.4.3-ac11/kernel/drivers/md/lvm-mod.o
> depmod:         get_hardblocksize
> 
> ideas?

get_hardblock_size has been removed. Take a look at the fs parts of the
ac10->11 diff and you'll see the trivial fixup you need to add

