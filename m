Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263089AbUELXWb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263089AbUELXWb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 19:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263188AbUELXWb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 19:22:31 -0400
Received: from smtp4.aruba.it ([62.149.128.203]:51724 "HELO smtp4.aruba.it")
	by vger.kernel.org with SMTP id S263089AbUELXWT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 19:22:19 -0400
From: Martino di Filippo <webmaster@matrix87.com>
To: linux-kernel@vger.kernel.org
Subject: sil_sata bug 2.6.5
Date: Thu, 13 May 2004 01:20:54 +0200
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200405130120.54077.webmaster@matrix87.com>
X-Spam-Rating: smtp4.aruba.it 1.6.2 0/1000/N
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have some troubles with the silicon image sata support
Kernel 2.6.5, Silicon Image Sil3112 onboard sata raid, Asus A7N8X-E Deluxe
I get some error messages like this


ata2: DMA timeout, stat 0x1
ATA: abnormal status 0xD8 on port 0xF98750C7
scsi1: ERROR on channel 0, id 0, lun 0, CDB: 0x2a 00 00 00 16 7f 00 00 10 00
Current sdb: sense = 70  3
ASC= c ASCQ= 2
Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x06 0x00 0x00 0x00 0x00 
0x0c 0x02
end_request: I/O error, dev sdb, sector 5759
ATA: abnormal status 0xD8 on port 0xF98750C7
ATA: abnormal status 0xD8 on port 0xF98750C7
ATA: abnormal status 0xD8 on port 0xF98750C7


After that, if i try to access in any way the device that caused the error 
(/dev/sdb in the example) the application that tries that freezes and i have 
to hard reboot.

I found a similar problem in the archive: 
http://www.uwsg.iu.edu/hypermail/linux/kernel/0404.3/0119.html
Justin thought it could be related to bad sectors, but i checked and i'm sure 
the disk is ok. Oh, the disk is a Maxtor 120gb SATA.

Any hint?
-- 
matrix87
webmaster@matrix87.com
http://www.matrix87.com


