Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271029AbRHTFnH>; Mon, 20 Aug 2001 01:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271068AbRHTFm5>; Mon, 20 Aug 2001 01:42:57 -0400
Received: from WARSL401PIP3.highway.telekom.at ([195.3.96.75]:20037 "HELO
	email02.aon.at") by vger.kernel.org with SMTP id <S271029AbRHTFmv>;
	Mon, 20 Aug 2001 01:42:51 -0400
From: "Michael Guntsche" <m.guntsche@epitel.at>
To: <linux-kernel@vger.kernel.org>
Subject: VIA fix breaks BTTV overlay
Date: Mon, 20 Aug 2001 07:23:55 +0200
Message-ID: <NDBBJOKGIPCDBEEFHNFPEEMGCAAA.m.guntsche@epitel.at>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Morning list

I noticed following problem with recent kernels 2.4.[3-8]. If I use overlay
with my Brooktree card and the window has a certain size, the picture is
broken. After digging through the mailinglist archive I found a fix.
Commenting out pci_fixup_via691_2 in linux-2.4.x/arch/i386/kernel/pci-pc.c
fixed the problem, overlay was working again. I think the problem is that
pci_fixup_via691_2 is fixing something that isn't broken with my hardware
and therefore breaks it.

I have an "old" Athlon 700 on a Asus K7V mobo with the KX133 chip.

lspci output:
00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x]
(rev 02)
00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo
MVP3/Pro133x AGP]
00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South]
(rev 22)
00:04.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 10)
00:04.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10)
00:04.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10)
00:04.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
(rev 30)
00:0a.0 Multimedia audio controller: Creative Labs SB Live! EMU10000 (rev
07)
00:0a.1 Input device controller: Creative Labs SB Live! (rev 07)
00:0d.0 Multimedia video controller: Brooktree Corporation Bt848 TV with DMA
push (rev 12)
01:00.0 VGA compatible controller: nVidia Corporation GeForce 256 DDR (rev
10)

If you need more information just ask me.

Cheers,
Mike

PS: Please CC any replies to me, since I am not subscribed to the list.

