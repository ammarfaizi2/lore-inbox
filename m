Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268100AbRHYK00>; Sat, 25 Aug 2001 06:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268129AbRHYK0Q>; Sat, 25 Aug 2001 06:26:16 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:17929 "EHLO
	mailout05.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S268100AbRHYK0B>; Sat, 25 Aug 2001 06:26:01 -0400
Message-ID: <3B877D8B.67D53F82@t-online.de>
Date: Sat, 25 Aug 2001 12:27:23 +0200
From: Gunther.Mayer@t-online.de (Gunther Mayer)
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.6-ac5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kuznet@ms2.inr.ac.ru
CC: linux-kernel@vger.kernel.org
Subject: Re: yenta_socket hangs sager laptop in kernel 2.4.6-> PNPBIOS life saver
In-Reply-To: <200108231834.WAA08213@ms2.inr.ac.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kuznet@ms2.inr.ac.ru wrote:
> 
> Hello!
> 
> > So we have another way besides several INTs to detect the avail mem :-)
> 
> Well, if this memory is available then I guess port 0x1000 is "available"
> as well and all the rest of ports are not available. :-)

Read "available" as "onboard".
Before you use onboard resources you should know what it is !
Surely you don't want to place a PCI ioport window over unknown ports
(as this is what yenta did).

> No, something is rotted in this kingdom.
> 
> > Probably PNP0C02 wants to be reserved, too.
> 
> What's about these, they are nice port and could be used by our irq handler.

These ports are not nice here and should not be user by the irq handler:
   	PNP0c02 Motherboard resources
        io 0x0290-0x0297

> According to docs they replace functionality missing in standard
> int. controller ports for this chipset.

What docs ?

> 
> What's about passing parameters from bios setup to linux...

The BIOS setup uses PNPBIOS to pass parameters to Linux :-)

> This is amusing, but not more. I am sorry, I still prefer to use usual
> kernel command line instead of some ugly foreign interface.

You miss the point of PNP and user-friendliness.

This is a necessary interface to prevent (nearly undebuggable) linux hard hangs !

However, Gerd's debugging forces and his new patch already solve this thread
by giving a working solution.

-
Gunther
