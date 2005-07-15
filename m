Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263159AbVGOCSW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263159AbVGOCSW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 22:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263181AbVGOCPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 22:15:45 -0400
Received: from natfrord.rzone.de ([81.169.145.161]:6819 "EHLO
	natfrord.rzone.de") by vger.kernel.org with ESMTP id S263117AbVGOCPd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 22:15:33 -0400
Subject: Re: sata_sil 3112 activity LED patch
From: Christian Kroll <christian.kroll@bglug.org>
To: linux-kernel@vger.kernel.org
Cc: acyr@alumni.uwaterloo.ca
Content-Type: text/plain
Date: Fri, 15 Jul 2005 04:15:12 +0200
Message-Id: <1121393712.4770.6.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

I have tested the patch against my DawiControl DC-150 RAID controller
which is basically an add-on card with a SiI 3112 ASIC and a flash ROM.
The activity LED of my case is directly connected to the add-on card.

Unfortunately your patch doesn't have any effect on the LED. The
activity LED gets turned on by the card's BIOS at boot time and
continues to shine until I shut down the computer.
On the other hand it did not erase my Flash ROM and I haven't spotted
any data loss so far.

The LED does work as expected under that other OS as soon as Silicon
Image's reference driver is loaded, hence it is connected correctly.

Test setup:
I'm using DawiControl's version of the BIOS and not the reference BIOS
of Silicon Image. The test system is a Tualatin Celeron 1400 with an
i440BX based mainboard. The following hard disk is connected to the
controller: Seagate ST3160827AS (native SATA interface). The sata_sil
driver is loaded as a module.
Test kernel is vanilla 2.6.12.2. No tainted modules were used
while doing these tests.

If you require more information, don't hesitate to contact me.

Regards
Christian Kroll

- --
Christian Kroll <christian dot kroll at bglug dot org>
GnuPG Fingerprint: DA5D 5BFA 5C95 FD09 2A72  517E 10CB DCD5 71ED 7E35

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC1xsQEMvc1XHtfjURAqKQAJ0fp5EtdymeUsiklcqYsCR9Q7VyngCeIfKV
Sb/wTjlvfk6MPMk/KEBkBPY=
=g7Vc
-----END PGP SIGNATURE-----


