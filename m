Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267466AbSLNHiA>; Sat, 14 Dec 2002 02:38:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267467AbSLNHh7>; Sat, 14 Dec 2002 02:37:59 -0500
Received: from newglider.melbpc.org.au ([203.12.152.9]:53517 "EHLO
	relay1.melbpc.org.au") by vger.kernel.org with ESMTP
	id <S267466AbSLNHh7> convert rfc822-to-8bit; Sat, 14 Dec 2002 02:37:59 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Bill Metzenthen <billm@melbpc.org.au>
To: linux-kernel@vger.kernel.org
Subject: Intel ICH4 ide not working for 2.4.19 and 2.4.20
Date: Sat, 14 Dec 2002 18:48:41 +1100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200212141848.41037.billm@melbpc.org.au>
X-RAVMilter-Version: 8.3.4(snapshot 20020706) (relay1)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a machine with a Gigabyte 8IEX motherboard.  This MB uses an Intel 845E 
chipset with an Intel ICH4.  I'm using a 2.4 GHz P4 with it, and 1 GByte of 
memory.

I have been using RedHat kernels, initially 2.4.18-14 from RedHat 8.0, which 
works o.k.

Then I tried some kernels from rawhide, first 2.4.19-0.pp18, then 
2.4.19.pp.20, and finally 2.4.20-0.pp.3.  These all failed to identify 
anything attached to the ide ports.

Finally, I grabbed a copy of the original 2.4.20 kernel sources, applied the 
2.4.20-ac2 patches, and compiled these with a similar config to that used by 
the RedHat kernels.  This failed in a similar way to the redhat kernels.

I don't have another machine hooked up to the serial port at the moment, but a 
hand copied version of the on-screen messages leading up the point of failure 
is:

Uniform Multi-Platform E-IDE driver Revision: 7.00beta-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 00:1f.1
PCI: Found IRQ 5 for device 00:1f.1
ICH4: chipset revision 1
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xcc00-0xcc07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xcc08-0xcc0f, BIOS settings: hdc:DMA, hdd:DMA

There is a delay of a second or two here while the ide devices are failed to 
be detected.  The boot process then continues until it fails because it 
cannot open the root device.

I've looked through the archives and there doesn't appear to be anyone else 
with this particular problem.  Does anyone have an idea about what I should 
do to fix my problem?

Bill

ps: apologies for sending a subscribe message to the list in error.
