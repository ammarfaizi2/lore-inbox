Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280126AbSAGQ7P>; Mon, 7 Jan 2002 11:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280588AbSAGQ7G>; Mon, 7 Jan 2002 11:59:06 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:39946 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S280126AbSAGQ7A>;
	Mon, 7 Jan 2002 11:59:00 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Mon, 7 Jan 2002 17:58:14 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: "APIC error on CPUx" - what does this mean?
CC: cw@f00f.org (Chris Wedgwood), swsnyder@home.com,
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List),
        alan@lxorguk.ukuu.org.uk
X-mailer: Pegasus Mail v3.40
Message-ID: <E3B8D7A16F6@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  7 Jan 02 at 13:33, Alan Cox wrote:
> > whether IRQ7 happens directly when we send confirmation to 8259,
> > or whether it happens due to some noise on IRQ line.
> > 
> > AFAIK it happens only on VIA based boards, and only if (AMD) CPU is using 
> > APIC.
> 
> Are you using an AMD northbridge and VIA southbridge together ?

No. It is fully-VIA motherboard (Asus A7V), VIA KT133 as a northbridge 
and VIA686A as a southbridge, with 1GHz Athlon. And spurious IRQ happen 
when either of (massive) IRQ sources (Promise UDMA, tulip-based network 
card, an es137x soundcard) emits interrupts.

Problem is best visible when Promise is used in PIO mode with block size=512,
as in such case you can get thousands of IRQs from Promise in second, and
tenths of spurious IRQ7. But even if Promise emits in average one IRQ each 
second (== idle system with running cron and atime updates on), I get 
~10 of spurious IRQ7 during one hour.

I can get complete lspci -vvv at home, if you want.
                                                Best regards,
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz
                                                    
