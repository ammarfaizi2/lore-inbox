Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132020AbQL2Thw>; Fri, 29 Dec 2000 14:37:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132088AbQL2Thm>; Fri, 29 Dec 2000 14:37:42 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:57437 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S132020AbQL2The>; Fri, 29 Dec 2000 14:37:34 -0500
Date: Fri, 29 Dec 2000 20:06:57 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Petru Paler <ppetru@ppetru.net>, Jure Pecar <pegasus@telemach.net>,
        linux-kernel@vger.kernel.org, thttpd@bomb.acme.com
Subject: Re: linux 2.2.19pre and thttpd (VM-global problem?)
Message-ID: <20001229200657.B16261@athlon.random>
In-Reply-To: <20001229165340.C12791@athlon.random> <E14C4bd-0005bM-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E14C4bd-0005bM-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Dec 29, 2000 at 06:50:18PM +0000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 29, 2000 at 06:50:18PM +0000, Alan Cox wrote:
> Your cgi will keep the other CPU occupied, or run two of them. thttpd has
> superb scaling properties compared to say apache.

I think with 8 CPUs and 8 NICs (usual benchmark setup) you want more than 1 cpu
serving static data and it should be more efficient if it's threaded and
sleeping in accept() instead of running eight of them (starting from sharing
tlb entries and avoiding flushes probably without the need of CPU binding).

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
