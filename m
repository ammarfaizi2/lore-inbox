Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265157AbUFAT5h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265157AbUFAT5h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 15:57:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265195AbUFAT5h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 15:57:37 -0400
Received: from bgp01360964bgs.sandia01.nm.comcast.net ([68.35.68.128]:36494
	"EHLO orion.dwf.com") by vger.kernel.org with ESMTP id S265157AbUFAT5I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 15:57:08 -0400
Message-Id: <200406011956.i51JuYkD019999@orion.dwf.com>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4
To: reg@dwf.com
cc: linux-kernel@vger.kernel.org, reg@orion.dwf.com, linux@horizon.com
Subject: Re: Intel 875 Motherboard cant use 4GB of Memory. 
In-Reply-To: Message from reg@dwf.com 
   of "Tue, 01 Jun 2004 01:32:17 MDT." <200406010732.i517WHOm009984@orion.dwf.com> 
Mime-Version: 1.0
Date: Tue, 01 Jun 2004 13:56:34 -0600
From: reg@dwf.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> That could be PCI devices.  Some (particularly high-end video cards)
> take up a lot of address space, which comes straight out of the available
> 4 GB physical address space.
> 
> Check /proc/iomem.
>

OK, that leaves me more confused, and (to me) it still looks like a
BIOS problem rather than a greedy device.  Here is the /proc/iomem
with some decimal annotations: (as noted, there is 4x1GB of memory installed)

---

  00000000-0009fbff : System RAM
  0009fc00-0009ffff : reserved
  000a0000-000bffff : Video RAM area
  000c0000-000ccfff : Video ROM
  000f0000-000fffff : System ROM
  00100000-ae62ffff : System RAM                    1048576 - 2925723647
  00100000-002a2fff : Kernel code
  002a3000-003542ff : Kernel data
  ae630000-ae64180f : ACPI Non-volatile Storage
  ae641810-ae72ffff : System RAM
  ae730000-ae73ffff : ACPI Tables
  ae740000-ae7effff : ACPI Non-volatile Storage
  ae7f0000-ae7fffff : reserved
  ae800000-ae8003ff : 0000:00:1f.1               2927624192 - 2927625215
  aeb00000-eeafffff : PCI Bus #01                2930769920 - 4004511743 <<
  c0000000-cfffffff : 0000:01:00.1               3221225472 - 3489660927
  d0000000-dfffffff : 0000:01:00.0               3489660928 - 3758096383
  f0000000-f7ffffff : 0000:00:00.0               4026531840 - 4160749567
  fecf0000-fecf0fff : reserved
  fed20000-fed9ffff : reserved
  ff800000-ff8fffff : PCI Bus #01                4286578688 - 4287627263  
  ff8e0000-ff8effff : 0000:01:00.1
  ff8f0000-ff8fffff : 0000:01:00.0
  ff900000-ff9fffff : PCI Bus #02
  ff9e0000-ff9fffff : 0000:02:01.0
  ff9e0000-ff9fffff : e1000
  ffaffc00-ffafffff : 0000:00:1d.7
  ffaffc00-ffafffff : ehci_hcd

---
and here is the lspci

00:00.0 Host bridge: Intel Corp. 82875P Memory Controller Hub (rev 02)
00:01.0 PCI bridge: Intel Corp. 82875P Processor to AGP Controller (rev 02)
00:03.0 PCI bridge: Intel Corp. 82875P Processor to PCI to CSA Bridge (rev 02)
00:1d.0 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #1 (rev 
02)
00:1d.1 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #2 (rev 
02)
00:1d.2 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #3 (rev 
02)
00:1d.3 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #4 (rev 
02)
00:1d.7 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI 
Controller (rev 02)
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB/ER Hub interface to PCI 
Bridge (rev c2)
00:1f.0 ISA bridge: Intel Corp. 82801EB/ER (ICH5/ICH5R) LPC Bridge (rev 02)
00:1f.1 IDE interface: Intel Corp. 82801EB/ER (ICH5/ICH5R) Ultra ATA 100 
Storage Controller (rev
02)
00:1f.2 IDE interface: Intel Corp. 82801EB (ICH5) Serial ATA 150 Storage 
Controller (rev 02)
00:1f.3 SMBus: Intel Corp. 82801EB/ER (ICH5/ICH5R) SMBus Controller (rev 02)
01:00.0 VGA compatible controller: ATI Technologies Inc RV350 AR [Radeon 9600]
01:00.1 Display controller: ATI Technologies Inc RV350 AR [Radeon 9600] 
(Secondary)
02:01.0 Ethernet controller: Intel Corp. 82547EI Gigabit Ethernet Controller 
(LOM)
03:01.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 0a)
03:01.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 0a)
[
---

This still isnt making much sense to me, so if somone can explain why I
can only see a little over 2/3 of the installed memory, I would appreciate
it.

And of course, the original question, any workarround?

---

				Reg.Clemens
				reg@dwf.com



