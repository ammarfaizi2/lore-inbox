Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131041AbQKUTTc>; Tue, 21 Nov 2000 14:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131040AbQKUTTW>; Tue, 21 Nov 2000 14:19:22 -0500
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:12438 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S129977AbQKUTTM>; Tue, 21 Nov 2000 14:19:12 -0500
Date: Tue, 21 Nov 2000 19:40:23 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Johannes Erdfelt <johannes@erdfelt.com>,
        Ingo Molnar <mingo@chiara.elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.0test11-ac1
In-Reply-To: <E13yICI-000504-00@the-village.bc.nu>
Message-ID: <Pine.GSO.3.96.1001121193320.28403C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2000, Alan Cox wrote:

> Its completely unsafe. The CPU in question is NOT intel. It has no APIC
> instead you poke around randomly in MMIO space and the box dies. You have
> to check the cpu capabilities too

 Well, does any SMP board map anything into the local APIC space?  After
saying there a real APIC there???  Now *THAT* is completely unsafe.  How
is that supposed to work when there actually is an APIC-equipped CPU put
in?

 Poking unoccupied space leads to bus error exceptions for certain archs
but I can't actually recall existence of such events for i386... 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
