Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280361AbRJaRsc>; Wed, 31 Oct 2001 12:48:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280360AbRJaRsW>; Wed, 31 Oct 2001 12:48:22 -0500
Received: from cs666840-116.austin.rr.com ([66.68.40.116]:38385 "EHLO
	kinison.puremagic.com") by vger.kernel.org with ESMTP
	id <S280361AbRJaRsL>; Wed, 31 Oct 2001 12:48:11 -0500
Date: Wed, 31 Oct 2001 11:48:48 -0600 (CST)
From: Evan Harris <eharris@puremagic.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Question about 2.4.x old aic7xxx scsi driver and command timeouts.
  Corruption?
Message-ID: <Pine.LNX.4.33.0110311142150.7858-100000@kinison.puremagic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I added an Adaptec 2940U2W adapter and several fast scsi drives to a linux
system and upgraded to the latest stock 2.4.13 kernel.  I tried using the
newer aic7xxx driver, but since my bus occasionally has command timeouts, I
went back to the older driver, as the newer one handles them less
gracefully.

But, I occasionally get syslog messages like:

scsi : aborting command due to timeout : pid 2811297, scsi0, channel 0, id
4, lun 0 Write (10) 00 01 82 7d 3a 00 02 00 00
scsi : aborting command due to timeout : pid 2811302, scsi0, channel 0, id
4, lun 0 Write (10) 00 01 82 7f 3a 00 02 00 00
scsi : aborting command due to timeout : pid 2811303, scsi0, channel 0, id
12, lun 0 Write (10) 00 02 9e 16 ef 00 00 20 00
scsi : aborting command due to timeout : pid 2811304, scsi0, channel 0, id
0, lun 0 Read (10) 00 01 8c 38 88 00 01 00 00

Other than the syslog and console message everything seems to be fine other
than a few second pause when it happens.

My question is, in the old driver, when this happens, should I be worried
about data loss or corruption, or does the scsi-layer automatically reissue
the timed out command?

Evan

