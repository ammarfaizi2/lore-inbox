Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130120AbQK3VUk>; Thu, 30 Nov 2000 16:20:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130154AbQK3VUa>; Thu, 30 Nov 2000 16:20:30 -0500
Received: from smtpnotes.altec.com ([209.149.164.10]:47108 "HELO
	smtpnotes.altec.com") by vger.kernel.org with SMTP
	id <S130120AbQK3VUK>; Thu, 30 Nov 2000 16:20:10 -0500
X-Lotus-FromDomain: ALTEC
From: Wayne.Brown@altec.com
To: linux-kernel@vger.kernel.org
Message-ID: <862569A7.00724FA9.00@smtpnotes.altec.com>
Date: Thu, 30 Nov 2000 14:49:43 -0600
Subject: Crystal SoundFusion doesn't work under 2.4.0-test12-pre3
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



My Crystal CS4624 PCI Audio card in my Thinkpad 600X, which works fine in
2.4.0-test11, doesn't work under test12-pre2 or -pre3.  (I haven't tried -pre1.)
The relevant lines from dmesg show the following: for test11:

Crystal 4280/461x + AC97 Audio, version 0.09, 22:14:35 Nov 28 2000
cs461x: Card found at 0x50100000 and 0x50000000, IRQ 11
cs461x: Thinkpad 600X/A20/T20 at 0x50100000/0x50000000, IRQ 11
ac97_codec: AC97 Audio codec, id: 0x4352:0x5913 (Cirrus Logic CS4297A)
cs461x: Found 1 audio device(s).


and for test12-pre3:

Crystal 4280/461x + AC97 Audio, version 0.14, 11:51:35 Nov 29 2000
cs461x: Card found at 0x50100000 and 0x50000000, IRQ 11
cs461x: Unknown card (FFFFFFFF:FFFFFFFF) at 0x50100000/0x50000000, IRQ 11
cs461x: AC'97 read problem (ACSTS_VSTS), reg = 0x0
ac97_codec: Primary ac97 codec not present


Both of these are with the sound driver built as module.  With all the sound
stuff compiled into the kernel, I get this result for test12-pre3:

Crystal 4280/461x + AC97 Audio, version 0.14, 07:34:37 Nov 30 2000
cs461x: Card found at 0x50100000 and 0x50000000, IRQ 11
cs461x: Unknown card (FFFFFFFF:FFFFFFFF) at 0x50100000/0x50000000, IRQ 11
cs461x: create - never read ISV3 & ISV4 from AC'97


Any ideas?


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
