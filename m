Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129260AbQLMT34>; Wed, 13 Dec 2000 14:29:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129257AbQLMT3p>; Wed, 13 Dec 2000 14:29:45 -0500
Received: from magic.adaptec.com ([208.236.45.80]:19183 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP
	id <S129406AbQLMT33>; Wed, 13 Dec 2000 14:29:29 -0500
Message-ID: <E9EF680C48EAD311BDF400C04FA07B612D4D92@ntcexc02.ntc.adaptec.com>
From: "Boerner, Brian" <Brian_Boerner@adaptec.com>
To: "'linux-kernel@vger.redhat.com'" <linux-kernel@vger.kernel.org>
Subject: Adding a new SCSI driver in 2.4.x
Date: Wed, 13 Dec 2000 13:57:54 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to add a new scsi driver to the 2.4.x code stream. I've added the
driver into:
arch/i386/defconfig
drivers/scsi/Config.in
drivers/scsi/Makefile

In 2.2 you also had to add it under hosts.c, but that doesn't appear to be
the case any longer.

I ran:
make clean;
make mrproper;

then I ran make xconfig.

Selected the aacraid driver to be built as part of the resident kernel.

make bzImage;make modules

Installed the kernel and the modules that I just built. Blah Blah Blah.

Reboot the new kernel, but the aacraid driver detect function never gets
called. I must be missing added the pci ids for this card someplace. I just
don't know where I suppose to add the Scsi Host Template Structure.

-bmb-


Brian M. Boerner
System Software Developer
Adaptec, Inc.
Nashua, NH 03060
(603) 579-4625


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
