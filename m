Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130102AbRBIMOS>; Fri, 9 Feb 2001 07:14:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130485AbRBIMOI>; Fri, 9 Feb 2001 07:14:08 -0500
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:47785 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S130102AbRBIMN7>; Fri, 9 Feb 2001 07:13:59 -0500
Date: Fri, 9 Feb 2001 13:06:53 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: VANDROVE@vc.cvut.cz, linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: Re: [PATCH] Re: UP APIC reenabling vs. cpu type detection o
In-Reply-To: <200102082306.AAA13110@harpo.it.uu.se>
Message-ID: <Pine.GSO.3.96.1010209130201.4645D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Feb 2001, Mikael Pettersson wrote:

> (I had a theory about inspecting the APIC_LVTPC "Delivery Status"
> field, but unfortunately it doesn't seem to get set if a counter
> overflowed while LVTPC was masked. Perhaps it's because NMIs are
> edge-triggered.)

 The delivery status bit gets only set if an interrupt got accepted (that
implies it was unmasked at the moment) but its delivery is held pending
due to some reason.  It may happen when the target CPU has its interrupts
masked or the target local APIC cannot accept it due to a higher task
priority or no free slots.  The semantics of the bit is the same for both
local and I/O APIC interrupts.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
