Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135450AbRAQVeZ>; Wed, 17 Jan 2001 16:34:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131527AbRAQVeQ>; Wed, 17 Jan 2001 16:34:16 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:65031 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S135450AbRAQVeC>; Wed, 17 Jan 2001 16:34:02 -0500
Date: Wed, 17 Jan 2001 13:33:42 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Petr Matula <pem@informatics.muni.cz>
cc: "Dunlap, Randy" <randy.dunlap@intel.com>,
        MOLNAR Ingo <mingo@chiara.elte.hu>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: int. assignment on SMP + ServerWorks chipset
In-Reply-To: <20010117185047.A13171968@aisa.fi.muni.cz>
Message-ID: <Pine.LNX.4.10.10101171332420.10151-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 17 Jan 2001, Petr Matula wrote:
> 
> I did the changes above to 2.4.0 source. 

Did you also remove the two lines that disabled pirq routing if an IO-APIC
was enabled?

> Kernel with these changes can't detect my SCSI drive. It prints these messages 
> in cycle:

Which SCSI adapter is this? It may be that you have one of the drivers
that does not do "pci_enable_dev()" at initialization time..

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
