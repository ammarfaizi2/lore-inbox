Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270576AbTHORXG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 13:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270082AbTHORWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 13:22:53 -0400
Received: from fw.osdl.org ([65.172.181.6]:28606 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270576AbTHORWT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 13:22:19 -0400
Date: Fri, 15 Aug 2003 10:18:56 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Debug: sleeping function called from invalid context
Message-Id: <20030815101856.3eb1e15a.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Wrote some files to a Zip ppa device, did sync and umount:

ppa: Version 2.07 (for Linux 2.4.x)
ppa: Found device at ID 6, Attempting to use EPP 16 bit
ppa: Found device at ID 6, Attempting to use SPP
ppa: Communication established with ID 6 using SPP
scsi1 : Iomega VPI0 (ppa) interface
  Vendor: IOMEGA    Model: ZIP 100           Rev: J.03
  Type:   Direct-Access                      ANSI SCSI revision: 02
SCSI device sda: 196608 512-byte hdwr sectors (101 MB)
sda: Write Protect is off
sda: Mode Sense: 25 00 00 08
sda: cache data unavailable
sda: assuming drive cache: write through
 sda: sda4
Attached scsi removable disk sda at scsi1, channel 0, id 6, lun 0
Attached scsi generic sg0 at scsi1, channel 0, id 6, lun 0,  type 0
Debug: sleeping function called from invalid context at include/asm/uaccess.h:473
Call Trace:
 [<c0120d94>] __might_sleep+0x54/0x5b
 [<c010d001>] save_v86_state+0x71/0x1f0
 [<c010dbd5>] handle_vm86_fault+0xc5/0xa90
 [<c019cab8>] ext3_file_write+0x28/0xc0
 [<c011cd96>] __change_page_attr+0x26/0x220
 [<c010b310>] do_general_protection+0x0/0x90
 [<c010a69d>] error_code+0x2d/0x40
 [<c0109657>] syscall_call+0x7/0xb

--
~Randy
