Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277373AbRJOKNO>; Mon, 15 Oct 2001 06:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277375AbRJOKM7>; Mon, 15 Oct 2001 06:12:59 -0400
Received: from Morgoth.esiway.net ([193.194.16.157]:53777 "EHLO
	Morgoth.esiway.net") by vger.kernel.org with ESMTP
	id <S277373AbRJOKMu>; Mon, 15 Oct 2001 06:12:50 -0400
Date: Mon, 15 Oct 2001 12:13:16 +0200 (CEST)
From: Marco Colombo <marco@esi.it>
To: Martin Bauer <martin@kangaroo.at>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: A7A266 clock timer configuration lost
In-Reply-To: <Pine.LNX.3.96.1011013162434.26644A-100000@kangaroo.at>
Message-ID: <Pine.LNX.4.33.0110151159260.28896-100000@Megathlon.ESI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Oct 2001, Martin Bauer wrote:

> hello,
>
> is anyone using a ASUS A7A266 without the clock timer configuration lost
> messages?
>
> so are there only some A7A266 board with this problem an replacing
> the board could fix it - or do i just have to life with the bug and
> a spammed syslog.
>
> --
> kernel: probable hardware bug: clock timer configuration lost - probably a
> VIA686a motherboard.
> kernel: probable hardware bug: restoring chip configuration.
> --
>
> thx, martin
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

I have 3 of them, all show the problem. I'd suggest to remove the
"probably a VIA686a motherboard" at least, it's quite misleading:

# lspci
00:00.0 Host bridge: Acer Laboratories Inc. [ALi]: Unknown device 1647 (rev 04)
00:01.0 PCI bridge: Acer Laboratories Inc. [ALi] M5247
00:02.0 USB Controller: Acer Laboratories Inc. [ALi] M5237 USB (rev 03)
00:04.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c4)
00:06.0 USB Controller: Acer Laboratories Inc. [ALi] M5237 USB (rev 03)
00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge [Aladdin IV]
00:0b.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
00:11.0 Bridge: Acer Laboratories Inc. [ALi] M7101 PMU
01:00.0 VGA compatible controller: S3 Inc. Savage 4 (rev 03)

there's no VIA686a in sight... B-)


I haven't tested xntpd yet, I'm curious to see if that's really a problem
of some kind with timekeeping or not. I'll do that ASAP.

BTW, these MBs crash randomly if you don't use the 'noapic' boot option.

.TM.
-- 
      ____/  ____/   /
     /      /       /			Marco Colombo
    ___/  ___  /   /		      Technical Manager
   /          /   /			 ESI s.r.l.
 _____/ _____/  _/		       Colombo@ESI.it

