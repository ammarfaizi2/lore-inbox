Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265543AbTAFAXM>; Sun, 5 Jan 2003 19:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265564AbTAFAXM>; Sun, 5 Jan 2003 19:23:12 -0500
Received: from smtp06.iddeo.es ([62.81.186.16]:15280 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id <S265543AbTAFAXL>;
	Sun, 5 Jan 2003 19:23:11 -0500
Date: Mon, 6 Jan 2003 01:31:45 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: Paul Rolland <rol@witbe.net>, linux-kernel@vger.kernel.org
Subject: Re: [2.5.54] Oops IDE-SCSI and failure AIC7xxx
Message-ID: <20030106003145.GC2462@werewolf.able.es>
References: <013901c2b4f4$af8c42a0$2101a8c0@witbe> <547740000.1041797991@aslan.scsiguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <547740000.1041797991@aslan.scsiguy.com>; from gibbs@scsiguy.com on Sun, Jan 05, 2003 at 21:19:51 +0100
X-Mailer: Balsa 2.0.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2003.01.05 Justin T. Gibbs wrote:
> > I've been looking at the PCI option in the BIOS...
> 
> ...
> 
> > Could it be PCI 2.1 Support ? Don't think because I've restarted
> > with it disabled, and I still have the same problem...
> 
> No.  That shouldn't make a difference.
> 

I also get this on a SuperMicro P6DGU:

SCSI subsystem driver Revision: 1.00
aic7xxx: PCI Device 0:14:0 failed memory mapped test.  Using PIO.
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.25
        <Adaptec aic7890/91 Ultra2 SCSI adapter>
        aic7890/91: Ultra2 Wide Channel A, SCSI Id=7, 32/253 SCBs

scsi0: PCI error Interrupt at seqaddr = 0x2
scsi0: Signaled a Target Abort
(scsi0:A:0): 80.000MB/s transfers (40.000MHz, offset 63, 16bit)
(scsi0:A:1): 80.000MB/s transfers (40.000MHz, offset 63, 16bit)
  Vendor: IBM       Model: DDYS-T09170N      Rev: S96H
  Type:   Direct-Access                      ANSI SCSI revision: 03
  Vendor: IBM       Model: IC35L018UWD210-0  Rev: S5BS
  Type:   Direct-Access                      ANSI SCSI revision: 03

werewolf:~/in# lspci -v
00:00.0 Host bridge: Intel Corp. 440GX - 82443GX Host bridge
        Flags: bus master, medium devsel, latency 64
        Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [a0] AGP version 1.0

00:01.0 PCI bridge: Intel Corp. 440GX - 82443GX AGP bridge (prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, medium devsel, latency 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: fca00000-feafffff
        Prefetchable memory behind bridge: dc800000-ec8fffff
...
00:0e.0 SCSI storage controller: Adaptec AHA-2940U2/U2W / 7890/7891 (rev 01)
        Subsystem: Adaptec 2940U2W SCSI Controller
        Flags: bus master, medium devsel, latency 64, IRQ 10
        BIST result: 00
        I/O ports at e800 [size=256]
        Memory at febff000 (64-bit, non-prefetchable) [disabled] [size=4K]
        Expansion ROM at febc0000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 1

???

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.21-pre2-jam2 (gcc 3.2.1 (Mandrake Linux 9.1 3.2.1-2mdk))
