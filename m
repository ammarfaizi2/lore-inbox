Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267349AbTBUNEq>; Fri, 21 Feb 2003 08:04:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267427AbTBUNEq>; Fri, 21 Feb 2003 08:04:46 -0500
Received: from u156n240.eastlink.ca ([24.224.156.240]:39808 "EHLO
	ns1.danicar.net") by vger.kernel.org with ESMTP id <S267349AbTBUNEo>;
	Fri, 21 Feb 2003 08:04:44 -0500
Message-ID: <18883.207.231.225.8.1045833270.squirrel@www.danicar.net>
Date: Fri, 21 Feb 2003 09:14:30 -0400 (AST)
Subject: [Fwd: Adaptec scsi issue kernel 2.4.19/20]- fixed it.
From: "Joe Gofton" <jgofton@danicar.net>
To: <linux-kernel@vger.kernel.org>
X-Priority: 3
Importance: Normal
Reply-To: jgofton@danicar.net
X-Mailer: SquirrelMail (version 1.2.11)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey all.  I figured out the issue I was having with kernels higher than
2.4.18.  It was the scsi cable I was using.  I was just using one of those
'came with the card', grey, 3 head cables.  I did another search on Google
and came across someone mentioning their cable.  I didn't think it was the
problem because it worked with 2.4.18.  So I bit the bullet and put it my
good cable.  Since my card was LVD and my drives are LVD why not have a
cable that was LVD.  To my surprise it worked.  It even booted noticably
faster.  So I guess something in the newer driver for the card must have
been tweaked(for the better) and the crappy cable just wasn't quick
enough.

I am so happy.  :-)


Joe

-------- Original Message --------
Subject: Adaptec scsi issue kernel 2.4.19/20
From: "Joe Gofton" <jgofton@danicar.net>
Date: Wed, January 29, 2003 12:14
To: <linux-kernel@vger.kernel.org>

Anyone know if this will be fixed in 2.4.21?

My box:

Dual PIII 1Ghz Coppermine processors on a Tyan Tiger 230 motherboard.

512MB PC-100 ram

Adaptec 2949U2W SCSI Card with 2 x 18gig SCSI HDDs at 80MBs/sec

ATI 4MB Rage PCI

-------- Original Message --------
Subject: Adaptec scsi issue kernel 2.4.19/20
From: "Joe Gofton" <jgofton@danicar.net>
Date: Mon, January 27, 2003 13:47
To: <linux-kernel@vger.kernel.org>

I am having an issue with my scsi card.  Here is some info.

jgofton@ns1:/var/log$ lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo
PRO133x] (rev c4)
00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo
MVP3/Pro133x AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South]
(rev 40)
00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev
40) 00:08.0 VGA compatible controller: ATI Technologies Inc 3D Rage Pro
215GP (rev 5c)
00:09.0 SCSI storage controller: Adaptec AHA-2940U2/W
00:0a.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev
04) 00:0a.1 Input device controller: Creative Labs SB Live! (rev 01)
00:0b.0 Ethernet controller: Digital Equipment Corporation DECchip 21140
[FasterNet] (rev 20)
00:0c.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone]
(rev 64)


This is what shows in the messages.log file: 2.4.20

Dec  1 11:10:32 ns1 kernel: SCSI subsystem driver Revision: 1.00
Dec  1 11:10:32 ns1 kernel: scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI
HBA DRIVER, Rev 6.2.8
Dec  1 11:10:32 ns1 kernel:         <Adaptec 2940 Ultra2 SCSI adapter>
Dec  1 11:10:32 ns1 kernel:         aic7890/91: Ultra2 Wide Channel A,
SCSI Id=7, 32/253 SCBs
Dec  1 11:10:32 ns1 kernel:
Dec  1 11:10:32 ns1 kernel:   Vendor: QUANTUM   Model: ATLAS_V_18_WLS
Rev: 0230
Dec  1 11:10:32 ns1 kernel:   Type:   Direct-Access
ANSI SCSI revision: 03
Dec  1 11:10:32 ns1 kernel:   Vendor: QUANTUM   Model: ATLAS_V_18_WLS
Rev: 0230
Dec  1 11:10:32 ns1 kernel:   Type:   Direct-Access
ANSI SCSI revision: 03
Dec  1 11:10:32 ns1 kernel: scsi0:A:0:0: Tagged Queuing enabled.  Depth
253 Dec  1 11:10:32 ns1 kernel: scsi0:A:1:0: Tagged Queuing enabled.
Depth 253 Dec  1 11:10:32 ns1 kernel: scsi: <fdomain> Detection failed
(no card) Dec  1 11:10:32 ns1 kernel: PCI: Enabling device 00:09.0 (0006
-> 0007) Dec  1 11:10:32 ns1 kernel: scsi0: PCI error Interrupt at
seqaddr = 0x8 Dec  1 11:10:32 ns1 kernel: scsi0: Signaled a Target Abort
Dec  1 11:10:32 ns1 kernel: scsi0: PCI error Interrupt at seqaddr = 0x9
Dec  1 11:10:32 ns1 kernel: scsi0: Signaled a Target Abort
Dec  1 11:10:32 ns1 kernel: scsi0: PCI error Interrupt at seqaddr = 0x9
Dec  1 11:10:32 ns1 kernel: scsi0: Signaled a Target Abort
Dec  1 11:10:32 ns1 kernel: scsi0: PCI error Interrupt at seqaddr = 0x9
Dec  1 11:10:32 ns1 kernel: scsi0: Signaled a Target Abort

and this is one that works. 2.4.18:


Dec  1 11:16:16 ns1 kernel: SCSI subsystem driver Revision: 1.00
Dec  1 11:16:16 ns1 kernel: scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI
HBA DRIVER, Rev 6.2.4
Dec  1 11:16:16 ns1 kernel:         <Adaptec 2940 Ultra2 SCSI adapter>
Dec  1 11:16:16 ns1 kernel:         aic7890/91: Ultra2 Wide Channel A,
SCSI Id=7, 32/253 SCBs
Dec  1 11:16:16 ns1 kernel:
Dec  1 11:16:16 ns1 kernel:   Vendor: QUANTUM   Model: ATLAS_V_18_WLS
Rev: 0230
Dec  1 11:16:16 ns1 kernel:   Type:   Direct-Access
ANSI SCSI revision: 03
Dec  1 11:16:16 ns1 kernel:   Vendor: QUANTUM   Model: ATLAS_V_18_WLS
Rev: 0230
Dec  1 11:16:16 ns1 kernel:   Type:   Direct-Access
ANSI SCSI revision: 03
Dec  1 11:16:16 ns1 kernel: scsi0:A:0:0: Tagged Queuing enabled.  Depth
253 Dec  1 11:16:16 ns1 kernel: scsi0:A:1:0: Tagged Queuing enabled.
Depth 253 Dec  1 11:16:16 ns1 kernel: scsi: <fdomain> Detection failed
(no card) Dec  1 11:16:16 ns1 kernel: PCI: Enabling device 00:09.0 (0006
-> 0007) Dec  1 11:16:16 ns1 kernel: Attached scsi disk sda at scsi0,
channel 0, id 0, lun 0
Dec  1 11:16:16 ns1 kernel: Attached scsi disk sdb at scsi0, channel 0,
id 1, lun 0
Dec  1 11:16:16 ns1 kernel: (scsi0:A:0): 80.000MB/s transfers
(40.000MHz, offset 63, 16bit)
Dec  1 11:16:16 ns1 kernel: SCSI device sda: 35861388 512-byte hdwr
sectors (18361 MB)
Dec  1 11:16:16 ns1 kernel: Partition check:
Dec  1 11:16:16 ns1 kernel:  sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 >
Dec  1 11:16:16 ns1 kernel: (scsi0:A:1): 80.000MB/s transfers
(40.000MHz, offset 63, 16bit)
Dec  1 11:16:16 ns1 kernel: SCSI device sdb: 35861388 512-byte hdwr
sectors (18361 MB)
Dec  1 11:16:16 ns1 kernel:  sdb: sdb1 sdb2 sdb3 sdb4 < sdb5 sdb6 sdb7 >

Is there a known problem and is there a fix?  I can't seem to upgrade my
kernel without scsi issues.



-- 
Joe

***
I can only please one person a day.
Today is not your day and tomorrow doesn't look good either.
***


-- 
Joe

***
I can only please one person a day.
Today is not your day and tomorrow doesn't look good either.
***


-- 
Joe

***
I can only please one person a day.
Today is not your day and tomorrow doesn't look good either.
***



