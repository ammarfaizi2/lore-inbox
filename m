Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261393AbUCASS7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 13:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261395AbUCASS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 13:18:59 -0500
Received: from mail.fdk-filmhaus.de ([212.184.83.66]:24037 "EHLO
	mail.fdk-filmhaus.de") by vger.kernel.org with ESMTP
	id S261393AbUCASSv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 13:18:51 -0500
Message-ID: <57977.212.184.83.69.1078165110.squirrel@mail.fdk-filmhaus.de>
Date: Mon, 1 Mar 2004 19:18:30 +0100 (CET)
Subject: 2.6.2: drm:drm_init Cannot initialize the agpgart module
From: "Christoph Terhechte" <ct@fdk-berlin.de>
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Under 2.4.22 I used to load the "agpgart" and "mga" modules to provide DRI
support for XFree86. My graphics card is a Matrox G550 AGP.

Under 2.6.2 this fails. I can load the "agpgart" module, but "mga" refuses
to load. The message on stderr is:

FATAL: Error inserting mga
(/lib/modules/2.6.2/kernel/drivers/char/drm/mga.ko): Invalid argument

In /var/log/kern.log I find:

[drm:drm_init] *ERROR* Cannot initialize the agpgart module.

There was a hint on this list that "intel_agp" should be loaded, too. I
have a VIA based board, so I tried "via_agp". It loads alright, but the
outcame is the same (and it was unnecessary under 2.4.22 anyway).

Any idea what might have changed from kernel 2.4 to 2.6?


Here's my system's lspci output:

00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 [IGD4-1P] System
Controller (rev 13)
00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-760 [IGD4-1P] AGP Bridge
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South]
(rev 40)
00:07.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 06)
00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 16)
00:07.3 USB Controller: VIA Technologies, Inc. USB (rev 16)
00:07.4 SMBus: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
00:09.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 08)
00:0a.0 SCSI storage controller: LSI Logic / Symbios Logic 53c875 (rev 26)
00:0b.0 Multimedia video controller: Brooktree Corporation Bt878 Video
Capture (rev 11)
00:0b.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture
(rev 11)
00:0c.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado]
(rev 74)
00:0e.0 Unknown mass storage controller: Triones Technologies, Inc.
HPT366/368/370/370A/372 (rev 04)
01:05.0 VGA compatible controller: Matrox Graphics, Inc. MGA G550 AGP (rev
01)

-- 
Christoph Terhechte <ct@fdk-berlin.de>
International Forum of New Cinema
Potsdamer Strasse 2
D-10785 Berlin
Tel: +49-30-269.55.200
Fax: +49-30-269.55.222

