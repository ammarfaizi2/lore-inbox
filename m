Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129030AbQKLLaE>; Sun, 12 Nov 2000 06:30:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129103AbQKLL3z>; Sun, 12 Nov 2000 06:29:55 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:53345 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129030AbQKLL3k>; Sun, 12 Nov 2000 06:29:40 -0500
Date: Sun, 12 Nov 2000 12:29:10 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>,
        Tigran Aivazian <tigran@veritas.com>,
        "H. Peter Anvin" <hpa@transmeta.com>, Max Inux <maxinux@bigfoot.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: bzImage ~ 900K with i386 test11-pre2
Message-ID: <20001112122910.A2366@athlon.random>
In-Reply-To: <Pine.LNX.4.21.0011111644110.1036-100000@saturn.homenet> <m1ofzmcne5.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1ofzmcne5.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Sat, Nov 11, 2000 at 12:35:46PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 11, 2000 at 12:35:46PM -0700, Eric W. Biederman wrote:
> With respect to .bss issues we should clear it before we set up page tables.

We could sure do that but that's a minor win since we still need a
large mapping (more than 1 pagetable) for the bootmem allocator. (and we need
at least 1 pagetable setup as ident mapping at 0x100000 for the instruction
where we enable paging)

> We also do stupid things like set segment registers before setting up
> a GDT.  Yes we set them in setup.S but it is still a stupid non-obvious
		     ^^^^
I think you meant: we set "it" (gdt_48) up.

> dependency.  We we can do it in setup.S

I removed that dependency in x86-64.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
