Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263634AbRFARmD>; Fri, 1 Jun 2001 13:42:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263635AbRFARlx>; Fri, 1 Jun 2001 13:41:53 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:10400 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S263634AbRFARlf>;
	Fri, 1 Jun 2001 13:41:35 -0400
Message-ID: <3B17D3CB.C4CD8182@mandrakesoft.com>
Date: Fri, 01 Jun 2001 13:41:31 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>
Cc: thunder7@xs4all.nl, linux-kernel@vger.kernel.org
Subject: Re: interrupt problem with MPS 1.4 / not with MPS 1.1 ?
In-Reply-To: <3B16A7E3.1BD600F3@colorfullife.com> <20010531222708.A8295@middle.of.nowhere> <3B16AD5D.DEDB8523@colorfullife.com> <20010601071414.A871@middle.of.nowhere> <3B17D0C1.5FC21CFB@colorfullife.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:
> Could you compile uhci as a module, set the configuration to MPS1.4 and
> find out with which interrupt line setting it works.
> I'd try both
> 
> setpci -s 00:07.2 INTERRUPT_LINE=13
> setpci -s 00:07.2 INTERRUPT_LINE=3
> [even if 13 works, please try 03 as well. 13 is hexadecimal==19]
> 
> The via ac97 sound driver contains an irq fixup for this problem. Either

I am not sure this fixup is necessary, though IIRC it did solve some
problems.  Since this latest round of Via fixups, I would like to remove
that little change in via audio, and see it anyone complains.

The 686A and 686B docs list no irq after 14.  Adrian Cox has said that
setting the PCI intr line value actually makes a connection on the PIC,
instead of just being a scratchpad register like it is normally.  Adrian
said the same thing about the USB IRQ, and I presume the other internal
irqs (like ACPI) listed for register 0x58 apply as well.

-- 
Jeff Garzik      | Disbelief, that's why you fail.
Building 1024    |
MandrakeSoft     |
