Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265659AbTFXEeR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 00:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265661AbTFXEeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 00:34:17 -0400
Received: from smtp-out.comcast.net ([24.153.64.113]:24871 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S265659AbTFXEeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 00:34:16 -0400
Date: Tue, 24 Jun 2003 00:43:19 -0400
From: rmoser <mlmoser@comcast.net>
Subject: ide-ops.c line 1262 and ide-scsi
To: linux-kernel@vger.kernel.org
Message-id: <200306240043190180.00B254B6@smtp.comcast.net>
MIME-version: 1.0
X-Mailer: Calypso Version 3.30.00.00 (3)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Watch out for ide-ops.c:1262 when using ide-scsi.  ide-scsi does
NOT seem to work when I haven't previously loaded ide-floppy and/or
ide-cd to let me use my drives.  However, once I have done so, it
works for about 4 seconds.  Then it dies.  I can pull the stack trace
and register dump out of my syslog, but I can tell you the EIP is 0010,
the kernel is in interrupt, and it's not tainted.  Experienced with both a
standard 2.4.21 kernel and a 2.4.21-smt (supermount-ng.sf.net patch)
kernel.

Versions Affected:
	2.4.21
	2.4.21 + supermount.sf.net 2.4.21-rc1 patch
Source affected:
	ide-ops.c:1262
Recreation method:
	modprobe ide-cd
	modprobe ide-floppy
	modprobe ide-scsi
	Try to access the media, or just fool around a while
Hardware:
	CPU:	AMD K7-Athlon XP 1.8 Ghz
	RAM:	256 MB DDR
	Drives:
		40 GB IDE Samsung hard drive
		40 GB IDE Maxtor hard drive
		IDE Creative CD-RW
		IDE Iomega Zip drive
		Standard 3.5 inch double density high capacity floppy drive

