Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271861AbRHUVC6>; Tue, 21 Aug 2001 17:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271864AbRHUVCt>; Tue, 21 Aug 2001 17:02:49 -0400
Received: from protactinium.btinternet.com ([194.73.73.176]:29408 "EHLO
	protactinium") by vger.kernel.org with ESMTP id <S271861AbRHUVCj> convert rfc822-to-8bit;
	Tue, 21 Aug 2001 17:02:39 -0400
Reply-To: <lar@cs.york.ac.uk>
From: "Laramie Leavitt" <laramie.leavitt@btinternet.com>
To: "'Linux Kernel'" <linux-kernel@vger.kernel.org>
Subject: RE: Linux 2.4.7 Oops in SMP kernel with multiple video cards.
Date: Tue, 21 Aug 2001 22:09:32 +0100
Message-ID: <001401c12a85$948118f0$0b1c7ad5@hayholt>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
In-Reply-To: <000901c11e59$984b0320$47357ad5@hayholt>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have not received a reply to either of my two bug reports.
Investigating, I have found a little more out.  Basically
It comes down to the two video cards.  When I boot with PCI
as the primary card Linux crashes.  When I set it to one card
then it boots.  The problem occurs with all kernels at least from 
2.4.6 - 2.4.9.

The kernel does get past the Synchronization, etc, just fine.
I have tried both FB and non-FB code. I suspect that it is a
VGA/Video-SMP 
initialization interation issue since I can boot non-SMP kernels fine.
Is there anything that I should do to narrow this down more?

I would appreciate any help with this.  I have not yet had a response
from
the mailing list.

Laramie


## Basic info.

The 2 video cards.
PCI: ATI RAGE XL PCI 8MB (rev 0x27)
AGP: RIVA TNT2 ULTRA 32MB

Motherboard MSI 694D Pro AR.

## Summary of lspci

00:00.0 Host bridge: VIA Technologies, Inc. VT82C691 [Apollo PRO] (rev
c4) 
00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3 AGP]
(prog-if 00 [Normal decode]) 
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev
22) 
00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev
10) (prog-if 8a [MasterSecP PriP]) 
00:07.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 10)
(prog-if 00 [UHCI]) 
00:07.3 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 10)
(prog-if 00 [UHCI]) 
00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
(rev 30) 
00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686
[Apollo Super AC97/Audio] (rev 20) 
00:0c.0 RAID bus controller: Promise Technology, Inc.: Unknown device
0d30 (rev 02) 
00:0e.0 Communication controller: CONEXANT PCI Modem Enumerator (rev 08)

00:0f.0 Multimedia audio controller: Yamaha Corporation YMF-724F [DS-1
Audio Controller] (rev 03) 
00:12.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
(prog-if 00 [VGA]) 
01:00.0 VGA compatible controller: nVidia Corporation Riva TnT2 [NV5]
(rev 11) (prog-if 00 [VGA])

-

