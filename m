Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312498AbSDSRRt>; Fri, 19 Apr 2002 13:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312524AbSDSRRs>; Fri, 19 Apr 2002 13:17:48 -0400
Received: from bv-n-3b5d.adsl.wanadoo.nl ([212.129.187.93]:16900 "HELO
	legolas.dynup.net") by vger.kernel.org with SMTP id <S312498AbSDSRRr>;
	Fri, 19 Apr 2002 13:17:47 -0400
Date: 19 Apr 2002 17:17:42 -0000
Message-ID: <20020419171742.6300.qmail@legolas.dynup.net>
From: rudmer@legolas.dynup.net
To: davej@suse.de
Subject: harddisk problems with 2.5.8-dj1
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

reading through my dmesg output I found the following:
--
hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
hda: drive_cmd: error=0x04 { DriveStatusError }
hdc: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
hdc: drive_cmd: error=0x04 { DriveStatusError }
--

This is the first time I see this error for my HD's.
HD information from dmesg:
--
Uniform Multi-Platform E-IDE driver ver.:7.0.0
ide: system bus speed 33MHz
hda: QUANTUM FIREBALL640A, ATA DISK drive
hdc: QUANTUM FIREBALL640A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 1253952 sectors (642 MB) w/83KiB Cache, CHS=1244/16/63
hdc: 1253952 sectors (642 MB) w/83KiB Cache, CHS=1244/16/63
Partition check:
 hda: [PTBL] [622/32/63] hda1 hda2
 hdc: [PTBL] [622/32/63] hdc1
--

I changed nothing in my .config from earlier -dj kernels
So what can be wrong?

There is also some other problem with kernels 2.5 for my system
since every kernel I have tried locked up after one of the HD's
(mostly hdc) had lost its interrupt, sometimes after an hour,
sometimes after almost a week... keeping the hdc1 (/usr) partition
mounted ro increased the lifetime of the running system.
Is this a problem of my (old) hardware giving up on me or is the
new IDE driver not fully capable of handling my hardware?
It also appeared that the -dj kernels were better then the normal
kernels.

If you want more information please ask,

Rudmer
