Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129150AbQKVQ17>; Wed, 22 Nov 2000 11:27:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130355AbQKVQ1t>; Wed, 22 Nov 2000 11:27:49 -0500
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:64417 "EHLO
        delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
        id <S129150AbQKVQ1O>; Wed, 22 Nov 2000 11:27:14 -0500
Date: Wed, 22 Nov 2000 16:48:23 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@chiara.elte.hu>,
        linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.0test11-ac1
In-Reply-To: <E13yNmg-0005QD-00@the-village.bc.nu>
Message-ID: <Pine.GSO.3.96.1001122160510.24845A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2000, Alan Cox wrote:

> I know of no socket 7 board with an 82489DX, and no board on the planet which
> has 82489DX and works SMP with a non intel processor. I accept its a heuristic
> but so is the current behaviour, and the current heuristic isnt working for
> as many cases.

 Do you want me to contact you with a user of such a system?  A modular
server with the ability to put up to four P54C CPUs.  It uses 82489DX
APICs (probably due to the fact there was no standalone I/O APIC chip
available at that time) so CPUs report no APIC flag.  And it starts in the
PIC mode as opposed to the Virtual Wire.  I may send you his bootstrap log
if you want to (but not today -- I don't have it handy). 

 Needless to say, it handles the MP-table fine.

 Anyway I certainly do not negate the existence of broken boards (and Tyan
BIOSes seem to be among the worst ones).  I just insist on having a sane
way to detect a real APIC and I feel more likely to "punish" broken setups
than perfecly good ones.  These boards can run UP kernels with no problem,
can't they?  If so, then just tell their users not to use MP kernels.

 Could you please tell me what these broken boards report in MP-tables
when there is no APIC?  Maybe we could find a way to distinguish them. 
All 82489DX-based boards I've met report 0x1 as the APIC revision (I don't
think there are higher 82489DX revisions). 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
