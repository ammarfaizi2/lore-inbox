Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280006AbRKDPtt>; Sun, 4 Nov 2001 10:49:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280012AbRKDPti>; Sun, 4 Nov 2001 10:49:38 -0500
Received: from postfix2-1.free.fr ([213.228.0.9]:6034 "HELO postfix2-1.free.fr")
	by vger.kernel.org with SMTP id <S280006AbRKDPt1> convert rfc822-to-8bit;
	Sun, 4 Nov 2001 10:49:27 -0500
Date: Sun, 4 Nov 2001 14:04:26 +0100 (CET)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: Linux <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>
Subject: SYM-2 patches against latest kernels available
Message-ID: <20011104133028.M1354-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I have uploaded 2 patches against latest kernels 2.4.13 and 2.2.20.

ftp://ftp.tux.org/pub/roudier/drivers/linux/experimental/sym-2.1.16a-for-linux-2.4.13.patch.gz
ftp://ftp.tux.org/pub/roudier/drivers/linux/experimental/sym-2.1.16b-for-linux-2.2.20.patch.gz

Btw, the patches are experimental but the driver that is embedded in them
should work just fine. :-)

The patch against linux-2.4.13 has been sent to Alan Cox for inclusion in
newer stable kernels. Alan wants to test it on his machines which is a
good thing. Anyway, those patches just add the new driver version to
kernel tree and leave stock sym53c8xx and ncr53c8xx in place.

Any report, especially on large memory machines using 64 bit DMA (2.4
kernels + PCI DAC capable controllers only), is welcome. I can't test 64
bit DMA, since my fatest machine has only 512 MB of memory.

To configure the driver, you must select "SYM53C8XX version 2 driver" from
kernel config. For large memory machines, a new "DMA addressing mode"
option is to be configured as follows (help texts have been added to
Configure.help):

Value 0: 32 bit DMA addressing
Value 1: 40 bit DMA addressing (upper 24 bytes set to zero)
Value 2: 64 bit DMA addressing limited to 16 segments of 4 GB (64 GB) max.

  Gérard.










