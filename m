Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129028AbRBEThA>; Mon, 5 Feb 2001 14:37:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129065AbRBETgv>; Mon, 5 Feb 2001 14:36:51 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:40209 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S129028AbRBETgg>; Mon, 5 Feb 2001 14:36:36 -0500
Message-ID: <3A7F00B8.9BDE5BBB@Hell.WH8.TU-Dresden.De>
Date: Mon, 05 Feb 2001 20:36:24 +0100
From: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>
Organization: Dept. Of Computer Science, Dresden University Of Technology
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-ac2 i686)
X-Accept-Language: en, de-DE
MIME-Version: 1.0
To: Peter Horton <pdh@colonel-panic.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: VIA silent disk corruption - likely fix
In-Reply-To: <20010205150802.A1568@colonel-panic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Horton wrote:
> 
> I've found the cause of silent disk corruption on my A7V motherboard,
> and it might affect all boards with the same North bridge (KT133 etc).
> 
> For some reason the IDE controller(s) was sometimes picking up stale
> data during bus master DMA to the drive. Assuming that there was no bug
> in the CPU it had to be the North bridge that was caching the stuff when
> it shouldn't have been. I assume the problem would also apply to other
> bus masters (SCSI, NIC etc).

Do you have a small test program to illustrate that bug? I have an A7V
with PCI Master Read Caching enabled and haven't seen any corruption so
far (which doesn't necessarily mean much). Or if you don't have a test
program, how did you identify it's caching too much?
Also, are you using a Thunderbird or a Duron?

I'm using the 1003 Bios, which has proven to be the most stable so far.
Which one do you use?

-Udo.

P.S. I seem to recall that later Bios Versions (>=1004) disable Master
     Read Caching by default, so maybe Asus has also noticed something
     wrong with it.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
