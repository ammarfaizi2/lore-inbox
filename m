Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265083AbUEUWlE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265083AbUEUWlE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 18:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264828AbUEUWkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 18:40:24 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:14794 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S266090AbUEUWdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 18:33:09 -0400
From: "R. J. Wysocki" <rjwysocki@sisk.pl>
Organization: SiSK
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.6-mm4 and failing SATA drive
Date: Fri, 21 May 2004 23:53:28 +0200
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405212353.28845.rjwysocki@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Seemingly, I'm having a problem with one of my SATA drives.  It is connected 
via a SII3114 chip (on-board) and worked just fine until a couple of hours 
ago when I tried to scp ~700 MB of data to it.  Then, the process handling 
that request hung in a kernel code (ie. became unkillable with -9) and I got 
this in the log:

May 21 22:26:31 chimera kernel: ata1: DMA timeout, stat 0x61
May 21 22:26:31 chimera kernel: ATA: abnormal status 0xD8 on port 
0xFFFFFF0000655C87
May 21 22:26:31 chimera kernel: scsi1: ERROR on channel 0, id 0, lun 0, CDB: 
Write (10) 00 03 2a 14 17 00 02 58 00 
May 21 22:26:31 chimera kernel: Current sdc: sense key Medium Error
May 21 22:26:31 chimera kernel: Additional sense: Write error - auto 
reallocation failed
May 21 22:26:31 chimera kernel: end_request: I/O error, dev sdc, sector 
53089303
May 21 22:26:31 chimera kernel: ATA: abnormal status 0xD8 on port 
0xFFFFFF0000655C87
May 21 22:26:31 chimera last message repeated 2 times

So, there probably is a hardware problem, but:

1) can you, please, tell me what _exactly_ this means,

2) after it had happened I was unable to do anything with the partition in 
question and I couldn't reboot the machine softly (SysRq+S did not work too) 
so I had to use the red button to get around it (_bad_ thing, IMO).

Well, I would like the kernel to behave more "nicely" in such cases, if 
possible.  In other words, there should be a way to get around a failing 
piece of equipment without rebooting the machine (I know it may be impossible 
but this is not the case, AFAICS).

The kernel is a 2.6.6-mm4 and my box is a dual Opteron.

If you need any more information, just let me know.

Yours,
RJW

-- 
Rafael J. Wysocki,
SiSK
[tel. (+48) 605 053 693]
----------------------------
For a successful technology, reality must take precedence over public 
relations, for nature cannot be fooled.
					-- Richard P. Feynman
