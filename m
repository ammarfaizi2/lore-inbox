Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130115AbRBEKoP>; Mon, 5 Feb 2001 05:44:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129504AbRBEKoG>; Mon, 5 Feb 2001 05:44:06 -0500
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:16097 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S129912AbRBEKn5> convert rfc822-to-8bit; Mon, 5 Feb 2001 05:43:57 -0500
Date: Mon, 5 Feb 2001 11:32:59 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Gérard Roudier <groudier@club-internet.fr>
cc: Manfred Spraul <manfred@colorfullife.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Andrew Morton <andrewm@uow.edu.au>, Ingo Molnar <mingo@chiara.elte.hu>,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.0, 2.4.0-ac12: APIC lock-ups
In-Reply-To: <Pine.LNX.4.10.10102031117430.893-100000@linux.local>
Message-ID: <Pine.GSO.3.96.1010205112043.18067B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Feb 2001, [ISO-8859-1] Gérard Roudier wrote:

> Note that tampering the IO/APIC after initializations looks extremally
> ugly to me. In my opinion, only the local APIC was intended by Intel
> designers to be accessed by CPU after initialization (I may be wrong
> here).

 In "82489DX Datasheet" Intel explicitly points to masking and unmasking
an interrupt pin in an I/O APIC as one of three ways of controlling
incoming interrupts (other two being the Task Priority Register in a local
APIC and the IF flag in a CPU) at run time.  So far this is about the only
exhaustive APIC architecture description (a few further hints are also
present in "AP-388 82489DX User's Manual" but the datasheet is mostly a
superset).  I haven't seen any other APIC architecture description -- all
others are mostly register programming guidelines only.

 Neither of these documents are available online, AFAIK.  Last year I
asked Intel if providing electronic copies is possible, but they replied
it's not. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
