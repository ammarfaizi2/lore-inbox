Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132567AbRAaUBe>; Wed, 31 Jan 2001 15:01:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132630AbRAaUB2>; Wed, 31 Jan 2001 15:01:28 -0500
Received: from mail09.voicenet.com ([207.103.0.35]:37366 "HELO
	mail09.voicenet.com") by vger.kernel.org with SMTP
	id <S132567AbRAaUBM>; Wed, 31 Jan 2001 15:01:12 -0500
Message-ID: <3A786F00.B9248616@voicenet.com>
Date: Wed, 31 Jan 2001 15:01:04 -0500
From: safemode <safemode@voicenet.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.19pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
CC: David Raufeisen <david@fortyoz.org>, Vojtech Pavlik <vojtech@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: VT82C686A corruption with 2.4.x
In-Reply-To: <Pine.LNX.4.10.10101310752060.155-100000@coffee.psychology.mcmaster.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Hahn wrote:

> >From what I gather this chipset on 2.4.x is only stable if you cripple just about everything that makes
> > it worth having (udma, 2nd ide channel  etc etc)  ?    does it even work when all that's done now or is
> > it fully functional?
>
> it seems to be fully functional for some or most people,
> with two, apparently, reporting major problems.
>
> my via (kt133) is flawless in 2.4.1 (a drive on each channel,
> udma enabled and in use) and has for all the 2.3's since I got it.

I'm wondering... Perhaps it's a problem motherboard specific.  I'm using the KA7 and saw pretty bad
problems (extreme fs corruption)  and bad latency. Perhaps the K7V and the KT7's dont have this problem.  I
dont see any of the problems with dma enabled on 2.2.x

Output of 2.2.19-pre7 lspci -v
  00:00.0 Host bridge: VIA Technologies, Inc. VT8371 [KX133] (rev 02)
        Flags: bus master, medium devsel, latency 0
        Memory at d0000000 (32-bit, prefetchable)
        Capabilities: [a0] AGP version 2.0

00:01.0 PCI bridge: VIA Technologies, Inc. VT8371 [KX133 AGP]  (prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, medium devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: d4000000-d7ffffff
        Prefetchable memory behind bridge: d8000000-d9ffffff
        Capabilities: [80] Power Management version 2

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 22)
        Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
        Flags: bus master, stepping, medium devsel, latency 0

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 10) (prog-if 8a [Master SecP PriP])
        Flags: bus master, medium devsel, latency 32
        I/O ports at d000
        Capabilities: [c0] Power Management version 2



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
