Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261873AbTH0ShX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 14:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261926AbTH0ShX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 14:37:23 -0400
Received: from mailwasher.lanl.gov ([192.16.0.25]:3281 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S261873AbTH0ShW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 14:37:22 -0400
Subject: Re: 2.6.0-test4-mm2
From: Steven Cole <elenstev@mesatop.com>
To: Christian Axelsson <smiler@lanil.mine.nu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, Hans Reiser <reiser@namesys.com>
In-Reply-To: <3F4CAB0B.2030705@lanil.mine.nu>
References: <20030826221053.25aaa78f.akpm@osdl.org>
	 <3F4CAB0B.2030705@lanil.mine.nu>
Content-Type: text/plain
Organization: 
Message-Id: <1061999696.1670.66.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 27 Aug 2003 09:54:56 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-08-27 at 06:58, Christian Axelsson wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Is there any work beeing done on getting reiser4 into mm?
> I havent tried it myself yet but Ive heard of colliding code in scheduler.

There are some rejects when applying yesterday's reiser4 snapshot.

[steven@spc9 linux-2.6.0-test4-mm2]$ patch -p1 <../reiser4.diff
patching file arch/i386/kernel/entry.S
Hunk #1 FAILED at 879.
1 out of 1 hunk FAILED -- saving rejects to file arch/i386/kernel/entry.S.rej
patching file fs/Kconfig
patching file fs/Makefile
patching file fs/buffer.c
Hunk #1 succeeded at 262 (offset 23 lines).
patching file fs/fs-writeback.c
patching file fs/inode.c
patching file fs/jbd/transaction.c
patching file fs/sysfs/inode.c
patching file include/asm-i386/unistd.h
Hunk #1 FAILED at 278.
Hunk #2 succeeded at 398 (offset 2 lines).
1 out of 2 hunks FAILED -- saving rejects to file include/asm-i386/unistd.h.rej
patching file include/linux/fs.h
Hunk #2 succeeded at 871 (offset 15 lines).
Hunk #3 succeeded at 1249 (offset 21 lines).
patching file include/linux/init_task.h
Hunk #1 FAILED at 107.
1 out of 1 hunk FAILED -- saving rejects to file include/linux/init_task.h.rej
patching file include/linux/jbd.h
patching file include/linux/mm.h
patching file include/linux/sched.h
Hunk #1 succeeded at 307 (offset 3 lines).
Hunk #2 succeeded at 469 (offset 6 lines).
patching file include/linux/writeback.h
patching file kernel/ksyms.c

The rest of the reiser4.diff applied OK from this point.

Getting reiser4 into mm might be helpful.

Steven


