Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264830AbTK3HJY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 02:09:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264870AbTK3HJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 02:09:24 -0500
Received: from smtp1.att.ne.jp ([165.76.15.137]:8845 "EHLO smtp1.att.ne.jp")
	by vger.kernel.org with ESMTP id S264830AbTK3HJX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 02:09:23 -0500
Message-ID: <13d301c3b710$d51a3490$11ee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: "Andrzej Krzysztofowicz" <ankry@green.mif.pg.gda.pl>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Disk Geometries reported incorrectly on 2.6.0-testX
Date: Sun, 30 Nov 2003 16:08:13 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrzej Krzysztofowicz replied to someone:

> > The BIOS reads the MBR and jumps to the code loaded from there.
>
> I found some PC BIOS-es refuse to read the MBR if no active partition is
> found in the partition table...

They read the MBR but refuse the execute the code contained in it.  Reading
the MBR is the only way that they get to find out that the partition table
includes zero or two (or more) active partitions and decide not to boot.

SuSE 8.1 had this problem.  If you installed grub to a /boot partition but
intended to continue using your existing active partition, the installer
activated the /boot partition.  On the next boot, the BIOS detected two
active partitions and refused to boot from the hard disk.

Booting a floppy still works on most machines.  The BIOS still reads the MBR
and presents the partition table in a block of information that is visible
to the program that gets booted from the floppy disk.  In my experience, the
only machines that refused to do this (becoming 100% unbootable) were the
old NEC 98 architecture.

