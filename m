Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261684AbUDNUaX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 16:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbUDNUaX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 16:30:23 -0400
Received: from eik.ii.uib.no ([129.177.16.3]:28122 "EHLO eik.ii.uib.no")
	by vger.kernel.org with ESMTP id S261615AbUDNUaH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 16:30:07 -0400
Date: Wed, 14 Apr 2004 22:30:02 +0200
From: Jan-Frode Myklebust <janfrode@parallab.uib.no>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: LSI Logic FC HBA / mptscsih hang
Message-ID: <20040414203000.GA21276@ii.uib.no>
Mail-Followup-To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just got a LSI Logic LSI7102XP-LC Single 2Gb/s Fibre Channel HBA,
and installed it in a IBM x330 (Dual Pentium III). Booting the redhat
kernel-2.4.21-4.EL and kernel-2.4.21-9.0.1.EL works fine, but the
smp-versions of the same kernels (kernel-smp-2.4.21-4.EL and
kernel-smp-2.4.21-9.0.1.EL) hangs every time after:

Loading mptbase.Fusion MPT base driver 2.05.05+
o module
Copyright (c) 1999-2002 LSI Logic Corporation
PCI: Enabling device 01:05.0 (0000 -> 0003)
mptbase: Initiating ioc0 bringup
ioc0: FC919X: Capabilities={Initiator,Target,LAN}
mptbase: Initiating ioc0 recovery
mptbase: Initiating ioc0 recovery
mptbase: Initiating ioc0 recovery
mptbase: 1 MPT adapter found, 1 installed.
Loading mptscsihFusion MPT SCSI Host driver 2.05.05+
.o module
scsi1 : ioc0: LSIFC919X, FwRev=01000000h, Ports=1, MaxQ=1023, IRQ=11
Starting timer : 0 0
blk: queue f752d618, I/O limit 4294967295Mb (mask 0xffffffffffffffff)
scsi : aborting command due to timeout : pid 25, scsi1, channel 0, id
0, lun 0 Inquiry 00 00 00 ff 00
mptscsih: OldAbort scheduling ABORT SCSI IO (sc=f752d400)
  IOs outstanding = 1
mptscsih: Attempting ABORT SCSI IO! (mf=f74e0100:sc=f752d400)
SCSI host 1 abort (pid 25) timed out - resetting
SCSI bus is being reset for host 1 channel 0.
mptscsih: OldReset scheduling BUS_RESET (sc=f752d400)
  IOs outstanding = 1
SCSI host 1 channel 0 reset (pid 25) timed out - trying harder
SCSI bus is being reset for host 1 channel 0.
mptscsih: OldReset scheduling BUS_RESET (sc=f752d400)
  IOs outstanding = 1
SCSI host 1 reset (pid 25) timed out again -
probably an unrecoverable SCSI bus or device hang.
mptbase: Initiating ioc0 recovery
SCSI host 1 reset (pid 26) timed out again -
probably an unrecoverable SCSI bus or device hang.
[hangs forever..]

Any advice?


   -jf
