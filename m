Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269778AbRHYRBB>; Sat, 25 Aug 2001 13:01:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269779AbRHYRAv>; Sat, 25 Aug 2001 13:00:51 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:19724 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S269778AbRHYRAn>;
	Sat, 25 Aug 2001 13:00:43 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200108251700.VAA22595@ms2.inr.ac.ru>
Subject: Re: yenta_socket hangs sager laptop in kernel 2.4.6-> PNPBIOS life saver
To: Gunther.Mayer@t-online.de (Gunther Mayer)
Date: Sat, 25 Aug 2001 21:00:49 +0400 (MSK DST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3B877D8B.67D53F82@t-online.de> from "Gunther Mayer" at Aug 25, 1 12:27:23 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Before you use onboard resources you should know what it is !
> Surely you don't want to place a PCI ioport window over unknown ports
> (as this is what yenta did).

This is right.

Though, to make situation more clean explain me one much simpler thing:
look at these lines from beginning of my lspnp -v:

00 PNP0c01 System board
        mem 0x00000000-0x0009ffff
        mem 0x00100000-0x0bfdffff
        mem 0x0bfe0000-0x0bfeffff
        mem 0x000e0000-0x000fffff
        mem 0xffff0000-0xffffffff

Look at line mem 0x0bfe0000-0x0bfeffff. I hope you never saw this
motherboard before, like this happens with our poor kernel,
so you are not in better position. Imagine, you are kernel,
and decide are you allowed to use these 64K or not? :-)

Additional information: bios-e820 reports this area as ram in one block
with all the rest of memory 0x00100000-0x0bfeffff.


> What docs ?

Intel datashits from developer.intel.com.

Alexey

