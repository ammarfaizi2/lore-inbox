Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131621AbRBAVVx>; Thu, 1 Feb 2001 16:21:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131649AbRBAVVn>; Thu, 1 Feb 2001 16:21:43 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:15633 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131621AbRBAVVb>; Thu, 1 Feb 2001 16:21:31 -0500
Subject: Re: 3Com 3c523 in IBM PS/2 9585: Can't load module in kernel 2.4.1
To: michael@wd21.co.uk (Michael Pacey)
Date: Thu, 1 Feb 2001 21:21:59 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010201193250.B340@kermit.wd21.co.uk> from "Michael Pacey" at Feb 01, 2001 07:32:50 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14ORB4-000571-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The machine has a 3Com 3c523 Etherlink/MC card installed. It worked under
> 2.2.17 but I can't load the module in 2.4.1.

Nobody has fixed this driver for 2.4 yet

> eth0: 3c523 adapter found in slot 3
> eth0: 3Com 3c523 Rev 0xe at 0x1300
> eth0: memprobe, Can't find memory at 0xc0000!
> 3c523.c: No 3c523 cards found

Yep. Most probably it needs munging to use isa_memcpy_fromio and the like
or ioremap.

> I also tried changing the 'Pack Buffer RAM Address Range' setting of the
> card, in the BIOS, to 0D8000-0DDFFF; I get the same error, but the 'Can't
> find memory at ...' error changes to 0xd8000.
> 
> cat /proc/mca/slot3 produces a segfault, I think it was Invalid EAP, but
> not sure as I am trying to fix the machine now so can't reproduce...

Are you willing to be test victim for fixes ?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
