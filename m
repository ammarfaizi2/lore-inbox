Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282873AbRLGQ3n>; Fri, 7 Dec 2001 11:29:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282874AbRLGQ3e>; Fri, 7 Dec 2001 11:29:34 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:28947 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S282873AbRLGQ3Q>;
	Fri, 7 Dec 2001 11:29:16 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: "Richard B. Johnson" <root@chaos.analogic.com>
Date: Fri, 7 Dec 2001 17:28:44 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: spurious interrupt with 2.4.10 and higher ?
CC: kernel list <linux-kernel@vger.kernel.org>, xsebbi@gmx.de
X-mailer: Pegasus Mail v3.40
Message-ID: <B53085D0774@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  6 Dec 01 at 15:43, Richard B. Johnson wrote:
> > For a long time, I receive at boot time (and in /var/log/warn) the following 
> > message from the kernel:
> > 
> > Spurious 8259A interrupt: IRQ7
> > 
> > Could you tell me please, what is it? My System works fine but I hate this 
> > message. :-)
> 
> FYI, unless you get a burst of these things, they are harmless.

Only problem is that this message is printed only once for each IRQ, so
you cannot get more than 16 of them... Watch ERR counter in /proc/interrupts,
it is still increasing, although message is not printed. On my A7V (KT133,
Thunderbird) there are about 3 spurious IRQ7 per 1000 irqs delivered from
onboard Promise IDE (and ide driver does not complain about timeouts, so
I assume that IRQ from IDE is delivered AND spurious IRQ7 is delivered). 
Unfortunately I do not have anything else in the computer, so I cannot 
check whether KT133 or Promise is a culprit, but from other messages it 
looks like that Promise is innocent, and VIA is guilty one.
                                            Best regards,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
