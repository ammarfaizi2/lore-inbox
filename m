Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267821AbTAHPay>; Wed, 8 Jan 2003 10:30:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267823AbTAHPay>; Wed, 8 Jan 2003 10:30:54 -0500
Received: from pusa.informat.uv.es ([147.156.10.98]:29420 "EHLO
	pusa.informat.uv.es") by vger.kernel.org with ESMTP
	id <S267821AbTAHPaw>; Wed, 8 Jan 2003 10:30:52 -0500
Date: Wed, 8 Jan 2003 16:39:11 +0100
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: aic7xxx broken in 2.5.53/54 ?
Message-ID: <20030108153911.GA30385@pusa.informat.uv.es>
References: <20030103101618.GB8582@in.ibm.com> <596830816.1041606846@aslan.scsiguy.com> <20030106073204.GA1875@in.ibm.com> <274040000.1041869813@aslan.scsiguy.com> <20030108024107.GA1127@louise.pinerecords.com> <703940000.1041999784@aslan.btc.adaptec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <703940000.1041999784@aslan.btc.adaptec.com>
User-Agent: Mutt/1.3.28i
From: uaca@alumni.uv.es
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2003 at 09:23:04PM -0700, Justin T. Gibbs wrote:
> >> [gibbs@scsiguy.com]
> >> 
> >> These reads are actually more expensive than just using PIO.  Neither of
> >> these older drivers included a test to try and catch fishy behavior.
> > 
> > Justin, are you quite sure that these tests actually work?
> > I too have just run into
> 
> See my recent post to the SCSI list.  The tests don't work on
> certain older controllers that lack a feature I was using.  The
> latest csets submitted to Linus correct this problem (as verified
> on a dusty dual P-90 PCI/EISA box just added to our regression cluster).

It also seems to work for me:


scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.26
        <Adaptec aic7896/97 Ultra2 SCSI adapter>
        aic7896/97: Ultra2 Wide Channel A, SCSI Id=7, 32/253 SCBs

(scsi0:A:0): 80.000MB/s transfers (40.000MHz, offset 63, 16bit)
  Vendor: QUANTUM   Model: ATLAS_V_36_WLS    Rev: 0230
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:0:0: Tagged Queuing enabled.  Depth 64
scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.26
        <Adaptec aic7896/97 Ultra2 SCSI adapter>
        aic7896/97: Ultra2 Wide Channel B, SCSI Id=7, 32/253 SCBs

SCSI device sda: drive cache: write back
SCSI device sda: 71722776 512-byte hdwr sectors (36722 MB)
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 >
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0


Theses are the controllers:

00:0c.0 SCSI storage controller: Adaptec 7896
        Subsystem: Adaptec: Unknown device 0053
        Flags: bus master, medium devsel, latency 64, IRQ 19
        BIST result: 00
        I/O ports at 2000 [disabled] [size=256]
        Memory at f4300000 (64-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: <available only to root>

00:0c.1 SCSI storage controller: Adaptec 7896
        Subsystem: Adaptec: Unknown device 0053
        Flags: bus master, medium devsel, latency 64, IRQ 19
        BIST result: 00
        I/O ports at 2400 [disabled] [size=256]
        Memory at f4301000 (64-bit, non-prefetchable) [size=4K]
        Capabilities: <available only to root>



Thanks


	Ulisses

                Debian GNU/Linux: a dream come true
-----------------------------------------------------------------------------
"Computers are useless. They can only give answers."            Pablo Picasso

--->	Visita http://www.valux.org/ para saber acerca de la	<---
--->	Asociación Valenciana de Usuarios de Linux		<---
 
