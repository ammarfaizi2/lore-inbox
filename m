Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129231AbQKXOwz>; Fri, 24 Nov 2000 09:52:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129091AbQKXOwp>; Fri, 24 Nov 2000 09:52:45 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:29530 "EHLO
        penguin.e-mind.com") by vger.kernel.org with ESMTP
        id <S129325AbQKXOwc>; Fri, 24 Nov 2000 09:52:32 -0500
Date: Fri, 24 Nov 2000 15:21:53 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "H . J . Lu" <hjl@valinux.com>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: lseek patch for 2.2.18pre23
Message-ID: <20001124152153.A23297@athlon.random>
In-Reply-To: <20001123221524.A32154@valinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20001123221524.A32154@valinux.com>; from hjl@valinux.com on Thu, Nov 23, 2000 at 10:15:24PM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2000 at 10:15:24PM -0800, H . J . Lu wrote:
> 2.2.18pre23 allows lseek to negative offsets in ext2 and has no checks
> for proc. Here is a patch.

As just said your patch is wrong for vanilla 2.2.18pre23.

The right fix for that problem in 2.2.18pre23 (2.2.x vanilla doesn't include
LFS) is here:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.2/2.2.18pre22/lseek-2g-ext2-1

I also uploaded separately your right fix for /dev/mem:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.2/2.2.18pre22/lseek-2g-mem-hjl-1 (this one is 

and this the right fix for the largefile handling in ext2:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.2/2.2.18pre22/notify-change-2g-ext2-1

All three should be applied to 2.2.18pre-latest.

And in LFS (that means also 2.4.x) the >> 32 doesn't make any sense in lseek
and should be removed:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.4/2.4.0-test11-pre6/ext2-lseek-cleanup-1

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
