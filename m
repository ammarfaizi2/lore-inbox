Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130162AbQKOVgW>; Wed, 15 Nov 2000 16:36:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130140AbQKOVgM>; Wed, 15 Nov 2000 16:36:12 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:31500 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129871AbQKOVf4>; Wed, 15 Nov 2000 16:35:56 -0500
Message-ID: <3A12FA97.ACFF1577@transmeta.com>
Date: Wed, 15 Nov 2000 13:05:27 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11-pre5 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: rdtsc to mili secs?
In-Reply-To: <3A078C65.B3C146EC@mira.net> <E13t7ht-0007Kv-00@the-village.bc.nu> <20001110154254.A33@bug.ucw.cz> <8uhps8$1tm$1@cesium.transmeta.com> <20001114222240.A1537@bug.ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> >
> > Intel PIIX-based systems will do duty-cycle throttling, for example.
> 
> Don't think so. My toshiba is PIIX-based, AFAIC:
> 

Interesting.  Some will, definitely.  Didn't know that wasn't universal.

Clearly, on a machine like that, there is no hope for RDTSC, at least
unless the CPU (and OS!) gets notification that the TSC needs to be
recalibrated whenever it switches.

> root@bug:~# cat /proc/pci
>   Bus  0, device   5, function  0:
>     Bridge: Intel Corporation 82371AB PIIX4 ISA (rev 2).
>   Bus  0, device   5, function  1:
>     IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 1).
>       Master Capable.  Latency=64.
>       I/O at 0x1000 [0x100f].
>   Bus  0, device   5, function  2:
>     USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 1).
>       IRQ 11.
>       Master Capable.  Latency=64.
>       I/O at 0xffe0 [0xffff].
>   Bus  0, device   5, function  3:
>     Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 2).
> 
> Still, it is willing to run with RDTSC at 300MHz, 150MHz, and
> 40MHz. (The last one in _extreme_ cases when CPU fan fails -- running
> at 40MHz is better than cooking cpu).
> 
> --
> I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
> Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
