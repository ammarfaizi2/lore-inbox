Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289184AbSAGNRL>; Mon, 7 Jan 2002 08:17:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289186AbSAGNRB>; Mon, 7 Jan 2002 08:17:01 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:33540 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S289184AbSAGNQx>;
	Mon, 7 Jan 2002 08:16:53 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Chris Wedgwood <cw@f00f.org>
Date: Mon, 7 Jan 2002 14:16:28 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: "APIC error on CPUx" - what does this mean?
CC: swsnyder@home.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        alan@lxorguk.ukuu.org.uk
X-mailer: Pegasus Mail v3.40
Message-ID: <E37DB7922B4@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  8 Jan 02 at 2:08, Chris Wedgwood wrote:
> On Mon, Jan 07, 2002 at 01:29:42PM +0100, Petr Vandrovec wrote:
> 
>     They are spurious IRQ 7, just message is printed only once during
>     kernel lifetime... I have about three spurious IRQ 7 per each 1000
>     interrupts delivered to CPU. It is on A7V (Via KT133).
> 
> Any idea _why_ these occur though?  It seems some mainboards produce a
> plethora of these whilst others never produce these...

Nope. Probably when CPU is in local APIC mode, it acknowledges interrupts
to chipset with different timming, and from time to time CPU still
sees IRQ pending, so it asks for vector, but as chipset has no
interrupt pending, it answers with IRQ7. I did no analysis to find
whether IRQ7 happens directly when we send confirmation to 8259,
or whether it happens due to some noise on IRQ line.

AFAIK it happens only on VIA based boards, and only if (AMD) CPU is using 
APIC.
                                                Best regards,
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz
                                                    
