Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263723AbTK2Imp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 03:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263728AbTK2Imp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 03:42:45 -0500
Received: from ua-online.net ([213.179.225.6]:18702 "EHLO center.hqhost.net")
	by vger.kernel.org with ESMTP id S263723AbTK2Imo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 03:42:44 -0500
Date: Sat, 29 Nov 2003 10:40:18 +0200
Message-Id: <200311290840.hAT8eIUH000605@valinor.localnet>
From: Vladimir Klenov <maple@center.hqhost.net>
To: linux-kernel@vger.kernel.org
Subject: aic7xxx problem on sparc64 (2.6)
User-Agent: tin/1.5.19-20030610 ("Darts") (UNIX) (Linux/2.4.22-ac2 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>I inserted my known working 2940 (7880) into a Sun Ultra 5 (32-bit PCI).
>modprobe aic7xxx gave some errors and asked to report the bug.
>modprobe sd_mod gave a lot more errors and put the disk offline. The
>same hardware (host, HBA and disk) works fine with latest 2.4 kernel
>(2.4.23-rc5 currently). The problem is with 2.6.0-test11.

similar problem with -test11 and aic79xx on x86
2.4 works ok, test11 give unrecoverable read errors, but with drivers from
http://people.FreeBSD.org/~gibbs/linux/SRC/ -test11 working fine.

do I have chance to include working drivers to official tree? ;)

I use software raid1 over two scsi drives.

lspci:
02:06.0 SCSI storage controller: Adaptec ASC-29320LP U320 (rev 03)

dmesg:
scsi0 : Adaptec AIC79XX PCI-X SCSI HBA DRIVER, Rev 2.0.4
        <Adaptec 29320LP Ultra320 SCSI adapter>
        aic7901A: Ultra320 Wide Channel A, SCSI Id=7, PCI 33 or 66Mhz,
512 SCBs

(scsi0:A:0): 320.000MB/s transfers (160.000MHz DT|IU|QAS, 16bit)
(scsi0:A:1): 320.000MB/s transfers (160.000MHz DT|IU|QAS, 16bit)
  Vendor: IBM       Model: IC35L036UCDY10-0  Rev: S21E
  Type:   Direct-Access                      ANSI SCSI revision: 03
  Vendor: IBM       Model: IC35L036UCDY10-0  Rev: S21E
  Type:   Direct-Access                      ANSI SCSI revision: 03
SCSI device sda: 71687340 512-byte hdwr sectors (36704 MB)
SCSI device sda: drive cache: write back

        SY, Vladimir
