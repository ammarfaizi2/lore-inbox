Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266422AbRGFLna>; Fri, 6 Jul 2001 07:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266428AbRGFLnU>; Fri, 6 Jul 2001 07:43:20 -0400
Received: from pizda.ninka.net ([216.101.162.242]:42216 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S266422AbRGFLnE>;
	Fri, 6 Jul 2001 07:43:04 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15173.42054.208635.41503@pizda.ninka.net>
Date: Fri, 6 Jul 2001 04:43:02 -0700 (PDT)
To: Cort Dougan <cort@fsmlabs.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Why Plan 9 C compilers don't have asm("")
In-Reply-To: <20010706023835.A5224@ftsoj.fsmlabs.com>
In-Reply-To: <200107040337.XAA00376@smarty.smart.net>
	<20010703233605.A1244@zalem.puupuu.org>
	<20010704002436.C1294@ftsoj.fsmlabs.com>
	<9hvjd4$1ok$1@penguin.transmeta.com>
	<20010706023835.A5224@ftsoj.fsmlabs.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Cort Dougan writes:
 > I'm talking about _modern_ processors, not processors that dominate the
 > modern age.  This isn't x86.

Linus mentioned Alpha specifically.  I don't see how any of the things
he said were x86-centric in any way shape or form.

All of his examples are entirely accurate on sparc64 for example, and
to even moreso his Alpha commentary can nearly directly be applied to
the MIPS.

Calls suck ass, even on modern cpus.  I've seen several hundreds of
cycles go out of the fault path by eliminating them.  If you can kill
a leaf level call, you can avoid saving the whole frame, and on Sparc
(for example) this means saving a potential window spill trap which
can be quite costly.

Calls are less simple than branches to do (via prediction etc.) at
"zero cost" because usually there is a write port necessary (to write
the call instruction's address into the "return" register).

Let's not even start talking about calls in PIC code :-)

Later,
David S. Miller
davem@redhat.com
