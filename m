Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266689AbUHIOzD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266689AbUHIOzD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 10:55:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266687AbUHIOyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 10:54:45 -0400
Received: from ms-2.rz.RWTH-Aachen.DE ([134.130.3.131]:26280 "EHLO
	ms-dienst.rz.rwth-aachen.de") by vger.kernel.org with ESMTP
	id S266749AbUHIOuw convert rfc822-to-8bit (ORCPT
	<rfc822;Linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 10:50:52 -0400
Date: Mon, 09 Aug 2004 16:49:17 +0200
From: Alexander Gran <alex@zodiac.dnsalias.org>
Subject: Cannot burn without strace on 2.6.8-rc3-mm1
To: Linux-kernel@vger.kernel.org
Message-id: <200408091649.20180@zodiac.zodiac.dnsalias.org>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-15
Content-transfer-encoding: 8BIT
Content-disposition: inline
User-Agent: KMail/1.6.2
X-Ignorant-User: yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, thats strange:

Just switched form 2.6.7-mm5 to 2.6.8-rc3-mm1
However I cannot burn with cdrecord.
cdrecord -v dev=/dev/hdc -dao driveropts=burnfree 
-data /files/Pakete/KNOPPIX_V3.4-2004-05-17-DE.iso
gives:

alex@t40:~$ cdrecord -v dev=/dev/hdc -dao driveropts\=burnfree 
-data /files/Pakete/KNOPPIX_V3.4-2004-05-17-DE.iso
Cdrecord-Clone 2.01a34 (i686-pc-linux-gnu) Copyright (C) 1995-2004 Jörg 
Schilling
NOTE: this version of cdrecord is an inofficial (modified) release of cdrecord
      and thus may have bugs that are not present in the original version.
      Please send bug reports and support requests to 
<cdrtools@packages.debian.org>.
      The original author should not be bothered with problems of this 
version.

TOC Type: 1 = CD-ROM
scsidev: '/dev/hdc'
devname: '/dev/hdc'
scsibus: -2 target: -2 lun: -2
Warning: Open by 'devname' is unintentional and not supported.
Linux sg driver version: 3.5.27
Using libscg version 'schily-0.8'.
Driveropts: 'burnfree'
SCSI buffer size: 64512
cdrecord: Cannot allocate memory. Cannot get SCSI I/O buffer.

However 
strace cdrecord -v dev=/dev/hdc -dao driveropts=burnfree 
-data /files/Pakete/KNOPPIX_V3.4-2004-05-17-DE.iso
just works..Strange, um?
alex@t40:~$ lspci
0000:00:00.0 Host bridge: Intel Corp. 82855PM Processor to I/O Controller (rev 
03)
0000:00:01.0 PCI bridge: Intel Corp. 82855PM Processor to AGP Controller (rev 
03)
0000:00:1d.0 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) 
USB UHCI Controller #1 (rev 01)
0000:00:1d.1 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) 
USB UHCI Controller #2 (rev 01)
0000:00:1d.2 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) 
USB UHCI Controller #3 (rev 01)
0000:00:1d.7 USB Controller: Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB 2.0 
EHCI Controller (rev 01)
0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev 81)
0000:00:1f.0 ISA bridge: Intel Corp. 82801DBM LPC Interface Controller (rev 
01)
0000:00:1f.1 IDE interface: Intel Corp. 82801DBM (ICH4) Ultra ATA Storage 
Controller (rev 01)
0000:00:1f.3 SMBus: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) SMBus 
Controller (rev 01)
0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801DB/DBL/DBM 
(ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 01)
0000:00:1f.6 Modem: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 
Modem Controller (rev 01)
0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R250 Lf 
[Radeon Mobility 9000 M9] (rev 02)
0000:02:00.0 CardBus bridge: Texas Instruments PCI1520 PC card Cardbus 
Controller (rev 01)
0000:02:00.1 CardBus bridge: Texas Instruments PCI1520 PC card Cardbus 
Controller (rev 01)
0000:02:01.0 Ethernet controller: Intel Corp. 82540EP Gigabit Ethernet 
Controller (Mobile) (rev 03)
0000:02:02.0 Ethernet controller: Atheros Communications, Inc. AR5211 802.11ab 
NIC (rev 01)

kernel config:
http://zodiac.dnsalias.org/misc/config-2.6.8-rc3-mm1
dmesg:
http://zodiac.dnsalias.org/misc/dmesg-2.6.8-rc3-mm1

regards
Alex
-- 
Encrypted Mails welcome.
PGP-Key at http://zodiac.dnsalias.org/misc/pgpkey.asc | Key-ID: 0x6D7DD291

