Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129698AbRBXXZI>; Sat, 24 Feb 2001 18:25:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129693AbRBXXY6>; Sat, 24 Feb 2001 18:24:58 -0500
Received: from pop.gmx.net ([194.221.183.20]:49130 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S129697AbRBXXYs>;
	Sat, 24 Feb 2001 18:24:48 -0500
From: "Matthias.Kleine" <Kleine_Matthias@gmx.de>
Reply-To: Kleine_Matthias@gmx.de
Date: Sun, 25 Feb 2001 01:30:14 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="US-ASCII"
To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.3.96.1010221170212.4012B-100000@delta.ds2.pg.gda.pl>
In-Reply-To: <Pine.GSO.3.96.1010221170212.4012B-100000@delta.ds2.pg.gda.pl>
Subject: Re: Maybe a bug
MIME-Version: 1.0
Message-Id: <01022501301401.02374@delphin>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej W. Rozycki wrote:

>  Hmm, you state the watchdog works from time to time and the log you
> provided confirms the statement -- it reports:

> > ..TIMER: vector=49 pin1=2 pin2=0
> > activating NMI Watchdog ... done.

Yes, but I reach this message only once of 10 trials to boot. The other nine
trials I just reach

activating NMI Watchdog ... 

followed by no "done" (and not followed by anything else).

> What chipset do you use (check with lspci)?

00:00.0 Host bridge: VIA Technologies, Inc. VT82C691 [Apollo PRO] (rev c4)
00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3 AGP]
00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 40)
00:04.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 06)
00:04.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 16)
00:04.3 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 16)
00:04.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 
40)
00:09.0 Network controller: AVM Audiovisuelles MKTG & Computer System GmbH A1 
ISDN [Fritz] (rev 02)
00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
00:0b.0 Multimedia audio controller: Creative Labs SB Live! EMU10000 (rev 07)
00:0b.1 Input device controller: Creative Labs SB Live! (rev 07)
01:00.0 VGA compatible controller: nVidia Corporation NV15 (Geforce2 GTS) 
(rev a3)

>  In any case the code should not hang there in any case -- it the watchdog
> appears stuck, it reports it and goes on.  A hang almost surely means
> hardware locked up.

Yes, but why only with the 2.4.x kernels. I am using a 2.2.17 smp kernel 
without problems.

Regards,
Matthias
