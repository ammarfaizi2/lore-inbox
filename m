Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292944AbSB0VDm>; Wed, 27 Feb 2002 16:03:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292945AbSB0VDK>; Wed, 27 Feb 2002 16:03:10 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:38160 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292948AbSB0VCe>; Wed, 27 Feb 2002 16:02:34 -0500
Subject: Re: A7M266-D, dual athlon 1800+ kernel-smp APIC boot problem workaround
To: dettrick@uci.edu (Sean DETTRICK)
Date: Wed, 27 Feb 2002 21:17:15 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, dettrick@uci.edu, support@asus.com,
        euro.cpu@amd.com
In-Reply-To: <Pine.GSO.4.44.0202271124590.22391-100000@e4e.oac.uci.edu> from "Sean DETTRICK" at Feb 27, 2002 12:12:37 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16gBRr-0005sg-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We have an Asus A7M266-D motherboard with dual Athlon MP 1800+.
> We found the linux kernel-smp would seize shortly after or during booting
> the second CPU, at around the time it was testing APIC.

Yes - the MP 1.4 table seems to have funnies with the second IDE controller

> We found that booting with the "noapic" option in grub or lilo was
> sufficient to solve the problem.

Better yet set MP 1.1 in the BIOS - the MP1.1 table seems to work

> AMD and ASUS tech support had never heard of this problem.
> ASUS suggested it "might" be the BIOS.

AMD have heard of the problem. I've got it filed with them along with
	Won't boot with a broadcom card in
	Seems to misconfigure PCI compliance sometimes

and some other oddments. Support I suspect are not too used to it.

> BTW the Athlons, clearly marked in the boxes as MP, identified
> themselves as Athlon XP 1800+'s.   We thought this might be the
> problem at first but now we guess not.

The BIOS forgets to load the MP name string, like a load of other
problems it has. 

Alan
