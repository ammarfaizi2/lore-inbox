Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131394AbQKCTiL>; Fri, 3 Nov 2000 14:38:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131492AbQKCTiB>; Fri, 3 Nov 2000 14:38:01 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:21776 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S131394AbQKCThr>; Fri, 3 Nov 2000 14:37:47 -0500
Date: Fri, 3 Nov 2000 20:37:43 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Josue Emmanuel Amaro <Josue.Amaro@oracle.com>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Value of TASK_UNMAPPED_SIZE on 2.4
Message-ID: <20001103203743.E15284@athlon.random>
In-Reply-To: <3A030EE2.92DC3F2@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A030EE2.92DC3F2@oracle.com>; from Josue.Amaro@oracle.com on Fri, Nov 03, 2000 at 11:15:46AM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2000 at 11:15:46AM -0800, Josue Emmanuel Amaro wrote:
> (page.h).  This works out to be a value of 0x4000000.
						      ^ one more zero here
> Are there any negative side effects in defining TASK_UNMAPPED_SIZE to 0x1000000?

I guess you mean 0x10000000. There's no risk in doing that. I also did another
patch that moves the kernel away and allows 3.5G per process on IA32 via plain
mmap or shmat, but it has the downside of reducing a lot the ZONE_NORMAL where
on IA32 buffercache and skb still lives.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
