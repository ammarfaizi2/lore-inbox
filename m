Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932115AbWCGTcE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbWCGTcE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 14:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932247AbWCGTcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 14:32:04 -0500
Received: from c-68-35-68-128.hsd1.nm.comcast.net ([68.35.68.128]:140 "EHLO
	deneb.dwf.com") by vger.kernel.org with ESMTP id S932115AbWCGTcC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 14:32:02 -0500
Message-Id: <200603071932.k27JW0UH003735@deneb.dwf.com>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
To: "Randy.Dunlap" <rdunlap@xenotime.net>
cc: Reg Clemens <reg@dwf.com>, rlrevell@joe-job.com,
       linux-kernel@vger.kernel.org
Subject: Re: vmlinuz-2.6.16-rc5-git8 still nogo with Intel D945 Motherboard 
In-reply-to: <20060307104646.9b2e193d.rdunlap@xenotime.net> 
References: <200603070340.k273ev0A003594@deneb.dwf.com> 
 <1141703317.25487.142.camel@mindpipe> <200603070823.k278NE9o006674@deneb.dwf.com> <20060307081806.0af1d2c4.rdunlap@xenotime.net> <200603071820.k27IKSsm003595@deneb.dwf.com> <20060307104646.9b2e193d.rdunlap@xenotime.net>
Comments: In-reply-to "Randy.Dunlap" <rdunlap@xenotime.net>
   message dated "Tue, 07 Mar 2006 10:46:46 -0800."
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 07 Mar 2006 12:32:00 -0700
From: Reg Clemens <reg@dwf.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> Both boot logs contains the Cannot messages.

Hadn't noticed that, since it worked, I hadnt looked that carefully, sorry.

> The "bad" log also contains:
> Mar  7 10:58:41 deneb kernel: PCI: Failed to allocate mem resource #6:20000@48000000 for 0000:01:00.0
> 

Yep.

> Is device 0:01:00.0 your Nvidia video card?
> Is there an updated NVRM driver for it (guessing from your OK boot log)
> for 2.6.15 or later?

Yes, I am running with the NVIDIA
    NVIDIA-Linux-x86-1.0-6629-pkg1.run
driver, tho the 'nv' in the system works.

> 
> I suppose an lspci might help.  I dunno.

---

Here is the lspci, run from 2.6.11, but I dont think that should matter...

[root@deneb reg]# /sbin/lspci
00:00.0 Host bridge: Intel Corporation 945G/P Memory Controller Hub (rev 02)
00:01.0 PCI bridge: Intel Corporation 945G/P PCI Express Graphics Port (rev 02)
00:1b.0 Class 0403: Intel Corporation 82801G (ICH7 Family) High Definition 
Audio Controller (rev 01)
00:1c.0 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 1 
(rev 01)
00:1c.2 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 3 
(rev 01)
00:1c.3 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 4 
(rev 01)
00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #1 
(rev 01)
00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #2 
(rev 01)
00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #3 
(rev 01)
00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #4 
(rev 01)
00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2 EHCI 
Controller (rev 01)
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev e1)
00:1f.0 ISA bridge: Intel Corporation 82801GB/GR (ICH7 Family) LPC Interface 
Bridge (rev 01)
00:1f.1 IDE interface: Intel Corporation 82801G (ICH7 Family) IDE Controller 
(rev 01)
00:1f.2 IDE interface: Intel Corporation 82801GB/GR/GH (ICH7 Family) Serial 
ATA Storage Controllers cc=IDE (rev 01)
00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus Controller (rev 01)
01:00.0 VGA compatible controller: nVidia Corporation NV43 [GeForce 6600] (rev 
a2)
05:01.0 SCSI storage controller: LSI Logic / Symbios Logic 53c875 (rev 04)
05:02.0 Multimedia audio controller: Creative Labs SB Audigy LS
05:03.0 Ethernet controller: D-Link System Inc Gigabit Ethernet Adapter (rev 
11)

---

Did you notice that the following three pnp messages talk about the same
memory ranges, but different devices (5 vs 6), 

Mar  7 11:02:21 deneb kernel: PCI: Cannot allocate resource region 1 of device 
0000:05:01.0
Mar  7 11:02:21 deneb kernel: PCI: Cannot allocate resource region 2 of device 
0000:05:01.0
Mar  7 11:02:21 deneb kernel: pnp: 00:05: ioport range 0x500-0x53f has been 
reserved
Mar  7 11:02:21 deneb kernel: pnp: 00:05: ioport range 0x400-0x47f could not 
be reserved
Mar  7 11:02:21 deneb kernel: pnp: 00:05: ioport range 0x680-0x6ff has been 
reserved

---

Mar  7 10:58:41 deneb kernel: PCI: Cannot allocate resource region 1 of device 
0000:05:01.0
Mar  7 10:58:41 deneb kernel: PCI: Cannot allocate resource region 2 of device 
0000:05:01.0
Mar  7 10:58:41 deneb kernel: pnp: 00:06: ioport range 0x500-0x53f has been 
reserved
Mar  7 10:58:41 deneb kernel: pnp: 00:06: ioport range 0x400-0x47f could not 
be reserved
Mar  7 10:58:41 deneb kernel: pnp: 00:06: ioport range 0x680-0x6ff has been 
reserved
Mar  7 10:58:41 deneb kernel: PCI: Failed to allocate mem resource 
#6:20000@48000000 for 0000:01:00.0

-- 
Im not sure what the significance of that is, just noticed the difference.


                                      Reg.Clemens
                                        reg@dwf.com


