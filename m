Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129700AbQKUTDL>; Tue, 21 Nov 2000 14:03:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130701AbQKUTCv>; Tue, 21 Nov 2000 14:02:51 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:11597 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129747AbQKUTCj>; Tue, 21 Nov 2000 14:02:39 -0500
Subject: Re: Linux 2.4.0test11-ac1
To: macro@ds2.pg.gda.pl (Maciej W. Rozycki)
Date: Tue, 21 Nov 2000 18:31:13 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        johannes@erdfelt.com (Johannes Erdfelt), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.3.96.1001121192317.28403B-100000@delta.ds2.pg.gda.pl> from "Maciej W. Rozycki" at Nov 21, 2000 07:25:30 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13yICI-000504-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > o	Dont crash on boot with a dual cpu board holding a non intel cpu
> > > Is this the patch to check for the Local APIC?
> > Yep
> 
>  Hmm, that's weird -- the check is already there for some time -- see
> verify_local_APIC().  It works and it's reliable even for the 82489DX.

Its completely unsafe. The CPU in question is NOT intel. It has no APIC
instead you poke around randomly in MMIO space and the box dies. You have
to check the cpu capabilities too

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
