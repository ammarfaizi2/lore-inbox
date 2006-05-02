Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964800AbWEBNHU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964800AbWEBNHU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 09:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964803AbWEBNHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 09:07:20 -0400
Received: from mail.charite.de ([160.45.207.131]:56281 "EHLO mail.charite.de")
	by vger.kernel.org with ESMTP id S964800AbWEBNHT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 09:07:19 -0400
Date: Tue, 2 May 2006 15:07:11 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: hdc: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Message-ID: <20060502130711.GW11742@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# uname -a
Linux tabuleh 2.6.16.9 #1 PREEMPT Wed Apr 19 21:19:01 CEST 2006 i686 GNU/Linux

For quite some time I'm getting this in my log:

May  2 14:09:08 tabuleh kernel: hdc: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
May  2 14:26:43 tabuleh kernel: hdc: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
May  2 14:46:20 tabuleh kernel: hdc: cdrom_pc_intr: The drive appears confused (ireason = 0x01)

# dmesg|grep hdc

ide1: BM-DMA at 0xcfa8-0xcfaf, BIOS settings: hdc:DMA, hdd:pio
hdc: TOSHIBA DVD-ROM SD-R2102, ATAPI CD/DVD-ROM drive
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
hdc: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
...

# smartctl -a /dev/hdc
smartctl version 5.36 [i686-pc-linux-gnu] Copyright (C) 2002-6 Bruce Allen
Home page is http://smartmontools.sourceforge.net/

=== START OF INFORMATION SECTION ===
Device Model:     TOSHIBA DVD-ROM SD-R2102
Serial Number:    623E128663
Firmware Version: 1317
Device is:        Not in smartctl database [for details use: -P showall]
ATA Version is:   5
ATA Standard is:  ATA/ATAPI-5 T13 1321D revision 3
Local Time is:    Tue May  2 15:06:01 2006 CEST
SMART support is: Unavailable - Packet Interface Devices [this device: CD/DVD] don't support ATA SMART
A mandatory SMART command failed: exiting. To continue, add one or more '-T permissive' options.

-- 
Ralf Hildebrandt (i.A. des IT-Zentrums)         Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-962
IT-Zentrum Standort CBF                 send no mail to spamtrap@charite.de
