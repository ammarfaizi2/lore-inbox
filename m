Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263418AbTGASwR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 14:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263451AbTGASwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 14:52:17 -0400
Received: from slimnet.xs4all.nl ([194.109.194.192]:7297 "EHLO gatekeeper.slim")
	by vger.kernel.org with ESMTP id S263418AbTGASwL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 14:52:11 -0400
Subject: Re: ata-scsi driver update
From: Jurgen Kramer <gtm.kramer@inter.nl.net>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <3F00CEDC.2010806@pobox.com>
References: <3F00CEDC.2010806@pobox.com>
Content-Type: text/plain
Message-Id: <1057086391.3444.3.camel@paragon.slim>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 (1.4.0-1) 
Date: 01 Jul 2003 21:06:31 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've just tried your patch. Compiling fails at make dep:

mv /usr/src/linux-2.4.21/include/linux/modules/scsi_syms.ver.tmp
/usr/src/linux-2.4.21/include/linux/modules/scsi_syms.ver
gcc -D__KERNEL__ -I/usr/src/linux-2.4.21/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 
-nostdinc -iwithprefix include -E -D__GENKSYMS__ 53c700.c
| /sbin/genksyms  -k 2.4.21 >
/usr/src/linux-2.4.21/include/linux/modules/53c700.ver.tmp
In file included from 53c700.c:142:
53c700.h:40:2: #error "Config.in must define either
CONFIG_53C700_IO_MAPPED or CONFIG_53C700_MEM_MAPPED to use this scsi
core."
53c700.c:163:22: 53c700_d.h: No such file or directory
mv /usr/src/linux-2.4.21/include/linux/modules/53c700.ver.tmp
/usr/src/linux-2.4.21/include/linux/modules/53c700.ver
make[4]: *** No rule to make target `libata.c', needed by
`/usr/src/linux-2.4.21/include/linux/modules/libata.ver'.  Stop.
make[4]: Leaving directory `/usr/src/linux-2.4.21/drivers/scsi'
make[3]: *** [_sfdep_scsi] Error 2
make[3]: Leaving directory `/usr/src/linux-2.4.21/drivers'
make[2]: *** [fastdep] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4.21/drivers'
make[1]: *** [_sfdep_drivers] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.21'
make: *** [dep-files] Error 2

Under SCSI low-level drivers only ATA support and Intel PIIX/ICH support
are selected.

This is with a freshly installed and patched 2.4.21.

Greetings,

Jurgen


