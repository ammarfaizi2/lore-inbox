Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262048AbTCLWYq>; Wed, 12 Mar 2003 17:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262000AbTCLWYq>; Wed, 12 Mar 2003 17:24:46 -0500
Received: from smtp07.iddeo.es ([62.81.186.17]:28124 "EHLO smtp07.retemail.es")
	by vger.kernel.org with ESMTP id <S262083AbTCLWYl>;
	Wed, 12 Mar 2003 17:24:41 -0500
Date: Wed, 12 Mar 2003 23:35:16 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: linux-kernel@vger.kernel.org
Subject: Re: drastically low perform. - quad, 4G ram, 2.4.20
Message-ID: <20030312223516.GA3069@werewolf.able.es>
References: <Pine.LNX.4.44.0303120915410.3827-100000@mydns2.compustrat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.44.0303120915410.3827-100000@mydns2.compustrat.com>; from thelittleprince-lists@asteroid-b612.org on Wed, Mar 12, 2003 at 18:33:00 +0100
X-Mailer: Balsa 2.0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 03.12, Mailing Lists wrote:
> 
> ok, so here's my comparison tests per Martin's earlier post. (if anyone
> has suggestions on comparison tests i SHOULD be doing or things i should 
> be checking, let me know).
> 
> 
> mem=3072M BOOT
> 
> * hdparm -t /dev/sda
> 
> /dev/sda:
>  Timing buffered disk reads:  64 MB in  3.78 seconds = 16.93 MB/sec
> 
> 
> * hdparm -t /dev/sdb
> 
> /dev/sdb:
>  Timing buffered disk reads:  64 MB in  2.75 seconds = 23.27 MB/sec
> 
> 

Don't know about the rest, but this SCSI performance looks pretty low:

annwn:~# hdparm -tT /dev/sda

/dev/sda:
 Timing buffer-cache reads:   128 MB in  0.24 seconds =533.33 MB/sec
 Timing buffered disk reads:  64 MB in  1.56 seconds = 41.03 MB/sec

Relevant parts of dmesg:

SCSI subsystem driver Revision: 1.00
PCI: Setting latency timer of device 03:02.0 to 64
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.29
        <Adaptec 29160 Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

blk: queue f7e77a18, I/O limit 4095Mb (mask 0xffffffff)
(scsi0:A:0): 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
(scsi0:A:1): 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
(scsi0:A:2): 10.000MB/s transfers (10.000MHz, offset 16)
  Vendor: FUJITSU   Model: MAJ3364MP         Rev: 0115
  Type:   Direct-Access                      ANSI SCSI revision: 04
blk: queue f7e77818, I/O limit 4095Mb (mask 0xffffffff)
  Vendor: FUJITSU   Model: MAJ3364MP         Rev: 0115
  Type:   Direct-Access                      ANSI SCSI revision: 04
blk: queue f7e77618, I/O limit 4095Mb (mask 0xffffffff)
  Vendor: TOSHIBA   Model: CD-ROM XM-6201TA  Rev: 1030
  Type:   CD-ROM                             ANSI SCSI revision: 02
blk: queue f7e77418, I/O limit 4095Mb (mask 0xffffffff)
  Vendor: IOMEGA    Model: ZIP 100           Rev: E.08
  Type:   Direct-Access                      ANSI SCSI revision: 02


-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.21-pre5-jam0 (gcc 3.2.2 (Mandrake Linux 9.1 3.2.2-3mdk))
