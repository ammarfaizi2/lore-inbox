Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129370AbQLSRhy>; Tue, 19 Dec 2000 12:37:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129535AbQLSRho>; Tue, 19 Dec 2000 12:37:44 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:14095 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S129370AbQLSRh3>;
	Tue, 19 Dec 2000 12:37:29 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Tue, 19 Dec 2000 18:03:22 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Startup IPI (was: Re: test13-pre3)
CC: macro@ds2.pg.gda.pl (Maciej W. Rozycki),
        linux-kernel@vger.kernel.org (Kernel Mailing List),
        mingo@chiara.elte.hu
X-mailer: Pegasus Mail v3.40
Message-ID: <1020BC8D12AC@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Dec 00 at 23:51, Alan Cox wrote:

> > Yeah. Just do not read video memory when another CPU starts. I'll try
> > disabling cache on both CPUs, maybe it will make some difference, as
> > secondary CPU should start with caches disabled. But maybe that it is 
> > just broken AGP bus, and nothing else. But until I find what's really
> > broken on my hardware, I'd like to leave 'udelay(300)' in.
> 
> In the case where it boots does it also report mismatched MTRRs ??

Yes, it complains. But BIOS correctly reports x1/x2 depending on
number of CPUs I plug into motherboard, so I believe that it did
some initialization before it start loading OS.

calibrating APIC timer ...
..... CPU clock speed is 797.0452 MHz.
..... host bus clock speed is 99.6305 MHz.
cpu: 0, clocks: 996305, slice: 332101
CPU0<T0:996304,T1:664192,D:11,S:332101,C:996305>
cpu: 1, clocks: 996305, slice: 332101
CPU1<T0:996304,T1:332096,D:6,S:332101,C:996305>
checking TSC synchronization across CPUs: passed.
Setting commenced=1, go go go
mtrr: your CPUs had inconsistent variable MTRR settings
mtrr: probably your BIOS does not setup all CPUs

                                            Best regards,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
