Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262425AbTKEAIK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 19:08:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262443AbTKEAIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 19:08:10 -0500
Received: from top-elite.org ([217.160.94.140]:9184 "EHLO
	p15094795.pureserver.de") by vger.kernel.org with ESMTP
	id S262425AbTKEAIF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 19:08:05 -0500
Date: Wed, 5 Nov 2003 00:48:28 +0100
From: Klaus Umbach <Klaus.Umbach@doppelhertz.homelinux.org>
To: linux-kernel@vger.kernel.org
Subject: ide-scsi and SMP does not work together.
Message-ID: <20031104234828.GA1641@DualPrinzip>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Support Center :-)

Since I have 2 CPUs on my mainboard and compiled the SMP-support in, I
cannot use ide-scsi anymore. I guess it must have something to do with
apic, because when I use "Local APIC support on uniprocessors", I have
the same problem. With no SMP and no local APIC everything works fine.
(except the second CPU, of course). Normal ide-cdrom support works, but
recording CDs over atapi is not really what I want at the moment.

Mainboard: MSI 694D pro

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 10)

Linux 2.4.22

Nov  5 00:09:28 DualPrinzip kernel: scsi0 : SCSI host adapter emulation for IDE ATAPI devices
Nov  5 00:11:05 DualPrinzip kernel: hda: packet command error: status=0x51 { DriveReady SeekComplete Error }
Nov  5 00:11:05 DualPrinzip kernel: hda: packet command error: error=0x54
Nov  5 00:11:05 DualPrinzip kernel: ATAPI device hda:
Nov  5 00:11:05 DualPrinzip kernel:   Error: Illegal request -- (Sense key=0x05)
Nov  5 00:11:05 DualPrinzip kernel:   Invalid field in command packet -- (asc=0x24, ascq=0x00)
Nov  5 00:11:05 DualPrinzip kernel:   The failed "Mode Sense 10" packet command was: 
Nov  5 00:11:05 DualPrinzip kernel:   "5a 00 30 00 00 00 00 00 02 00 00 00 "
Nov  5 00:11:05 DualPrinzip kernel: hda: packet command error: status=0x51 { DriveReady SeekComplete Error }
Nov  5 00:11:05 DualPrinzip kernel: hda: packet command error: error=0x54
Nov  5 00:11:05 DualPrinzip kernel: ATAPI device hda:
Nov  5 00:11:05 DualPrinzip kernel:   Error: Illegal request -- (Sense key=0x05)
Nov  5 00:11:05 DualPrinzip kernel:   Invalid field in command packet -- (asc=0x24, ascq=0x00)
Nov  5 00:11:05 DualPrinzip kernel:   The failed "Mode Sense 10" packet command was: 
Nov  5 00:11:05 DualPrinzip kernel:   "5a 00 30 00 00 00 00 00 08 00 00 00 "

Best regards
	Klaus

--
Klaus Umbach <Klaus.Umbach@doppelhertz.homelinux.org>
