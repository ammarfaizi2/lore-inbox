Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129562AbRALS5R>; Fri, 12 Jan 2001 13:57:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130599AbRALS5H>; Fri, 12 Jan 2001 13:57:07 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:60213 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129562AbRALS4t>; Fri, 12 Jan 2001 13:56:49 -0500
Date: Fri, 12 Jan 2001 19:57:15 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.1-pre1 breaks XFree 4.0.2 and "w"
Message-ID: <20010112195715.A30496@athlon.random>
In-Reply-To: <Pine.LNX.4.10.10101120931520.1806-100000@penguin.transmeta.com> <E14H8PC-0004hZ-00@the-village.bc.nu> <93nipc$1vp$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93nipc$1vp$1@penguin.transmeta.com>; from torvalds@transmeta.com on Fri, Jan 12, 2001 at 10:35:24AM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 12, 2001 at 10:35:24AM -0800, Linus Torvalds wrote:
> Andreas argument was that earlier kernels weren't consistent, and as
> such we shouldn't even bother to try to make newer kernels consistent. 
> We would be better off reporting our internal inconsistencies the way
> earlier kernels did - the kernel would be confusing, but at least it
> would be consistently confusing ;)

The earlier kernels were 98% consistent in providing the "cpu_has" information
via /proc/cpuinfo that is true information too.

What I am suggesting is to fix the few places to make the /proc/cpuinfo 100%
consistent reporting "cpu_has", and to provide the "can_I_use" information in
another place (for example with /proc/osinfo or a new "osflags" row in
/proc/cpuinfo).

This way we are 100% consistent and we don't lose the "cpu_has" information.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
