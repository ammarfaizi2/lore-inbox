Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131004AbRAZOnz>; Fri, 26 Jan 2001 09:43:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131305AbRAZOnp>; Fri, 26 Jan 2001 09:43:45 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:11021 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S131004AbRAZOnb>;
	Fri, 26 Jan 2001 09:43:31 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: "Richard B. Johnson" <root@chaos.analogic.com>
Date: Fri, 26 Jan 2001 15:41:10 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Linux Post codes during runtime, possibly OT
CC: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <13AEBF842896@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 Jan 01 at 8:58, Richard B. Johnson wrote:
> On Thu, 25 Jan 2001, H. Peter Anvin wrote:
> > > You could use the DMA scratch register at 0x19. I'm sure Linux doesn't
> > > "save" stuff there when setting up the DMA controller.
> > > 
> I will change the port on my machines and run them for a week. I
> don't have any DEC Rainbows or other such. Yes, I know Linux will
> not run on a '286.
> 
> Since 0x19 is a hardware register in a DMA controller, specifically
> called a "scratch" register, it is unlikely to hurt anything. Note
> that the BIOS saves stuff in CMOS. It never expects hardware registers
> to survive a "warm boot". It even checks in CMOS to see if it should
> preserve RAM.

Unless there are chips which need DELAY between accesses to DMA 
controller ;-) And I'm sure there are such. Also, if DMA controller
is integrated on board, outb is done in different speed than ISA 
forwarded cycle to postcode port.

Just in case, on my VIA, 1e6 outb(0,0x80) tooks 2.07s, 1e6 outb(0,0x19)
tooks 2.33s - so there is definitely difference - although in other 
direction than I expected. (What you can expect from this ....)
                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz
                                            
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
