Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030248AbWFARLq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030248AbWFARLq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 13:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964934AbWFARLp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 13:11:45 -0400
Received: from moci.net4u.de ([217.7.64.195]:36483 "EHLO moci.net4u.de")
	by vger.kernel.org with ESMTP id S964915AbWFARLp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 13:11:45 -0400
From: Ernst Herzberg <list-lkml@net4u.de>
Reply-To: earny@net4u.de
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Subject: Re: ALPHA 2.6.17-rc5 AIC7###: does not boot
Date: Thu, 1 Jun 2006 19:11:36 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Richard Henderson <rth@twiddle.net>
References: <200605301834.19795.list-lkml@net4u.de> <20060531154648.53539006.akpm@osdl.org> <20060601201619.A978@jurassic.park.msu.ru>
In-Reply-To: <20060601201619.A978@jurassic.park.msu.ru>
Organization: Net4U
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606011911.36962.list-lkml@net4u.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 01 June 2006 18:16, Ivan Kokshaysky wrote:
> On Wed, May 31, 2006 at 03:46:48PM -0700, Andrew Morton wrote:
> > But I don't recall us making any changes in the Alpha
> > interrupt-management code post-2.6.16.  Perhaps it was PCI changes
> > which introduced this regression.
>
> No. It looks like SMP is screwed up again. And some interrupts don't
> work as they get routed to inactive CPU.
>
> Ernst, please try this patch.
>
> Ivan.
>

Yesss Sir! The patch works.

olga:~ # uname -a
Linux olga 2.6.17-rc5 #1 SMP Thu Jun 1 18:53:25 CEST 2006 alpha EV6 
GNU/Linux

Thanks a lot

Earny

-----
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
        <Adaptec aic7895 Ultra SCSI adapter>
        aic7895C: Ultra Wide Channel A, SCSI Id=7, 32/253 SCBs

  Vendor: IBM       Model: DDYS-T36950N      Rev: S96H
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:1:0: Tagged Queuing enabled.  Depth 253
 target0:0:1: Beginning Domain Validation
 target0:0:1: wide asynchronous
 target0:0:1: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, offset 8)
 target0:0:1: Domain Validation skipping write tests
 target0:0:1: Ending Domain Validation
  Vendor: IBM       Model: DNES-309170W      Rev: SA30
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:6:0: Tagged Queuing enabled.  Depth 253
 target0:0:6: Beginning Domain Validation
 target0:0:6: wide asynchronous
 target0:0:6: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, offset 8)
 target0:0:6: Domain Validation skipping write tests
 target0:0:6: Ending Domain Validation
scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
        <Adaptec aic7895 Ultra SCSI adapter>
        aic7895C: Ultra Wide Channel B, SCSI Id=7, 32/253 SCBs

st: Version 20050830, fixed bufsize 32768, s/g segs 256
SCSI device sda: 71687340 512-byte hdwr sectors (36704 MB)
sda: Write Protect is off
sda: Mode Sense: cb 00 00 08
SCSI device sda: drive cache: write back
SCSI device sda: 71687340 512-byte hdwr sectors (36704 MB)
sda: Write Protect is off
sda: Mode Sense: cb 00 00 08
SCSI device sda: drive cache: write back
 sda: sda1 sda2
sd 0:0:1:0: Attached scsi disk sda
SCSI device sdb: 17916240 512-byte hdwr sectors (9173 MB)
sdb: Write Protect is off
sdb: Mode Sense: c3 00 00 08
SCSI device sdb: drive cache: write back
SCSI device sdb: 17916240 512-byte hdwr sectors (9173 MB)
sdb: Write Protect is off
sdb: Mode Sense: c3 00 00 08
SCSI device sdb: drive cache: write back
 sdb: sdb1
sd 0:0:6:0: Attached scsi disk sdb
sd 0:0:1:0: Attached scsi generic sg0 type 0
sd 0:0:6:0: Attached scsi generic sg1 type 0
[...]
