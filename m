Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268057AbUI1Vtu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268057AbUI1Vtu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 17:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268055AbUI1Vtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 17:49:33 -0400
Received: from [81.3.11.18] ([81.3.11.18]:52928 "EHLO mail.ku-gbr.de")
	by vger.kernel.org with ESMTP id S268054AbUI1VtD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 17:49:03 -0400
Date: Tue, 28 Sep 2004 23:48:58 +0200
From: Konstantin Kletschke <lists@ku-gbr.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2 Oops on IDE load
Message-ID: <20040928214857.GC7765@ku-gbr.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040928211116.GB7765@ku-gbr.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040928211116.GB7765@ku-gbr.de>
User-Agent: Mutt/1.5.6i
X-Spam-Score: 1.6
X-Spam-Report: Spam detection software, running on the system "kermit", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or block
	similar future email.  If you have any questions, see
	admin@mail.ku-gbr.de for details.
	Content preview:  Am 2004-09-28 23:11 +0200 schrieb Konstantin Kletschke:
	I am an idiot, it is an network related Oops when I read the decoded
	Oops correctly... > I wanted to try out 2.6.9-rc2 on my intel i865
	Chipset Computer and > realize, that it does hard freezes when IDE load
	occurs. For example an > "emerge sync" (using gentoo on it) triggers
	the freeze reliable. [...] 
	Content analysis details:   (1.6 points, 10.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[213.23.246.12 listed in dnsbl.sorbs.net]
	1.6 RCVD_IN_NJABL_DUL      RBL: NJABL: dialup sender did non-local SMTP
	[213.23.246.12 listed in combined.njabl.org]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2004-09-28 23:11 +0200 schrieb Konstantin Kletschke:

I am an idiot, it is an network related Oops when I read the decoded
Oops correctly...

> I wanted to try out 2.6.9-rc2 on my intel i865 Chipset Computer and
> realize, that it does hard freezes when IDE load occurs. For example an
> "emerge sync" (using gentoo on it) triggers the freeze reliable.

The Oops also occurs reliable when starting gtk-gnutella. I thought it
was related to IDE load because I thought gtk-gnutella also scans a
couple of (not really) ~600MB big files. But it also opens many network
connections to search for hosts on startup. So I thought its the high
IDE load because "emerge sync" rsyncs many (couple of 1000) files...

I use the onboard e1000 ethernet chip.

I updated pciutils and the unknown devices are gone:

0000:00:00.0 Host bridge: Intel Corp. 82845G/GL[Brookdale-G]/GE/PE DRAM Controller/Host-Hub Interface (rev 02)
0000:00:01.0 PCI bridge: Intel Corp. 82845G/GL[Brookdale-G]/GE/PE Host-to-AGP Bridge (rev 02)
0000:00:1d.0 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1 (rev 02)
0000:00:1d.1 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2 (rev 02)
0000:00:1d.2 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3 (rev 02)
0000:00:1d.7 USB Controller: Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB2 EHCI Controller (rev 02)
0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev 82)
0000:00:1f.0 ISA bridge: Intel Corp. 82801DB/DBL (ICH4/ICH4-L) LPC Interface Bridge (rev 02)
0000:00:1f.1 IDE interface: Intel Corp. 82801DB (ICH4) IDE Controller (rev 02)
0000:00:1f.3 SMBus: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) SMBus Controller (rev 02)
0000:01:00.0 VGA compatible controller: nVidia Corporation NV25 [GeForce4 Ti 4400] (rev a2)
0000:02:01.0 SCSI storage controller: Adaptec AHA-7850 (rev 03)
0000:02:03.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 06)
0000:02:04.0 Ethernet controller: Davicom Semiconductor, Inc. 21x4x DEC-Tulip compatible 10/100 Ethernet (rev 31)
0000:02:05.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 07)
0000:02:05.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 07)
0000:02:09.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 46)
0000:02:0a.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
0000:02:0d.0 Ethernet controller: Intel Corp. 82540EM Gigabit Ethernet Controller (rev 02)
0000:02:0e.0 RAID bus controller: Promise Technology, Inc. PDC20376 (FastTrak 376) (rev 02)

The davicom chip is not in use, its module is not loaded.

0000:02:0d.0 Ethernet controller: Intel Corp. 82540EM Gigabit Ethernet Controller (rev 02)
        Subsystem: Intel Corp. PRO/1000 MT Desktop Adapter
        Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 23
        Memory at dfec0000 (32-bit, non-prefetchable) [size=dfe40000]
        Memory at dfe60000 (32-bit, non-prefetchable) [size=128K]
        I/O ports at c000 [size=64]
        Expansion ROM at 00020000 [disabled]
        Capabilities: [dc] Power Management version 2
        Capabilities: [e4] PCI-X non-bridge device.
        Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-

Regards, Konsti

-- 
GPG KeyID EF62FCEF
Fingerprint: 13C9 B16B 9844 EC15 CC2E  A080 1E69 3FDA EF62 FCEF
