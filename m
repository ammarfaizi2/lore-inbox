Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265794AbUAKILL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 03:11:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265795AbUAKILL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 03:11:11 -0500
Received: from mail-06.iinet.net.au ([203.59.3.38]:42732 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S265794AbUAKILG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 03:11:06 -0500
Message-ID: <001c01c3d824$cbf26ab0$0a01a8c0@mart>
From: "Ashton Mills" <amills@iinet.com.au>
To: <linux-kernel@vger.kernel.org>
Subject: Bug Report: Reduced disk performance in 2.6.1
Date: Sun, 11 Jan 2004 19:25:03 +1000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following the bug reporting guide at www.kernel.org.

Sending to linux-kernel@vger.kernel.org because I don't know where the
problem lies, I've eliminated two areas (detailed below).

PROBLEM:

Stock 2.6.1 kernel shows reduced disk performance compared to stock 2.6.0.

DESCRIPTION:

2.6.0 -- hdparm -Tt shows:

~70 M/s for a single drive
~110 M/s for 2-drive software RAID 0 array

2.6.1 -- hdparm -Tt shows:

~60 M/s for single drive
~90 M/s for 2-drive software RAID 0 array

Kernel configuration file the same -- used .config from 2.6.0 with make
oldconfig

Reproducible: yes. Results remain consistent between the two kernels.

This is the only change to the system. No other software or hardware was
changed, just a straight kernel upgrade.

Relevant specs:

Athlon-XP 2800+
1024M RAM
Adaptec 29160
Two Maxtor 10k RPM U160 SCSI drives in md software RAID 0 array

Linux version 2.6.1 (root@Agamemnon) (gcc version 3.3.2 20031218 (Gentoo
Linux 3.3.2-r5, propolice-3.3-7))

PROGRESS:

Patched 2.6.1 with the 2.6.0 aic7xxx SCSI driver in case it was a result of
the new .36 version of the driver.
Result: problem remains

Patched 2.6.1 with the 2.6.0 md driver, since that was also shown to be
updated in 2.6.1
Result: problem remains

So, it doesn't appear to be a SCSI or md driver issue. Don't know where to
go from here, reporting as bug.

