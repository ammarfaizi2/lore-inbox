Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131306AbQKTHrI>; Mon, 20 Nov 2000 02:47:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131355AbQKTHq6>; Mon, 20 Nov 2000 02:46:58 -0500
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:64129 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S131306AbQKTHqo>; Mon, 20 Nov 2000 02:46:44 -0500
Date: Mon, 20 Nov 2000 08:14:57 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Ingo Molnar <mingo@chiara.elte.hu>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.0-test11
In-Reply-To: <Pine.LNX.4.10.10011191815160.850-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.3.96.1001120080458.27021D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Nov 2000, Linus Torvalds wrote:

>     - Asit Mallick: enable the APIC in the official order

 What is this intended to fix?  Please revert it -- it breaks for i82489DX
APICs configured to the PIC mode upon boot -- local interrupt registers
are hardwired to 0x00010000 and cannot be changed when a local APIC is in
the software-disabled state (i.e. bit 8 of the spurious interrupt vector
register is cleared).  As a result no local interrupts get configured.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
