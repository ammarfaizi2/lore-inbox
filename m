Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264294AbRFIPC3>; Sat, 9 Jun 2001 11:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264319AbRFIPCT>; Sat, 9 Jun 2001 11:02:19 -0400
Received: from nalserver.nal.go.jp ([202.26.95.66]:19157 "EHLO
	nalserver.nal.go.jp") by vger.kernel.org with ESMTP
	id <S264294AbRFIPCA>; Sat, 9 Jun 2001 11:02:00 -0400
Date: Sun, 10 Jun 2001 00:01:48 +0900 (JST)
From: Aron Lentsch <lentsch@nal.go.jp>
To: linux-kernel@vger.kernel.org
Subject: IRQ problems on new Toshiba Libretto
Message-ID: <Pine.LNX.4.21.0106092217330.1008-100000@triton.nal.go.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Hi there!

I am trying to install Linux 2.4.4 on the new Toshiba
Libretto, the one with the Crusoe CPU, 1280x600 screen,
1kg (I think it is currently only sold in Japan).

I am having problems with IRQs and the recognition of
system components, which I suspect is the reason, why
about half of my devices are unusable. I am getting the
message "PCI: No IRQ known for interrupt pin A of
device 00:00.0. Please try using pci=biosirq." This
message is repeated for the following devices:

00:00.0 Host bridge: Transmeta Corporation LongRun Northbridge
00:06.0 Multimedia audio controller: Acer Laboratories Inc.
00:0f.0 FireWire (IEEE 1394): Texas Instruments: Unknown device 8020
00:10.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c3)
00:12.0 CardBus bridge: Toshiba ToPIC95 PCI to Cardbus Bridge
01:00.0 Ethernet controller: DECchip 21142/43

I have put the details of /var/log/messages, lspci, /proc/pci, 
pnpdump and the kernel configuration into the file
http://launchers.tripod.com/linux/libretto_logs_n_kernelconfig.txt

I searched the mailing-list archives for this error
message for the last days, applying suggested kernel
parameters and kernel-patches, but without success.
Unfortunately the Libretto seems to have no common
BIOS - didn't find how to enter and change anything
- - all settings are done from Windows :-(

Now I have a number of problems, which I suspect are a
consequence of the above error message:

o   PCMCIA cards are not initialized and return the
above error message (for device 01:00.0) when inserted.
Therefore I can currently not use any PCMCIA device 
(modem, ethernet, CD-Rom !!!) - THIS IS CRITICAL!

o   ACPI output is bogus, showing a remaining battery
capacity, which jumps every few seconds to levels
somewhere between 0 and 100%. The Librtto only supports
ACPI. I am using version acpi-20010518 patched
against kernel 2.4.4, so it should be up-to-date.

o   I can not find my internal (win)modem. Neither
lspci -vvv, pnpdump nor /proc/pci give any evidence
- - but the modem works fine under windows - I mean it is
really there.

o   I fail to initialize the ASLA-sound module for my
ALi-chip (same error message). 

At the moment the core system (CPU, memory, harddisk,
screen and keyboard) is working well. But I would like
to make the whole system work properly - just don't
know what else I can do. I'm not a kernel hacker. Can
anybody help?

THANKS!
Aron

PS:   Because I am not subscribed to the mailing-list,
      could you please CC any comments to me directly.

             _______________________________________
             A  r  o  n    L   E   N   T   S   C   H
             N A L  -  National Aerospace Laboratory
             7-44-1 Jindaiji-Higashi           Chofu
             Tokyo 182-8522                    JAPAN
             phone  +81-422-40-3173    (fax ..-3138)
 
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.3 (GNU/Linux)
Comment: Made with pgp4pine 1.75-6

iD8DBQE7IjplTHIdV6Tf0iQRAvwCAJ92Es7Ut0MVewlbtwCA/N9uD8EuHgCgvNyU
0z1NKdZOrFEKGxn2VGdnma0=
=4yKd
-----END PGP SIGNATURE-----


