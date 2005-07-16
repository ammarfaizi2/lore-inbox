Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261647AbVGPVja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261647AbVGPVja (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 17:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261791AbVGPVja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 17:39:30 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:30477 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261647AbVGPViS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 17:38:18 -0400
Date: Sat, 16 Jul 2005 23:38:12 +0200
From: Willy TARREAU <willy@w.ods.org>
To: linux-kernel@vger.kernel.org
Cc: Grant Coady <x0x0x@dodo.com.au>, Julien TINNES <julien@cr0.org>
Subject: [2.4 hotfix] Linux-2.4.31-hf2, Linux-2.4.30-hf5, Linux-2.4.29-hf12
Message-ID: <20050716213812.GA16339@pcw.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is a new 2.4 hotfix. Nothing alarming, though.

I reverted the netlink socket hashing bug fix that I took from
Davem's tree and introduced in 2.4.31-hf1 because Marcelo informed
me that Davem says it's broken and a better fix is needed.

It was also a right moment to merge Julien Tinnes' NULL dereference
patches for serial drivers. Strictly speaking, those missing checks
do not seem immediately exploitable, but a more complete audit of the
callers would be necessary to prove that. And it is clearly possible
that external patches expect those functions to do the check themselves.

Older kernels 2.4.29 and 2.4.30 are still maintained because they're still
downloaded (for reference, 2.4.29-hf11=10%, 2.4.30-hf4=6%, 2.4.31-hf1=84%).

Please find the changelog appended to this mail. Incremental patches
and tarballs for 2.4.29-hf12, 2.4.30-hf5 and 2.4.31-hf2 are available
from the usual place :

   http://linux.exosec.net/kernel/2.4-hf/

I've only built 2.4.31-hf2 with all modules enabled to ensure that patches
were correct. Grant Coady regularly builds, and runs recent updates and
reports results here :

   http://scatter.mine.nu/linux-2.4-hotfix/

Regards,
Willy

---

Changelog From 2.4.31-hf1 to 2.4.31-hf2 (semi-automated)
---------------------------------------
'+' = added ; '-' = removed

- 2.4.31-sparc64-solaris-emu-check-cmsg-len-1                 (David S. Miller)

  David told Marcelo this patch was not correct and that a better fix will
  follow later.

+ 2.4.31-null-deref-cyclades-1                                  (Julien Tinnes)

  Fix two potential NULL dereferences in drivers/char/cyclades.c

+ 2.4.31-null-deref-esp-1                                       (Julien Tinnes)

  Fix two potential NULL dereferences in drivers/char/esp.c

+ 2.4.31-null-deref-isicom-1                                    (Julien Tinnes)

  Fix two potential NULL dereferences in drivers/char/isicom.c

+ 2.4.31-null-deref-mxser-1                                     (Julien Tinnes)

  Fix two potential NULL dereferences in drivers/char/mxser.c

+ 2.4.31-null-deref-riscom8-1                                   (Julien Tinnes)

  Fix two potential NULL dereferences in drivers/char/riscom8.c

+ 2.4.31-null-deref-specialix-1                                 (Julien Tinnes)

  Fix two potential NULL dereferences in drivers/char/specialix.c

---

