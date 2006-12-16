Return-Path: <linux-kernel-owner+w=401wt.eu-S1161026AbWLPPLd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161026AbWLPPLd (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 10:11:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161027AbWLPPLd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 10:11:33 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:2538 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161026AbWLPPLc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 10:11:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=HRJ7ciU3Uo3HMOafN/OiY42FAW2wWb6ZqkUtDky/99mnKFc/QjkmNMd/AU9CxebqE5KWGYrHcKeNSQGcYeBFrvYf3L0UdizuPgxkDWCeua8lhyOuu0lfrtps5DtF3diwSGt9aJ1UAT+ZY/SrnY9SAi0aT1klNLxg8OG4TcI0LHs=
Message-ID: <40f323d00612160711h5d740767ua0289fffcbe70738@mail.gmail.com>
Date: Sat, 16 Dec 2006 16:11:30 +0100
From: "Benoit Boissinot" <bboissin@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>
Subject: [2.6.19-rc6-mm2] Lost files on ext3 after suspend
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, since it is the second time it happened I decided to report it.

Last week I lost some files in my home directory (at least .gnome
.firefox .bashrc .Xauthority), I think it was after a suspend.
Yesterday exactly the same thing happened (same kernel 2.6.19-rc6-mm2,
I haven't upgraded because I feared data loss on ext3 with newer
kernel as some of them were reported).

I'm using the ata_piix driver (from dmesg):
ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0x1810 irq 14
ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0x1818 irq 15
scsi0 : ata_piix
ata1.00: ATA-6, max UDMA/100, 117210240 sectors: LBA
ata1.00: ata1: dev 0 multi count 16
ata1.00: configured for UDMA/100
scsi1 : ata_piix
ata2: port disabled. ignoring.
scsi 0:0:0:0: Direct-Access     ATA      TOSHIBA MK6026GA PA20 PQ: 0 ANSI: 5
SCSI device sda: 117210240 512-byte hdwr sectors (60012 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
SCSI device sda: 117210240 512-byte hdwr sectors (60012 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
 sda: sda1 sda2 sda3 sda4
sd 0:0:0:0: Attached scsi disk sda

with ext3 (no fancy options).

I had no errors with fsck -f or badblocks.

regards,

Benoit
