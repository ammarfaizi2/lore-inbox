Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131093AbQKUT1c>; Tue, 21 Nov 2000 14:27:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131118AbQKUT1W>; Tue, 21 Nov 2000 14:27:22 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:60750 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131093AbQKUT1S>; Tue, 21 Nov 2000 14:27:18 -0500
Subject: Re: Linux 2.4.0test11-ac1
To: macro@ds2.pg.gda.pl (Maciej W. Rozycki)
Date: Tue, 21 Nov 2000 18:49:14 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        johannes@erdfelt.com (Johannes Erdfelt),
        mingo@chiara.elte.hu (Ingo Molnar), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.3.96.1001121193320.28403C-100000@delta.ds2.pg.gda.pl> from "Maciej W. Rozycki" at Nov 21, 2000 07:40:23 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13yITj-00051Z-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  Well, does any SMP board map anything into the local APIC space?  After
> saying there a real APIC there???  Now *THAT* is completely unsafe.  How
> is that supposed to work when there actually is an APIC-equipped CPU put
> in?

Quite a few dual pentium socket 7 boards report dual cpu and apic in the 
MP table regardless of the capabilities of the CPU installed. Its apparently
legal to do so. There is an apic capability flag that should be tested before
making any assumptions about APIC availability on a processor.

And yes some boards crash otherwise.


Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
