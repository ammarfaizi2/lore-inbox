Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270293AbRHMQyr>; Mon, 13 Aug 2001 12:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270294AbRHMQyi>; Mon, 13 Aug 2001 12:54:38 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:63496 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S270293AbRHMQyT>;
	Mon, 13 Aug 2001 12:54:19 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Francois Romieu <romieu@cogenit.fr>
Date: Mon, 13 Aug 2001 18:53:19 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Are we going too fast?
CC: linux-kernel@vger.kernel.org, pf-kernel@mirkwood.net
X-mailer: Pegasus Mail v3.40
Message-ID: <7352142CD2@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 Aug 01 at 10:55, Francois Romieu wrote:
> 
> Try and send specific bug-reports to the maintainers. 
> l-k archives may give you some light on issues with VIA chipsets.
> 
> I'm not convinced that gaining stability on a VIA + G400 + X + smp 
> combo is an easy task anyway.

VIA (694X) (Gigabyte 6VXD7), G450, XF4.0/XF4.1, SMP (2xPIII/833) works 
fine if you
(1) do not use matrox module from Matrox and
(2) there is not PCI activity which targets G400 when X initialize
    hardware (during start or console switch) and
(3) it is highly unrecommended to use DRI (as it touches G400 hardware
    even when X are not on foreground)

If it is too limiting for you, look for another chipset. With i440BX
you'll get at least 2x faster PCI->AGP transfers than with VIA: i440BX
can handle 60MBps (32bpp full PAL) without any problems, while 694x has 
problems with 30MBps (16bpp full PAL) (IDE disk accesses are visible
as dropouts on picture).

There is nothing Linux kernel can do for stability of such box.
                                            Best regards,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
