Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271697AbRIYS52>; Tue, 25 Sep 2001 14:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272265AbRIYS5S>; Tue, 25 Sep 2001 14:57:18 -0400
Received: from magic.adaptec.com ([208.236.45.80]:62120 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP
	id <S271697AbRIYS5H>; Tue, 25 Sep 2001 14:57:07 -0400
Message-ID: <50DB155AD0CED411988E009027D61DB324D507@otcexc01.otc.adaptec.com>
From: "Bonds, Deanna" <Deanna_Bonds@adaptec.com>
To: "'Brian Strand'" <bstrand@switchmanagement.com>,
        linux-kernel@vger.kernel.org
Subject: RE: 3c59x + dpti2o problem with interrupt sharing?
Date: Tue, 25 Sep 2001 14:57:24 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Looking in /proc/interrupts, I noticed that eth0 and dpti 
> were sharing 
> an IRQ.  Is this the likely cause of the network failure, and if so, 
> does anyone know of a way to get the PCI BIOS to assign 
> separate IRQs to 

> A related question is:  should these drivers be able to share 
> IRQs, i.e. 
> is it a worthwhile goal to have them operate reliably while sharing 
> IRQs, or is IRQ-sharing a performance loss and something to 
> be avoided?

The Adaptec card can share interrupts, but it is not wise to do that with
another card that is going to be a high priority interrupt.  You most likely
need to change the motherboard bios settings.  If you are not using your
onboard IDE you can disable that freeing up another high priority interrupt.
Otherwise you can manually assign the interrupts through the bios.

Deanna

