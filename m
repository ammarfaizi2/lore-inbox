Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131142AbQKKPiS>; Sat, 11 Nov 2000 10:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131141AbQKKPiI>; Sat, 11 Nov 2000 10:38:08 -0500
Received: from Cantor.suse.de ([194.112.123.193]:44298 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S130891AbQKKPhv>;
	Sat, 11 Nov 2000 10:37:51 -0500
Date: Sat, 11 Nov 2000 16:32:04 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Michael Meissner <meissner@spectacle-pond.org>
Cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        George Anzinger <george@mvista.com>,
        "linux-kernel@vger.redhat.com" <linux-kernel@vger.kernel.org>
Subject: Re: Where is it written?
Message-ID: <20001111163204.B6367@inspiron.suse.de>
In-Reply-To: <20001110184031.A2704@munchkin.spectacle-pond.org> <200011110011.eAB0BbF244111@saturn.cs.uml.edu> <20001110192751.A2766@munchkin.spectacle-pond.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20001110192751.A2766@munchkin.spectacle-pond.org>; from meissner@spectacle-pond.org on Fri, Nov 10, 2000 at 07:27:51PM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2000 at 07:27:51PM -0500, Michael Meissner wrote:
> Don't get me wrong -- in my 25 years of compiler hacking, I've never seen an
> ABI that I was completely happy with, [..]

Ok, but I've seen only one that I'm completly unhappy with.  Can you think at
one case where it's better to push the parameter on the stack instead of
passing them through the callee clobbered ebx/eax/edx? Saving the pushes makes
a relevant performance difference (that's why we have FASTCALL in kernel to use
the sane calling convention even with the <2.95 gcc in fast paths).

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
