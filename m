Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282149AbRK1OYU>; Wed, 28 Nov 2001 09:24:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283037AbRK1OYL>; Wed, 28 Nov 2001 09:24:11 -0500
Received: from sr1.terra.com.br ([200.176.3.16]:25007 "EHLO sr1.terra.com.br")
	by vger.kernel.org with ESMTP id <S282149AbRK1OXy>;
	Wed, 28 Nov 2001 09:23:54 -0500
Message-ID: <3C04F378.2050904@terra.com.br>
Date: Wed, 28 Nov 2001 12:23:52 -0200
From: Piter Punk <piterpk@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: root@chaos.analogic.com
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 'spurious 8259A interrupt: IRQ7'
In-Reply-To: <Pine.LNX.3.95.1011128084801.10732A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:

>
> IRQ7 is usually connected to the parallel port. If there is no driver
> installed, that expects interrupts, you could end up with this
> annoying message because the printer status bits are all ORed into
> that IRQ line. You can disable this with software, though, and it
> might be a good idea.
> 
>           outb(0, BASE+2);
> 
> ... where BASE is 0x278, 0x378, 0x3bc, etc.. the printer ports.


Hmmmm. I have a driver installed! I use a printer in my parallel port and i 
need lp module is installed.

But... i am go to see if this message appears only on boot (before i load 
the module) or appears all time...

 
> Also, a catch-all for confused interrupt controllers is IRQ7. Even
> without a parallel port, you can still get an occasional spurious
> interrupt. I think the kernel should have an interrupt handler for
> this interrupt that does nothing except ACK the interrupt and
> keep its mouth shut.  The request_irq() procedure should ignore
> the fact that it is "in use", and let any driver have it without
> sharing it.

-- 
   ____________
  / Piter PUNK \_____________________________________________________
|                                                                   |
|      |        E-Mail: piterpk@terra.com.br         (personal)     |
|     .|.               roberto.freires@gds-corp.com (professional) |
|     /V\                                                           |
|    // \\      UIN: 116043354  Homepage: www.piterpunk.hpg.com.br  |
|   /(   )\                                                         |
|    ^`~'^         ----> Slackware Linux - The Best One! <----      |
|   #105432                                                         |
`-------------------------------------------------------------------'

