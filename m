Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261514AbREOVGs>; Tue, 15 May 2001 17:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261532AbREOVG2>; Tue, 15 May 2001 17:06:28 -0400
Received: from verden.pvv.ntnu.no ([129.241.210.224]:19727 "HELO
	verden.pvv.ntnu.no") by vger.kernel.org with SMTP
	id <S261514AbREOVGS>; Tue, 15 May 2001 17:06:18 -0400
Date: Tue, 15 May 2001 23:06:16 +0200 (CEST)
From: =?ISO-8859-1?Q?Karl_Erik_=D8y=F8ygard?= <oyoy@pvv.ntnu.no>
To: <linux-kernel@vger.kernel.org>
Subject: "kernel: attempt to access beyond end of device" on 2.2.18
In-Reply-To: <Pine.BSF.4.33.0103032221220.55229-100000@verden.pvv.ntnu.no>
Message-ID: <Pine.BSF.4.33.0105152224030.51731-100000@verden.pvv.ntnu.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I've seen reports of simmilar problems from time to time, but none recently.
I've seen no explanation to the cause of these errors, nor any fix, but I've had
these errors on two different machines, so the problem might still exist. Also,
I sometimes get FS corruption, so any help on this problem would be greatly
appreciated.

I get these errors every few weeks on one of my machines running 2.2.18 with
only IDE disks, e2fs only. (hda2 is my root fs)

May 15 12:15:18 brutus-debian kernel: dev 03:02 blksize=1024 blocknr=1918115950
sector=-458735396 size=1024 count=1
May 15 12:15:18 brutus-debian kernel: attempt to access beyond end of device
May 15 12:15:18 brutus-debian kernel: 03:02: rw=0, want=673214562, limit=562464
May 15 12:15:18 brutus-debian kernel: dev 03:02 blksize=1024 blocknr=673214561
sector=1346429122 size=1024 count=1
May 15 12:15:18 brutus-debian kernel: EXT2-fs warning (device ide0(3,2)):
ext2_free_blocks: bit already cleared for block 532867

# lspci -v
00:00.0 Host bridge: Intel Corporation 430HX - 82439HX TXC [Triton II] (rev 03)
        Flags: bus master, medium devsel, latency 32

00:01.0 ISA bridge: Intel Corporation 82371SB PIIX3 ISA [Natoma/Triton II] (rev
01)
        Flags: bus master, medium devsel, latency 0

00:01.1 IDE interface: Intel Corporation 82371SB PIIX3 IDE [Natoma/Triton II]
(prog-if 80 [Master])
        Flags: bus master, medium devsel, latency 32
        I/O ports at ffa0


I have no idea where to start looking, but if someone have any ideas, I'll
try to help track this down.


Regards,
-oyoy-

-CC: me...



