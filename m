Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289138AbSAGMat>; Mon, 7 Jan 2002 07:30:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289135AbSAGMak>; Mon, 7 Jan 2002 07:30:40 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:62992 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S289130AbSAGMaa>;
	Mon, 7 Jan 2002 07:30:30 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Chris Wedgwood <cw@f00f.org>
Date: Mon, 7 Jan 2002 13:29:42 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: "APIC error on CPUx" - what does this mean?
CC: swsnyder@home.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        alan@lxorguk.ukuu.org.uk
X-mailer: Pegasus Mail v3.40
Message-ID: <E3713B21FAB@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  7 Jan 02 at 23:17, Chris Wedgwood wrote:
> On Thu, Jan 03, 2002 at 10:38:27PM +0000, Alan Cox wrote:
>     The occasional APIC error is fine (its logging a hardware event -
>     probably something that caused enough noise to lose a message and
>     retry it). The APIC bus is designed to stand these occasional
>     errors
> 
> I'm curious... is there any way to determine what is causing these?
> On a UP athlon I have:
> 
> cw:tty5@charon(cw)$ uname -r ; uptime && grep ERR /proc/interrupts
> 2.4.17-rc2
>  02:09:50 up 4 days,  5:18, 10 users,  load average: 0.00, 0.00, 0.00
> ERR:       5216
> 
> which equates several per minute at times... no funny hardware, not
> running X11, and I don't remembering seeing these a while ago on this
> same mainboard (but I never really looked either, so that might not be
> true).

They are spurious IRQ 7, just message is printed only once during kernel
lifetime... I have about three spurious IRQ 7 per each 1000 interrupts 
delivered to CPU. It is on A7V (Via KT133).
                                            Best regards,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
