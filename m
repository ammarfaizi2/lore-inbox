Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317261AbSGCVqu>; Wed, 3 Jul 2002 17:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317262AbSGCVqt>; Wed, 3 Jul 2002 17:46:49 -0400
Received: from [207.156.7.21] ([207.156.7.21]:25826 "EHLO
	mail.hillsboroughcounty.org") by vger.kernel.org with ESMTP
	id <S317261AbSGCVqr> convert rfc822-to-8bit; Wed, 3 Jul 2002 17:46:47 -0400
Message-Id: <sd23391a.015@GroupWise>
X-Mailer: Novell GroupWise Internet Agent 5.5.6.1
Date: Wed, 03 Jul 2002 17:49:02 -0400
From: "Brett Simpson" <Simpsonb@hillsboroughcounty.org>
To: <linux-kernel@vger.kernel.org>
Subject: Osprey 100 won't work with onboard ATI video.
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an problem where an Osprey 100 video encoder card in a Compaq ML370 will not work with xawtv unless I disable the onboard ATI RageXL video and put in a Cirrus Logic PCI video card. I have noticed this problem with other Compaq servers that have onboard ATI video cards (DL360 & Proliant 1600). In a Compaq Deskpro EN workstation the Osprey works fine with the separate AGP ATI video card.

I have tried 2.5.24, 2.4.18, & 2.4.18-03(redhat) kernels on Redhat Linux 7.3 using the bttv.o module.

/var/log/messages
Jul  3 17:41:33 localhost kernel: bttv0: PLL: 28636363 => 35468950 ... ok
Jul  3 17:41:33 localhost kernel: bttv0: irq: SCERR risc_count=2e765820
Jul  3 17:41:33 localhost kernel: bttv0: irq: SCERR risc_count=2e765808
Jul  3 17:41:33 localhost kernel: bttv0: irq: SCERR risc_count=2e765810
Jul  3 17:41:33 localhost kernel: bttv0: irq: SCERR risc_count=2e765810
Jul  3 17:41:33 localhost kernel: bttv0: irq: SCERR risc_count=2e765808
Jul  3 17:41:33 localhost kernel: bttv0: aiee: error loops
Jul  3 17:41:36 localhost kernel: bttv0: PLL: switching off
Jul  3 17:41:39 localhost kernel: bttv0: resetting chip

[root@localhost root]# lspci
00:00.0 Host bridge: ServerWorks CNB20HE Host Bridge (rev 23)
00:00.1 Host bridge: ServerWorks CNB20HE Host Bridge (rev 01)
00:00.2 Host bridge: ServerWorks: Unknown device 0006 (rev 01)
00:00.3 Host bridge: ServerWorks: Unknown device 0006 (rev 01)
00:02.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)
00:05.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
00:06.0 System peripheral: Compaq Computer Corporation Advanced System Management Controller
00:0f.0 ISA bridge: ServerWorks OSB4 South Bridge (rev 51)
00:0f.1 IDE interface: ServerWorks OSB4 IDE Controller
01:02.0 SCSI storage controller: Adaptec AHA-3960D / AIC-7899A U160/m (rev 01)
01:02.1 SCSI storage controller: Adaptec AHA-3960D / AIC-7899A U160/m (rev 01)
01:04.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
01:04.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
07:07.0 PCI Hot-plug controller: Compaq Computer Corporation PCI Hotplug Controller (rev 12)
[root@localhost root]#

