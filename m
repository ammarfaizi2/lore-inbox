Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288575AbSADJzc>; Fri, 4 Jan 2002 04:55:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288562AbSADJzW>; Fri, 4 Jan 2002 04:55:22 -0500
Received: from dubb05h09-0.dplanet.ch ([212.35.36.9]:39695 "EHLO
	dubb05h09-0.dplanet.ch") by vger.kernel.org with ESMTP
	id <S288573AbSADJzU>; Fri, 4 Jan 2002 04:55:20 -0500
Message-ID: <3C357C50.6168947B@dplanet.ch>
Date: Fri, 04 Jan 2002 10:56:32 +0100
From: "Giacomo A. Catenazzi" <cate@dplanet.ch>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.17 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: ISA slot detection on PCI systems?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I have some comments about the thread (to make some
order).


Aunt Tillie:

Linus shared Linux as a 'game' for other hackers (10 years ago).
Now some 'Aunt Tillie' use Linux.
Thus maybe in few years all 'Aunt Tillie' will compile the
own kernel.

The difference between Linus and the other elder brother
(and also the elder bad boy) is the availability of sources.
IMHO we should enlarge this difference, thus the sources
should no be a add-on for geek, but for all.
Let all *use* the source!


DMI.

I really don't like dmi. On my development machine (a
laptop), I have the BAD video card (which force me to
taint the kernel, someone in this thread tell us
the it is a 'not plus ultra' but...).
The DMI tell me that the card is a good ATI. (
The bios is uptodate)
[machine: Dell i8k, not a noname]
This with other bad DMI report tell me that dmi is
not yet reliable [2001/2002]


ISA and PCI

Eric: There is not need to make to much assertions.

I told you about the HEURISTIC mode.
If we found a moderm machine, with PCI bus, let forget
about ISA.

If there is a ISA card, and it is important, the current
kernel have already detected it (and maybe it is using it),
so the detection routines should already have indluced it.

The main think to remember is that kernel make already the
important detections, and we can use the result to make
a machine bootable. [important = necessary to boot and to
make the machine usable]
The big driver database is to set up the better drivers,
the newer devices, the less common driver (the
distributions did not compile all availables modules), ...
[and it is easyer to make that checking the printk string]

[ This will work for the normal user. If someone
will use the autodetection for the 'boot-cdrooms',
(to find the better kernel), the things are
complexer, but the 'boot cdrooms' people are good
programmers, so they will find a extra solution]


What I will do:

I check the .config of main distributions [could
someone send to me the latest official .config],
and I'll find what are the common/default ISA cards.
Than I make sure that the autodetection *will*
detect such cards via dmesg, /proc,...
So this thread is solved.
[the purpose, still we had not the tools
that enumerate all ISA card. But this tool
is impossible to build]

        giacomo
