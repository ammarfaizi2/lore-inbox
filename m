Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263016AbSJGMoj>; Mon, 7 Oct 2002 08:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263014AbSJGMoj>; Mon, 7 Oct 2002 08:44:39 -0400
Received: from mta01ps.bigpond.com ([144.135.25.133]:57067 "EHLO
	mta01ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S263016AbSJGMoi>; Mon, 7 Oct 2002 08:44:38 -0400
Message-ID: <3DA1835B.9AC0E418@bigpond.com>
Date: Mon, 07 Oct 2002 22:51:39 +1000
From: Allan Duncan <allan.d@bigpond.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.20-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: IDE-SCSI kernel param hangs 2.4.20-pre8-ac3 and 2.5.40
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In order to write CD's I need to use IDE-SCSI, but when playing DVD's
(yes, it does both) I want to use the IDE interface, so my boot is set
to normally use IDE, but with the "hdd=ide-scsi" parameter I get SCSI.

This works fine up to and including 2.4.20-pre9, but any of the recent
2.4 -ac variants, and 2.5.40 (and maybe earlier) hang on the lattee just
after the enabling of swap space.  Normally the console would next note
that the hard drive parameters are being set, followed by
 "Entering run level: 3".

I get no logs written to disk at this point, and even the ATX power-off
button is inactive.  If you reboot the ext3 journalling does its thing,
and no trace exists of the entire aborted boot.

I've disabled all setting of hard disk stuff, (rc.sysinit already disables
CDROM DMA some time prior to the hang), but no change.

My system has the HD on a Promise card, and the CDROM, DVD on the motherboard
(Epox 8KHA+, VIA 266A chipset) IDE ports, but I get the same results putting
the HD on the VIA port (the Promise bios then doesn't load).

The kernel .config for 2.4.20-pre8 and 2.4.20-pre8-ac3 have no obvious variations
in the IDE etc region.

Pointers welcomed on how to proceed.
