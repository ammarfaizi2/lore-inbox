Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318602AbSH1DUC>; Tue, 27 Aug 2002 23:20:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318607AbSH1DUC>; Tue, 27 Aug 2002 23:20:02 -0400
Received: from alta.whitings.org ([65.169.182.99]:8105 "EHLO whitings.org")
	by vger.kernel.org with ESMTP id <S318602AbSH1DUB>;
	Tue, 27 Aug 2002 23:20:01 -0400
Date: Tue, 27 Aug 2002 22:24:47 -0500
From: Peter Whiting <pete@sprint.net>
To: linux-kernel@vger.kernel.org
Subject: tx problem on Biostar M7VKQ (VT8361 chipset)
Message-ID: <20020828032447.GA31437@sprint.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just installed linux on a biostar M7VKQ and am having trouble
with ethernet packets not making it to the wire. I've removed
everything from the data path (down to a crossover cable now)
and running tcpdump on both ends shows the biostar box sending
packets that occasionally don't show up in the tcpdump on the
other end. When it happens it happens to 5-6 packets in a row,
which, in the case of a large data transfer stalls tcp until it's
retransmit timers kick in.

The loss only happens when the biostar box is one of the
endpoints. I am currently using 2.4.18-11 (redhat null beta) on
the rig. I booted with an older kernel and saw the same behavior.
I disabled the onboard ethernet adapter and slapped in a spare -
the results were similar (though slightly better). End result: I
can't push more than 3-4 Mb/s through the box - ftp or scp.

The motherboard uses a VIA chipset:
00:00.0 Host bridge: VIA Technologies, Inc. VT8361 [KLE133] Host Bridge
00:01.0 PCI bridge: VIA Technologies, Inc. VT8361 [KLE133] AGP Bridge
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
00:07.1 IDE interface: VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE (rev 06)
00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 1a)
00:07.3 USB Controller: VIA Technologies, Inc. USB (rev 1a)
00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 AC97 Audio Controller (rev 50)
00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C (rev 10)
01:00.0 VGA compatible controller: Trident Microsystems CyberBlade/i1

I've seen some discussion of the VT8361 on the list in the
past, but my issue appears to be somewhat different. Any
suggestions/recommendations are appreciated.

cheers,
pete
