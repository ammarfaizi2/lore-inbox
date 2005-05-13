Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262180AbVEMLW4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262180AbVEMLW4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 07:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262234AbVEMLWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 07:22:55 -0400
Received: from darkgate.equinoxe.de ([217.22.192.6]:8878 "HELO
	darkgate.equinoxe.de") by vger.kernel.org with SMTP id S262180AbVEMLW3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 07:22:29 -0400
From: "Florian Werner" <fwerner@k1024.de>
To: <linux-kernel@vger.kernel.org>
Subject: SATA DVD Burner with libata was not detected and IS not burning
Date: Fri, 13 May 2005 13:21:59 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Thread-Index: AcVXrfoQ81QfTypFRA6a5lQ6wbn8cQ==
Message-Id: <20050513112056.2ECCB84488F@chaos.k1024.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi list,

i have a question about a sata dvd burner. if this is not the right place to
ask..please tell me

i managed to get my Plextor PX-712SA detected by changing
/usr/src/linux/include/linux/libata.h from:
#undef ATA_ENABLE_ATAPI
to
#define ATA_ENABLE_ATAPI

no i can mount cd / dvds etc.

but i am still not able to burn:

growisofs -Z /dev/sr0=Projekte.iso
	Executing 'builtin_dd if=Projekte.iso of=/dev/sr0 obs=32k seek=0'
	/dev/sr0: "Current Write Speed" is 4.1x1385KBps.
		32768/120670208 ( 0.0%) @0.0x, remaining 368:09
		32768/120670208 ( 0.0%) @0.0x, remaining 552:14
		32768/120670208 ( 0.0%) @0.0x, remaining 797:40
		32768/120670208 ( 0.0%) @0.0x, remaining 981:45
		32768/120670208 ( 0.0%) @0.0x, remaining 1165:49
		32768/120670208 ( 0.0%) @0.0x, remaining 1411:15

tail -f /var/log/messages
	May 13 13:11:13 chaos ata2: command 0xa0 timeout, stat 0xd0
host_stat 0x60
	May 13 13:11:13 chaos SCSI error : <1 0 0 0> return code = 0x2


please help me...i do not have an extra win install and i want to use my
drive.
if this gives you a hint: somebody says that this is a problem becase this
writer is internal PATA and only has an adapter to SATA...but he doesnt tell
more or have a solution. (german link:
http://webnews.atnet.at/index.cgi?cmd=article&group=at.linux&item=33306&utag
=) 

Thanks in advance
FloWer

