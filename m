Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276132AbRJ2QXL>; Mon, 29 Oct 2001 11:23:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276204AbRJ2QXC>; Mon, 29 Oct 2001 11:23:02 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:42502 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276132AbRJ2QWs>; Mon, 29 Oct 2001 11:22:48 -0500
Subject: Re: Writing a driver for a pci busmaster ide controller, need tutoring.
To: pzycrow@hotmail.com (John Nilsson)
Date: Mon, 29 Oct 2001 16:30:02 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <F22YVWTE5XNKlXyC08X00015176@hotmail.com> from "John Nilsson" at Oct 29, 2001 04:45:52 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15yFIY-0003Ae-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> As this is my first atempt to write a driver I find my self not really 
> having the knowhow to do this. And it is extremely hard to find good 
> tutorials on the subject =)
> So please if anyone find the time and motivation, would you write me one?
> Mabey not but if you were to send me all you know on this topic I might be 
> able to puzzle the bits and pieces together and write this driver.

There are two things that will help you straight away. The first is the
Linux Device Drivers book (version 2) - also available online for
cheapskates ;)

The second is Documentation/pci.txt, and Documentation/DMA-mapping.txt

> It would be easier for me to just let one of you guys write this driver, but 
> if noone is in any hurry I would find this a great learning experience, and 
> fun to ;)

Another good bit of news is that providing the device follows standard
IDE bus mastering design (pretty much all do) then you only actually have
to write the tuning code for the chipset.

ide-pci.c contains a table of PCI capable devices and any driver needed.
You provide pci initialisers, dma finctions and ide functions.

Take a look at amd74xx.c for example - thats a driver letting ide-dma.c
do all the work. 


