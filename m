Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263758AbTKXKKe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 05:10:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263762AbTKXKKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 05:10:34 -0500
Received: from ua-online.net ([213.179.225.6]:59909 "EHLO center.hqhost.net")
	by vger.kernel.org with ESMTP id S263758AbTKXKK1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 05:10:27 -0500
Date: Mon, 24 Nov 2003 12:08:26 +0200
From: maple@maple.org.ua
To: linux-kernel@vger.kernel.org
Cc: maple@center.hqhost.net
Subject: test10, hangs at aic79xx probing
Message-ID: <20031124100826.GA10304@valinor.localnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

machine hangs just after

hda: 78165360 sectors (40020 MB) w/2048KiB Cache, CHS=16383/255/63,
UDMA(100)
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 >

next should be

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

no oops, no panic

I've also experienced troubles with this scsi controller in test9,
kernel detected it normally, but
after reading from both disks simultaneously kernel printing huge amount
of debug and refused to read with io error. exact info I sent to linux-scsi,
if interested.
in test9 case, Justin Gibbs (gibbs@scsiguy.com) suggested me to try
drivers from
http://people.FreeBSD.org/~gibbs/linux/SRC/aic79xx-linux-2.6-20031106-tar.gz
and it helps. Untarring these drivers into test10 does not help, same
hang after IDE partitions probing. 2.4.22 works ok. Tell me, if you 
need more info.

        SY, Vladimir
