Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129660AbQKQS77>; Fri, 17 Nov 2000 13:59:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129270AbQKQS7t>; Fri, 17 Nov 2000 13:59:49 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:47156 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129220AbQKQS7n>; Fri, 17 Nov 2000 13:59:43 -0500
Date: Fri, 17 Nov 2000 19:28:34 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Christoph Rohland <cr@sap.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Tigran Aivazian <tigran@veritas.com>,
        Mikael Pettersson <mikpe@csd.uu.se>, Jordan <ledzep37@home.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Error in x86 CPU capabilities starting with test5/6
Message-ID: <20001117192834.A30047@athlon.random>
In-Reply-To: <E13wkLK-0000bP-00@the-village.bc.nu> <qwwpujuvk1s.fsf@sap.com> <20001117161833.A27098@athlon.random> <qwwaeaytwfa.fsf@sap.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qwwaeaytwfa.fsf@sap.com>; from cr@sap.com on Fri, Nov 17, 2000 at 05:06:49PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2000 at 05:06:49PM +0100, Christoph Rohland wrote:
> Could I get this for i686? :-)

If we break binary compatibility yes. I mean: new glibc binaries wouldn't
run anymore on older kernels. Also new static binaries wouldn't run
anymore on older kernels. At least if we don't introduce runtime
checks to guess if current kernel supports vsyscall or not (and if we do
that it means we're adding slow checks in an extremely fast path and that's
not what we want :).

As about the broken calling conventions of the IA32 ABI, I think it doesn't
worth to break the binary compatibility at this late stage.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
