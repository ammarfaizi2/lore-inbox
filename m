Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131039AbQKIO3P>; Thu, 9 Nov 2000 09:29:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131041AbQKIO2y>; Thu, 9 Nov 2000 09:28:54 -0500
Received: from TSX-PRIME.MIT.EDU ([18.86.0.76]:28816 "HELO tsx-prime.MIT.EDU")
	by vger.kernel.org with SMTP id <S130286AbQKIO2i>;
	Thu, 9 Nov 2000 09:28:38 -0500
Date: Thu, 9 Nov 2000 09:28:37 -0500
Message-Id: <200011091428.JAA21928@tsx-prime.MIT.EDU>
From: "Theodore Y. Ts'o" <tytso@MIT.EDU>
To: Michael Rothwell <rothwell@holly-springs.nc.us>
CC: richardj_moore@uk.ibm.com, linux-kernel@vger.kernel.org
In-Reply-To: Michael Rothwell's message of Wed, 08 Nov 2000 16:35:33 -0500,
	<3A09C725.6CFA0EE2@holly-springs.nc.us>
Subject: Re: [ANNOUNCE] Generalised Kernel Hooks Interface (GKHI)
Phone: (781) 391-3464
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: 	Wed, 08 Nov 2000 16:35:33 -0500
   From: Michael Rothwell <rothwell@holly-springs.nc.us>

   Sounds great; unfortunately, the core group has spoken out against a
   modular kernel.

This is true; that's because a modular kernel means that interfaces have
to be frozen in time, usually forever.  This makes a lot of improvements
impossible, and over time there is more and more crud added to simply
act as "impedance matching" between incompatible/legacy interfaces.

However, that doesn't mean that the GKHI is *automatically* bad.  It all
depends on how you use it.  Just as with kernel modules, where it's
darned useful for distributions so they don't have to build custom
kernels for each installation (but source is included for all modules),
the GKHI could be used in a similar way. 

The issue will be with what hooks are allowed to be exported via
the GKHI; this defines the interfaces.  Also, it's important to note
which interfaces are and aren't guaranteed to be stable.  If the
interfaces aren't guaranteed to be stable, then incompatibilities and
keeping up with the latest version are a problem for the provider of the
binary module, not of the Linux Kernel Development Community.

						- Ted
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
