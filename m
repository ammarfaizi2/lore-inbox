Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129521AbQKVRXn>; Wed, 22 Nov 2000 12:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130800AbQKVRXe>; Wed, 22 Nov 2000 12:23:34 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:39528 "EHLO
        the-village.bc.nu") by vger.kernel.org with ESMTP
        id <S129521AbQKVRXY>; Wed, 22 Nov 2000 12:23:24 -0500
Subject: Re: Linux 2.4.0test11-ac1
To: macro@ds2.pg.gda.pl (Maciej W. Rozycki)
Date: Wed, 22 Nov 2000 16:47:31 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), hpa@zytor.com (H. Peter Anvin),
        mingo@chiara.elte.hu (Ingo Molnar), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.3.96.1001122160510.24845A-100000@delta.ds2.pg.gda.pl> from "Maciej W. Rozycki" at Nov 22, 2000 04:48:23 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13yd3V-0006BD-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> APICs (probably due to the fact there was no standalone I/O APIC chip
> available at that time) so CPUs report no APIC flag.  And it starts in the
> PIC mode as opposed to the Virtual Wire.  I may send you his bootstrap log
> if you want to (but not today -- I don't have it handy). 

Ok. That means my check is over zealous. 

>  Could you please tell me what these broken boards report in MP-tables
> when there is no APIC?  Maybe we could find a way to distinguish them. 
> All 82489DX-based boards I've met report 0x1 as the APIC revision (I don't
> think there are higher 82489DX revisions). 

I think it reports 1.1 apics from memory. Its simply hardcoded in the bios
rather than the configurable flash area.

The following change should make all of this work

	if(vendor!=INTEL && !has_apic)
		/* No SMP */



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
