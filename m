Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269057AbRHBTer>; Thu, 2 Aug 2001 15:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269068AbRHBTeh>; Thu, 2 Aug 2001 15:34:37 -0400
Received: from 216-99-213-120.dsl.aracnet.com ([216.99.213.120]:32269 "HELO
	clueserver.org") by vger.kernel.org with SMTP id <S269057AbRHBTeZ>;
	Thu, 2 Aug 2001 15:34:25 -0400
Date: Thu, 2 Aug 2001 13:48:29 -0700 (PDT)
From: Alan Olsen <alan@clueserver.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Keith Owens <kaos@ocs.com.au>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PCMCIA IDE_CS in 2.4.7
In-Reply-To: <E15SMji-000182-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10108021345340.393-100000@clueserver.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Aug 2001, Alan Cox wrote:

> > > Gunther posted this patch ages ago which seems to solve the problem
> > 
> > I will try that. Any reason it did not make it to 2.4.7?
> 
> Andre didnt like it for obscure ATA technical reasons. If it works then
> personally I think its a candidate to go in anyway

Well, it gets rid of the hanging behaviour.  There is a bit of
sluggishness, but it is because it is trying to setup ide2 and failing.

Aug  2 11:28:38 summanulla kernel: hde: IBM-DADA-26480, ATA DISK drive
Aug  2 11:28:38 summanulla kernel: hde: IBM-DADA-26480, ATA DISK drive
Aug  2 11:28:38 summanulla kernel: ide2: Disabled unable to get IRQ 5.
Aug  2 11:28:38 summanulla kernel: ide2: Disabled unable to get IRQ 5.
Aug  2 11:28:40 summanulla kernel: hde: ERROR, PORTS ALREADY IN USE
Aug  2 11:28:40 summanulla kernel: hde: ERROR, PORTS ALREADY IN USE
Aug  2 11:28:42 summanulla kernel: ide2: ports already in use, skipping
probe
Aug  2 11:28:42 summanulla kernel: ide2: ports already in use, skipping
probe
Aug  2 11:28:53 summanulla last message repeated 7 times
Aug  2 11:28:53 summanulla kernel: ide_cs: ide_register() at 0x110 &
0x11e, irq 5 failed
Aug  2 11:28:53 summanulla last message repeated 7 times
Aug  2 11:28:53 summanulla kernel: ide_cs: ide_register() at 0x110 &
0x11e, irq 5 failed
Aug  2 11:28:53 summanulla kernel: Trying to free nonexistent resource
<00000110-0000011f>
Aug  2 11:28:53 summanulla kernel: Trying to free nonexistent resource
<00000110-0000011f>
Aug  2 11:28:54 summanulla cardmgr[1023]: get dev info on socket 1 failed:
Resource temporarily unavailable
Aug  2 11:29:51 summanulla cardmgr[1023]: shutting down socket 1
Aug  2 11:29:51 summanulla cardmgr[1023]: executing: 'modprobe -r ide-cs'

I need to look at where ide2 is trying to be set later.  (I have a LUG
meeting to get ready for.)

alan@ctrl-alt-del.com | Note to AOL users: for a quick shortcut to reply
Alan Olsen            | to my mail, just hit the ctrl, alt and del keys.
 "All power is derived from the barrel of a gnu." - Mao Tse Stallman

