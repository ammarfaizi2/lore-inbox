Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbTIVWNx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 18:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261188AbTIVWNx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 18:13:53 -0400
Received: from mx.compgen.com.155.158.in-addr.arpa ([158.155.2.6]:11717 "EHLO
	mx.compgen.com") by vger.kernel.org with ESMTP id S261168AbTIVWNv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 18:13:51 -0400
From: Jesse Marlin <jesse.marlin@intec.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16239.29725.552855.718558@bass.compgen.com>
Date: Mon, 22 Sep 2003 18:13:49 -0400
To: linux-kernel@vger.kernel.org
Subject: Hard lockup with Gigabyte 7VTXE motherboard
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: jesse.marlin@intec.us
X-Face: FbxF/xY<F@|f.|JNG)lOL.T0@>!V>vZ.$FXyN9:*'ZV?cib-\o'fWz2=}_Pb!#.JveZp_T18ZKC5T0RXNN=~_HPOF<X-]))4v@k"zVg(BQ$WN/TLSiy(5.UsehDm6*kK`j]\va%pe}7xUvl/4I@Ce6HVFP/P}Y/|74^~rO-CYcTf6+~VwiO;O0%
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have recently started experiencing hard lockups when transferring
large files.  In particular a huge wave file destined for a CDROM.
I have no problems at all doing normal activities.  I tried in order
the following to make it stop:

1.  Recompiled with kernel 2.4.22.
2.  Turned off I/O APIC   (no luck)
3.  Turned off APIC with noapic option  (no luck)
4.  Updated BIOS.   (no luck)
5.  Turned off DMA for the drive.  (luck)

Turning off DMA seemed to cause it to stop locking up, but I started
seeing these I/O storms where it would take a while to read or write
instead of locking up.  I recently purchased a new hard drive
(Seagate 120GB), but I had been using the drive fine until suddenly
it started happening.  It obviously has something to do with DMA, but
should it be locking up.  Shouldn't the kernel turn off DMA on the
drive if it has problems?

I had another Seagate drive appear to go bad on me within about 3
months.  It was also completely DMA related.  I am wondering if it
was the drive or this VIA chipset causing the problem.  Could there
be something wrong with this board that is causing the drives to go
south prematurely?  Or is there a problem with the chipset?  I have
not seen these problems until fairly recently.

I am not subscribed to the list so could any responses be CC'd to me
directly.  Thanks for any help.

Here is the output from lspci:

00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333]
00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333 AGP]
00:0a.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 07)
00:0a.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 07)
00:0b.0 Ethernet controller: Lite-On Communications Inc LNE100TX [Linksys EtherFast 10/100] (rev 25)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8233 PCI to ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus Master IDE (rev 06)
00:11.2 USB Controller: VIA Technologies, Inc. USB (rev 1b)
00:11.3 USB Controller: VIA Technologies, Inc. USB (rev 1b)
00:11.4 USB Controller: VIA Technologies, Inc. USB (rev 1b)
00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233 AC97 Audio Controller (rev 30)
01:00.0 VGA compatible controller: nVidia Corporation NV20 [GeForce3] (rev a3)
