Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132604AbRALT7O>; Fri, 12 Jan 2001 14:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132660AbRALT7E>; Fri, 12 Jan 2001 14:59:04 -0500
Received: from hose.mail.pipex.net ([158.43.128.58]:17600 "HELO hose.pipex.net")
	by vger.kernel.org with SMTP id <S132654AbRALT6z>;
	Fri, 12 Jan 2001 14:58:55 -0500
From: Chris Rankin <rankinc@zip.com.au>
Message-Id: <200101121953.f0CJrpI13822@wittsend.ukgateway.net>
Subject: Linux-2.4.0-ac7: Unresolved symbol "queued_sectors" in scsi_mod.o
To: linux-kernel@vger.kernel.org
Date: Fri, 12 Jan 2001 19:53:50 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have just compiled 2.4.0-ac7, and this kernel boots up OK (no more
processes missing from the output of "ps -ef", either). However, I am
now getting an unresolved symbol "queued_sectors" in scsi_mod.o when I
run depmod.

I've done a "make mproper; <copied in .config file>; make oldconfig;
make dep" and none of the .ver files in include/linux/modules contains
a reference to queued_sectors, nor does this symbol appear in
/proc/ksyms. However, it does appear in the System.map file as

c025335c B queued_sectors

I have worked around the problem by compiling scsi_mod.o into the
kernel instead.

Cheers,
Chris
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
