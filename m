Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287946AbSAHMOl>; Tue, 8 Jan 2002 07:14:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287976AbSAHMOc>; Tue, 8 Jan 2002 07:14:32 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:40601 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S287946AbSAHMOX>; Tue, 8 Jan 2002 07:14:23 -0500
Date: Tue, 8 Jan 2002 13:12:04 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Chris Wedgwood <cw@f00f.org>,
        swsnyder@home.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: "APIC error on CPUx" - what does this mean?
In-Reply-To: <E3B8D7A16F6@vcnet.vc.cvut.cz>
Message-ID: <Pine.GSO.3.96.1020108130224.28906B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jan 2002, Petr Vandrovec wrote:

> No. It is fully-VIA motherboard (Asus A7V), VIA KT133 as a northbridge 
> and VIA686A as a southbridge, with 1GHz Athlon. And spurious IRQ happen 
> when either of (massive) IRQ sources (Promise UDMA, tulip-based network 
> card, an es137x soundcard) emits interrupts.

 A possible reason is the 8259A in the chipset deasserts its INT output
late enough for the Athlon CPU's local APIC to register another ExtINTA
interrupt sometimes, possibly under specific circumstances.  If that's
true, either the chipset or the APIC (or both) is at fault for not meeting
the specs.  It causes no system stability problem but there is a
performance hit due to these spurious interrupts. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

