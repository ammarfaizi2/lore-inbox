Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbTESJKL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 05:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbTESJKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 05:10:11 -0400
Received: from mail1.uk.neceur.com ([193.116.254.3]:10138 "EHLO
	mail1.uk.neceur.com") by vger.kernel.org with ESMTP id S261797AbTESJKI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 05:10:08 -0400
To: linux-kernel@vger.kernel.org
Subject: System catatonic with ASUS + 2.4.21rc2
MIME-Version: 1.0
X-Mailer: Lotus Notes Build V65_M1_04032003NP April 03, 2003
Message-ID: <OF7E5E6CC4.B146B955-ON80256D2B.00336725-80256D2B.00338396@uk.neceur.com>
From: ross.alexander@uk.neceur.com
Date: Mon, 19 May 2003 10:22:39 +0100
X-MIMETrack: Serialize by Router on LDN-THOTH/E/NEC(Release 5.0.10 |March 22, 2002) at
 05/19/2003 10:22:40 AM,
	Serialize complete at 05/19/2003 10:22:40 AM,
	Itemize by SMTP Server on ldn-hermes/E/NEC(Release 5.0.10 |March 22, 2002) at
 05/19/2003 10:22:41 AM,
	Serialize by Router on ldn-hermes/E/NEC(Release 5.0.10 |March 22, 2002) at
 05/19/2003 10:22:49 AM,
	Serialize complete at 05/19/2003 10:22:49 AM
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sven, 

Both Forrest and myself have very similar problems with 
the system just completely freezing ie kernel goes catatonic. 

Originally I though this was because of a bug in the AIC7xxx 
driver but I have had my system lock up during a file system 
check (after rebooting from a previous lockup :-(. 

The SCSI driver is a module so that isn't to be faulted (but the 
card could be).  My (very unscientific) conclusion is that it 
probably is a bug in the kernel interrupt handling code.  It 
does tend to happen much more often under high IDE loads, 
for example CD ripping or file system checking so it could 
be getting an interrupt while still dealing with a previous disk 
interrupt but I could well be talking bullsh*t.  Things I haven't 
yet tried include disabling the SATA chipset and pulling 
out the PCI ethernet card (since I don't actually need it 
any more as linux-2.4.21 supports the builtin 3Com device). 

For the mailing list here is my system details. 

Processor: AMD 2800+. 
Motherboard: AUS A7N8X Deluxe 
Chipset: nforce2 SPP + MCP2-T 
Memory: 1.5GB (3 x 512MB) 
Kernel: 2.4.21rc2

00:00.0 Host bridge: nVidia Corporation: Unknown device 01e0 (rev c1) 
00:00.1 RAM memory: nVidia Corporation: Unknown device 01eb (rev c1) 
00:00.2 RAM memory: nVidia Corporation: Unknown device 01ee (rev c1) 
00:00.3 RAM memory: nVidia Corporation: Unknown device 01ed (rev c1) 
00:00.4 RAM memory: nVidia Corporation: Unknown device 01ec (rev c1) 
00:00.5 RAM memory: nVidia Corporation: Unknown device 01ef (rev c1) 
00:01.0 ISA bridge: nVidia Corporation nForce2 ISA Bridge (rev a4) 
00:01.1 SMBus: nVidia Corporation nForce2 SMBus (MCP) (rev a2) 
00:02.0 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4) 

00:02.1 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4) 

00:02.2 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4) 

00:04.0 Ethernet controller: nVidia Corporation nForce2 Ethernet 
Controller (rev a1) 
00:05.0 Multimedia audio controller: nVidia Corporation nForce MultiMedia 
audio [Via VT82C686B] (rev a2) 
00:06.0 Multimedia audio controller: nVidia Corporation nForce2 AC97 Audio 
Controler (MCP) (rev a1) 
00:08.0 PCI bridge: nVidia Corporation: Unknown device 006c (rev a3) 
00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2) 
00:0c.0 PCI bridge: nVidia Corporation: Unknown device 006d (rev a3) 
00:0d.0 FireWire (IEEE 1394): nVidia Corporation nForce2 FireWire (IEEE 
1394) Controller (rev a3) 
00:1e.0 PCI bridge: nVidia Corporation nForce2 AGP (rev c1) 
01:07.0 SCSI storage controller: Adaptec AHA-2940U2/U2W 
01:08.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] 
(rev 74) 
01:0a.0 VGA compatible controller: Matrox Graphics, Inc. MGA 2064W 
[Millennium] (rev 01) 
01:0b.0 RAID bus controller: CMD Technology Inc Silicon Image SiI 3112 
SATARaid Controller (rev 02) 
02:01.0 Ethernet controller: 3Com Corporation 3C920B-EMB Integrated Fast 
Ethernet Controller (rev 40) 

---------------------------------------------------------------------------------
Ross Alexander                           "We demand clearly defined
MIS - NEC Europe Limited            boundaries of uncertainty and
Work ph: +44 20 8752 3394         doubt."
