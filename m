Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318342AbSIFF1S>; Fri, 6 Sep 2002 01:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318333AbSIFF1S>; Fri, 6 Sep 2002 01:27:18 -0400
Received: from rom.cscaper.com ([216.19.195.129]:60865 "HELO mail.cscaper.com")
	by vger.kernel.org with SMTP id <S318314AbSIFF1R>;
	Fri, 6 Sep 2002 01:27:17 -0400
Subject: Summary of kt333a woes, with happy ALi ending
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
From: "Joseph N. Hall" <joseph@5sigma.com>
Content-Type: text/plain; charset=US-ASCII
Mime-version: 1.0
Date: Thu, 5 Sep 2002 22:33 -0700
X-mailer: Mailer from Hell v1.0
Message-Id: <20020906052717Z318314-685+43734@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also FYI: the Soyo Dragon Ultra Platinum m/b never did give me proper
DMA performance on my ATAPI devices.  I tried:

  stock RH 7.3 kernel
  2.4.19
  2.4.20-pre5-ac1

The stock kernel might not have had proper DMA support at all; I 
upgraded to 2.4.19 quickly for other reasons.  The most obvious problem
with 2.4.19 and 2.4.20-pre5-ac1 was that my IDE DVD-R/RAM/ROM device
did not do DMA, ever, and when forced to attempt DMA the machine eventually
locked, with no error messages that I ever saw.  It works fine with
my new Iwill m/b:

[joseph@dhcppc5 ticket]# hdparm -I /dev/hdd

/dev/hdd:

ATAPI CD-ROM, with removable media
        Model Number:           MATSHITADVD-RAM LF-D310
        Serial Number:
        Firmware Revision:      A123
Standards:
Configuration:
        DRQ response: 50us.
        Packet size: 12 bytes
Capabilities:
        LBA, IORDY(can be disabled)
        DMA: sdma0 sdma1 sdma2 mdma0 mdma1 mdma2 udma0 udma1 *udma2
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=180ns  IORDY flow control=120ns

Nor did other ATAPI devices do DMA--I tried a generic CDROM and
an ASUS CDR/RW/ROM.  I saw the same behavior when the ATAPI devices
were plugged into the Highpoint controller.

Also HD access seemed slow at times, and there would occasionally be
mysteriously long pauses of a few sec during kernel compiles etc. where
it seemed that some sort of I/O blocking was going on.

I observed similar behavior in Win2k but ... I don't know that I ever
got a proper set of drivers installed.  All I know is that with the
IWill m/b (ALi chipset) everything is working OK.  I did not get 
proper DVD playback on Win2k--it seemed exactly the same slowness
as with Linux.

OTOH my DVDs play fine off the drive from mplayer now, and I can read
and write at appropriate speeds.

I would like to get the kt333a m/b working eventually, because I don't
think my IWill m/b will support the new core Athlons.  I suspect that
the board "works" but there must be a BIOS or chipset issue that isn't
resolved.

  -joseph

