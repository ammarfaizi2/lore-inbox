Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129413AbQKGVH3>; Tue, 7 Nov 2000 16:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129363AbQKGVHJ>; Tue, 7 Nov 2000 16:07:09 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:54283 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129308AbQKGVHD> convert rfc822-to-8bit; Tue, 7 Nov 2000 16:07:03 -0500
Date: Tue, 7 Nov 2000 13:06:27 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: test11-pre1
Message-ID: <Pine.LNX.4.10.10011071301580.6012-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by deepthought.transmeta.com id NAA09655
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Mostly driver updates.

With a few notable exceptions: two rather subtle MM race conditions that
happened with SMP and highmem respectively. And the FXCSR and file locking
that was already discussed on the list.

		Linus

-----

 - pre1:
    - me: make PCMCIA work even in the absense of PCI irq's
    - me: add irq mapping capabilities for Cyrix southbridges
    - me: make IBMMCA compile right as a module
    - me: uhhuh. Major atomic-PTE SMP race boo-boo. Fixed.
    - Andrea Arkangeli: don't allow people to set security-conscious
      bits in mxcsr through ptrace SETFPXREGS.
    - Jürgen Fischer: aha152x update
    - Andrew Morton, Trond Myklebust: file locking fixes
    - me: TLB invalidate race with highmem
    - Paul Fulghum: synclink/n_hdlc driver updates
    - David Miller: export sysctl_jiffies, and have the proper no-sysctl
      version handy
    - Neil Brown: RAID driver deadlock and nsfd read access to
      execute-only files fix
    - Keith Owens: clean up module information passing, remove
      "get_module_symbol()".
    - Jeff Garzik: network (and other) driver fixes and cleanups
    - Andrea Arkangeli: scheduler cleanup.
    - Ching-Ling Li: fix ALi sound driver memory leak
    - Anton Altaparmakov: upcase fix for NTFS
    - Thomas Woller: CS4281 audio update

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
