Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129716AbQL1TK1>; Thu, 28 Dec 2000 14:10:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129752AbQL1TKR>; Thu, 28 Dec 2000 14:10:17 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:51935 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S129716AbQL1TKF>;
	Thu, 28 Dec 2000 14:10:05 -0500
Date: Thu, 28 Dec 2000 19:39:34 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200012281839.TAA20676@harpo.it.uu.se>
To: fpieraut@casi.polymtl.ca
Subject: Re: Activating APIC on single processor
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francis Pieraut wrote:

>I try to activate APIC interrruption on a single processor(PIII) with
>kernel2.4.0-test11.
>
>I activate APIC interruption with the configuration of linux kernel
>2.4.0test-11. In the linux kernel configuration under processor type and
>features I activate "APIC and IO-APIC support on uniprocessor",  and I
>desactivate "Symmetric multi-processing support". The only way I found to
>check APIC activation is looking into /proc/interrupts, no "IO-APIC" can
>be found there. So I read IO-APIC.txt and I suppose there sould be
>conflicts with IRQ of my PCI cards. So I remove all my PCI cards and still
>have no APIC interrupt. 
>Is there another way to check APIC activation? 
>Am-I doing to right things to activate IO-APIC?

CONFIG_X86_UP_IOAPIC only works if you actually have an IO-APIC
(the "and" in the description is strict), but most UP boards don't
have one. You should apply the UP-APIC patch, available at:

       http://www.csd.uu.se/~mikpe/linux/upapic/

/Mikael
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
