Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289559AbSAONDX>; Tue, 15 Jan 2002 08:03:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289561AbSAONDI>; Tue, 15 Jan 2002 08:03:08 -0500
Received: from xsmtp.ethz.ch ([129.132.97.6]:15289 "EHLO xfe3.d.ethz.ch")
	by vger.kernel.org with ESMTP id <S289559AbSAONCw>;
	Tue, 15 Jan 2002 08:02:52 -0500
Message-ID: <3C4427F6.3010703@debian.org>
Date: Tue, 15 Jan 2002 14:00:38 +0100
From: Giacomo Catenazzi <cate@debian.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.4) Gecko/20011128 Netscape6/6.2.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "T. A." <tkhoadfdsaf@hotmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, esr@thyrsus.com
Subject: Re: Aunt Tillie builds a kernel (was Re: ISA hardware discovery -- the elegant solution)
In-Reply-To: <fa.fslncfv.r6o11i@ifi.uio.no> <fa.hqe5uev.c60cjs@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Jan 2002 13:02:51.0131 (UTC) FILETIME=[F026CCB0:01C19DC4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


T. A. wrote:

 
>     1. Don't see any reason for the kernel hardware autoconfigurator to be
> included in the kernel.


Linus and Alan last year (end Dec 2000), told that it would nice to have
some kind of autoconfiguration.
The problem was the bug report about non running kernel, because of
false configuration (CPU configuration).
How many people try new kernel with the wrong CPU configuration?
(and mornally user know the name of own CPU, with netcards this is
more difficult).

[ We don't reduce trafic on lkml, because the fewer bug reports
are hidden by this huge flamewar]

> 
>     2. Don't see any reason the kernel hardware autoconfigurator cannot be
> run as root.  Actually see one very good reason why it shouldn't be able to
> be run as a regular user.  Probing certain hardware is inherently dangerous.
> Machine can hang.  Hardware could be probed to death.  Heck a clever coder
> could even make use of the user level access required to allow user hardware
> autoconfiguration.  Wiping disks, destroying flash roms, finding system
> backdoors, etc, etc.


Root will help, but AFAIK, not needed. Forget DMI.
Out detection is 'hang' free. (so a soft detection, but with some
tests, I can say that with this soft detection we can detect nearly
all, without the difficult to write hard probes).

> 
>     3. ISA is pretty much dead outside of certain standard PC equipment.
> And of the remaining ISA out there, most in any machine than can still run a
> Linux kernel effectively is most likely PNP ISA.  Plus there are a few
> fairly common ISA cards that can also be found easily.  It seams that the
> vast majority of Aunt Tillies will be served with just PCI autoconfiguration
> and maybe PNP ISA configuration.

PCI, USB and ISAPNP detection works well.
ISA is a further step.
I will send Eric the new detections and database for new probes (for ISA
and others) drivers. So I hope also the ISA thread will end.

	giacomo

