Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318563AbSHEP4c>; Mon, 5 Aug 2002 11:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318589AbSHEP4b>; Mon, 5 Aug 2002 11:56:31 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:25813 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S318563AbSHEP4a>; Mon, 5 Aug 2002 11:56:30 -0400
Date: Mon, 5 Aug 2002 17:59:59 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Benson Chow <blc@q.dyndns.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: issues with 2.4.19 that didn't exist in 2.4.18...
In-Reply-To: <Pine.LNX.4.44.0208031903530.21857-100000@q.dyndns.org>
Message-ID: <Pine.NEB.4.44.0208051753330.27501-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Aug 2002, Benson Chow wrote:

> I got this new in 2.4.19, and my busmaster IDE doesn't work:
>
> ---------------
> pty: 256 Unix98 ptys configured
> Uniform Multi-Platform E-IDE driver Revision: 6.31
> ide: Assuming 33MHz system bus speed for PIO modes; override with
> idebus=xx
> ICH3M: IDE controller on PCI bus 00 dev f9
> PCI: Device 00:1f.1 not available because of resource collisions
> ICH3M: (ide_setup_pci_device:) Could not enable device.
> --------------
>
> lspci
> [...]
> 00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 41)
> 00:1f.0 ISA bridge: Intel Corp. 82801CAM ISA Bridge (LPC) (rev 01)
> 00:1f.1 IDE interface: Intel Corp. 82801CAM IDE U100 (rev 01)
> 00:1f.3 SMBus: Intel Corp. 82801CA/CAM SMBus (rev 01)
> 00:1f.6 Modem: Intel Corp. 82801CA/CAM AC'97 Modem (rev 01)
> [...]
>
> Yep, that's my IDE controller allright.
>
> The machine kept on crashing on me too before I could get this to even
> boot.  2.4.18 works fine and bmide works...
>
> Likely I have a broken bios or something, but something changed?

Could you apply the -ac4 patch [1] on top of 2.4.19 and check whether this
fixes your problem?

> Thanks,
>
> -bc

TIA
Adrian

[1] ftp://ftp.kernel.org/pub/linux/kernel/people/alan/linux-2.4/2.4.19/patch-2.4.19-ac4.gz

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

