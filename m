Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281458AbRKFEu1>; Mon, 5 Nov 2001 23:50:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281466AbRKFEuL>; Mon, 5 Nov 2001 23:50:11 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:45584 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S281458AbRKFEtu>;
	Mon, 5 Nov 2001 23:49:50 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: 2.4.14 errors on full build - Y
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 06 Nov 2001 15:49:39 +1100
Message-ID: <17526.1005022179@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doing a full build of 2.4.14 (everything set to Y where possible), got
the usual collection of errors.  Some of these errors have been around
for weeks, any chance of them getting fixed?

  drivers/net/ppp_deflate.o(.data+0x0): multiple definition of `deflate_copyright'
  fs/jffs2/jffs2.o(.data+0x20): first defined here
  drivers/net/ppp_deflate.o: In function `deflateInit_':
  drivers/net/ppp_deflate.o(.text+0x0): multiple definition of `deflateInit_'
  fs/jffs2/jffs2.o(.text+0xc90): first defined here
  drivers/net/ppp_deflate.o: In function `deflateInit2_':
  Lots more of the same.

  drivers/isdn/tpam/tpam.o: In function `hdlc_decode':
  drivers/isdn/tpam/tpam.o(.text+0x3f50): multiple definition of `hdlc_decode'
  drivers/isdn/hisax/hisax_st5481.o(.text+0x30c0): first defined here
  ld: Warning: size of symbol `hdlc_decode' changed from 832 to 603 in drivers/isdn/tpam/tpam.o

  drivers/isdn/tpam/tpam.o: In function `hdlc_encode':
  drivers/isdn/tpam/tpam.o(.text+0x3d30): multiple definition of `hdlc_encode'
  drivers/isdn/hisax/hisax_st5481.o(.text+0x3400): first defined here
  ld: Warning: size of symbol `hdlc_encode' changed from 1345 to 529 in drivers/isdn/tpam/tpam.o

  drivers/mtd/chips/jedec_probe.o: In function `jedec_probe_init':
  drivers/mtd/chips/jedec_probe.o(.text.init+0x0): multiple definition of `jedec_probe_init'
  drivers/mtd/chips/jedec.o(.text.init+0x0): first defined here

  Everybody's current favourite, loop.o omitted :)

  drivers/block/ps2esdi.c:153: `THIS_MODULE' undeclared here (not in a function)
  drivers/block/ps2esdi.c:153: initializer element is not constant
  drivers/block/ps2esdi.c:153: (near initialization for `ps2esdi_fops.owner')
  drivers/block/ps2esdi.c:157: initializer element is not constant
  drivers/block/ps2esdi.c:157: (near initialization for `ps2esdi_fops')

  In file included from drivers/usb/hpusbscsi.c:13:
  drivers/scsi/scsi.h:402:27: scsi_obsolete.h: No such file or directory
  drivers/usb/hpusbscsi.c: In function `hpusbscsi_scsi_abort':
  drivers/usb/hpusbscsi.c:351: `SCSI_ABORT_PENDING' undeclared (first use in this function)
  drivers/usb/hpusbscsi.c:351: (Each undeclared identifier is reported only once
  drivers/usb/hpusbscsi.c:351: for each function it appears in.)
  drivers/usb/hpusbscsi.c:352: warning: control reaches end of non-void function

