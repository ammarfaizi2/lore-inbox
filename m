Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263876AbTK2SbC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 13:31:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263879AbTK2SbC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 13:31:02 -0500
Received: from cs2417481-26.houston.rr.com ([24.174.81.26]:6793 "EHLO
	dmdtech.org") by vger.kernel.org with ESMTP id S263876AbTK2SbA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 13:31:00 -0500
Message-ID: <009201c3b6a6$f8e7e800$1e01a8c0@dmdtech2>
From: "Darren Dupre" <darren@dmdtech.org>
To: <linux-kernel@vger.kernel.org>
Subject: "DV failed to configure device" for Quantum DLT4000 tape drive on Adaptec 2940UW, 2.6.0-test11
Date: Sat, 29 Nov 2003 12:31:14 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I only use my Adaptec 2940-UW for doing weekly backups to my Quantum DLT4000
(external) tape drive. On the 2.4 kernels, I'd just modprobe aic7xx and it
would detect the tape drive, load the st module and I could do my usual tar
command to backup stuff to tape. On 2.6.0-test11, I modprobe aic7xxx and it
detects the drive but it says "scsi0:A:5:0: DV failed to configure device.
Please file a bug report against this driver." and the st module does not
get loaded.

Not sure what this means.. I didnt have this problem with 2.4.21.

However, I can modprobe st and use the tape drive just fine.

Here is the relevant bits out of my syslog:

Nov 29 12:18:37 dmdtech kernel: scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI
HBA DRIVER, Rev 6.2.35
Nov 29 12:18:37 dmdtech kernel:         <Adaptec 2940 Ultra SCSI adapter>
Nov 29 12:18:37 dmdtech kernel:         aic7880: Ultra Wide Channel A, SCSI
Id=7, 16/253 SCBs
Nov 29 12:18:37 dmdtech kernel:
Nov 29 12:19:01 dmdtech kernel: scsi0:A:5:0: DV failed to configure device.
Please file a bug report against this driver.
Nov 29 12:19:05 dmdtech kernel: (scsi0:A:5): 10.000MB/s transfers
(10.000MHz, offset 15)
Nov 29 12:19:05 dmdtech kernel:   Vendor: Quantum   Model: DLT4000
Rev: CC37
Nov 29 12:19:05 dmdtech kernel:   Type:   Sequential-Access
ANSI SCSI revision: 02
Nov 29 12:20:18 dmdtech kernel: st: Version 20030811, fixed bufsize 32768,
s/g segs 256 <- this is when I manually loaded the st module
Nov 29 12:20:18 dmdtech kernel: Attached scsi tape st0 at scsi0, channel 0,
id 5, lun 0
Nov 29 12:20:18 dmdtech kernel: st0: try direct i/o: yes, max page reachable
by HBA 1048575
Nov 29 12:20:23 dmdtech kernel: st0: Block limits 1 - 16777215 bytes.

