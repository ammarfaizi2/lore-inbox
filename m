Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262327AbVCPKQV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262327AbVCPKQV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 05:16:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262324AbVCPKQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 05:16:21 -0500
Received: from smtp10.wanadoo.fr ([193.252.22.21]:43664 "EHLO
	smtp10.wanadoo.fr") by vger.kernel.org with ESMTP id S262331AbVCPKPy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 05:15:54 -0500
X-ME-UUID: 20050316101551257.3EC4C24000A2@mwinf1002.wanadoo.fr
Subject: Re: Documentation/i386/IO-APIC.txt (Re: 2.6.11 USB broken on VIA
	computer (not just ACPI))
From: Xavier Bestel <xavier.bestel@free.fr>
To: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Cc: "Robert W. Fuller" <orangemagicbus@sbcglobal.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1110967201.20838.221.camel@gonzales>
References: <4237A5C1.5030709@sbcglobal.net>
	 <20050315203914.223771b2.akpm@osdl.org> <4237C40C.6090903@sbcglobal.net>
	 <20050315213110.75ad9fd5.akpm@osdl.org> <4237C61A.6040501@sbcglobal.net>
	 <20050315215447.7975a0ff.akpm@osdl.org>
	 <1110967201.20838.221.camel@gonzales>
Content-Type: text/plain; charset=UTF-8
Date: Wed, 16 Mar 2005 11:08:12 +0100
Message-Id: <1110967692.20838.224.camel@gonzales>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le mercredi 16 mars 2005 à 11:00 +0100, Xavier Bestel a écrit :
> Le mardi 15 mars 2005 à 21:54 -0800, Andrew Morton a écrit :
> > You may be able to set the thing up by hand with the help of
> > Documentation/i386/IO-APIC.txt.
> 
> There's something I don't get in this document's ascii-art:
> 
> 8<------------------------------------------------------------------
>                ,-.        ,-.        ,-.        ,-.        ,-.
>      PIRQ4 ----| |-.    ,-| |-.    ,-| |-.    ,-| |--------| |
>                |S|  \  /  |S|  \  /  |S|  \  /  |S|        |S|
>      PIRQ3 ----|l|-. `/---|l|-. `/---|l|-. `/---|l|--------|l|
>                |o|  \/    |o|  \/    |o|  \/    |o|        |o|
>      PIRQ2 ----|t|-./`----|t|-./`----|t|-./`----|t|--------|t|
>                |1| /\     |2| /\     |3| /\     |4|        |5|
>      PIRQ1 ----| |-  `----| |-  `----| |-  `----| |--------| |
>                `-'        `-'        `-'        `-'        `-'
> 
> every PCI card emits a PCI IRQ, which can be INTA,INTB,INTC,INTD:
> 
>                                ,-.
>                          INTD--| |
>                                |S|
>                          INTC--|l|
>                                |o|
>                          INTB--|t|
>                                |x|
>                          INTA--| |
>                                `-'
> 
> These INTA-D PCI IRQs are always 'local to the card', their real meaning
> depends on which slot they are in. If you look at the daisy chaining diagram,
> a card in slot4, issuing INTA IRQ, it will end up as a signal on PIRQ2 of
> the PCI chipset. [...]
> 8<------------------------------------------------------------------
> 
> If I follow the wire from Slot4's INTA, I'm ending on PIRQ4 whereas the
> doc says IRQ2. Do I need glasses, or a new fixed-font ?

Sorry for replying to myself, in fact it seems like somebody reversed
the order of PIRQ[1-4] and INT[A-D] in the ascii-art, but didn't touch
the rest of the text at all. There are several more references to a
"reversed order".

	Xav


