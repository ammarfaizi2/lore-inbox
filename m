Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269641AbRIOTOW>; Sat, 15 Sep 2001 15:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271333AbRIOTOM>; Sat, 15 Sep 2001 15:14:12 -0400
Received: from fe070.worldonline.dk ([212.54.64.208]:27407 "HELO
	fe070.worldonline.dk") by vger.kernel.org with SMTP
	id <S269641AbRIOTOC>; Sat, 15 Sep 2001 15:14:02 -0400
Message-ID: <3BA22537.94D4EA28@eisenstein.dk>
Date: Fri, 14 Sep 2001 17:41:44 +0200
From: Jesper Juhl <juhl@eisenstein.dk>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: linux-kernel@vger.kernel.org, DevilKin@gmx.net
Subject: Re: [PATCH] AGP GART for AMD 761
In-Reply-To: <1000577021.32706.29.camel@phantasy>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:

> Please test and let me know so I can forward it off.  Against
> 2.4.10-pre9, but should apply to Alan's tree and 2.4.9.

Hi,

I first thought that something was wrong with the patch as I got the following trying to apply
it to 2.4.10-pre9 :

bash-2.05# pwd
/usr/src/linux
bash-2.05# patch -p1 < /home/jesper/amd761.diff
patching file Documentation/Configure.help
patching file drivers/char/agp/agp.h
Hunk #1 succeeded at 196 with fuzz 2.
patching file drivers/char/agp/agpgart_be.c
Hunk #1 FAILED at 2895.
Hunk #2 FAILED at 2928.
2 out of 2 hunks FAILED

-- saving rejects to file drivers/char/agp/agpgart_be.c.rej

patching file include/linux/agp_backend.h

patch unexpectedly ends in middle of line

Hunk #1 FAILED at 58.

1 out of 1 hunk FAILED -- saving rejects to file include/linux/agp_backend.h.rej

but it turned out that it was just my email client that had converted all the tabs to spaces,
and after fixing that the patch applied fine.

The new kernel build without any problem, booted without any problem and my system seems to be
running fine (agpgart build static, not as a module).

Here are the relevant parts of dmesg from my box:

Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: unsupported bridge
agpgart: no supported devices found.


My system is a 1.4GHz AMD Athlon Thunderbird with a 266MHz fsb, mainboard is ASUS A7M266
(AMD761 North Bridge VIA 686B South Bridge) and I have 512MB Kingston 266MHz DDR RAM installed
in two slots.

I'm not entirely sure about this, but I don't think that my system actually uses the kernel
agpgart driver since I have a ASUS V8200 Deluxe Geforce3 graphics card and I currently use the
binary only NVidia supplied drivers (I can easily switch to other drivers if you want me to test
anything!).

It there is any other info that you would like me to provide or something you'd like me to test
I'm full willing to reconfigure my system in any way nessesary to provide the requested info
and/or test results.


Best regards,
Jesper Juhl
juhl@eisenstein.dk


