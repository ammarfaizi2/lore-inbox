Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279975AbRJ3PbD>; Tue, 30 Oct 2001 10:31:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279976AbRJ3Pay>; Tue, 30 Oct 2001 10:30:54 -0500
Received: from web11303.mail.yahoo.com ([216.136.131.206]:40810 "HELO
	web11303.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S279975AbRJ3Par>; Tue, 30 Oct 2001 10:30:47 -0500
Message-ID: <20011030153123.84364.qmail@web11303.mail.yahoo.com>
Date: Tue, 30 Oct 2001 07:31:23 -0800 (PST)
From: Alex Deucher <agd5f@yahoo.com>
Subject: Re: Writing a driver for a pci busmaster ide controller, need tutoring.
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The only issue with the Piccolo controller is that I
don't think it is a PCI device (doesn't show up in
lspci anyway).  It's part of toshiba's integrated
chipset, so I'm not sure exactly how it is accessed. 
I haven't looked at the docs in a while.  Good luck
with it.  I'd love to see DMA working on my laptop.


Alex

----------------------------

> As this is my first atempt to write a driver I find
my self not really 
> having the knowhow to do this. And it is extremely
hard to find good 
> tutorials on the subject =) 
> So please if anyone find the time and motivation,
would you write me one? 
> Mabey not but if you were to send me all you know on
this topic I might be 
> able to puzzle the bits and pieces together and
write this driver. 

There are two things that will help you straight away.
The first is the 
Linux Device Drivers book (version 2) - also available
online for 
cheapskates ;) 

The second is Documentation/pci.txt, and
Documentation/DMA-mapping.txt 

> It would be easier for me to just let one of you
guys write this driver, but 
> if noone is in any hurry I would find this a great
learning experience, and 
> fun to ;) 

Another good bit of news is that providing the device
follows standard 
IDE bus mastering design (pretty much all do) then you
only actually have 
to write the tuning code for the chipset. 

ide-pci.c contains a table of PCI capable devices and
any driver needed. 
You provide pci initialisers, dma finctions and ide
functions. 

Take a look at amd74xx.c for example - thats a driver
letting ide-dma.c 
do all the work. 

__________________________________________________
Do You Yahoo!?
Make a great connection at Yahoo! Personals.
http://personals.yahoo.com
