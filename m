Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291969AbSBYREh>; Mon, 25 Feb 2002 12:04:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293439AbSBYRE2>; Mon, 25 Feb 2002 12:04:28 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:15282 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S293436AbSBYREQ>; Mon, 25 Feb 2002 12:04:16 -0500
Message-ID: <3C7A6D75.A759FBC1@zeroscale.com>
Date: Mon, 25 Feb 2002 17:59:33 +0100
From: Martin Rode <Martin.Rode@zeroscale.com>
Organization: Zeroscale GmbH & Co. KG / Programmfabrik GmbH
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-20mdk i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Reiserfs and badblocks?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The questions I have is to clearify a problem encountered a few days
ago:

Basic setup:

- Linux Kernel 2.4.3-20mdk (Mandrake 8.0 I believe)
- LVM configured
- Reiserfs on top of LVM (90 GB)

The setup had worked for a few months flawlessly.

But after creating an archiver (the archiver is supposed to find new
files and copies them into an _ARCHIVE_ directory) script which is
triggered via cron a lot of "stat's" where done on the filesystem. They
might have caused the messages I'm getting know when accessing certain
files:

Feb 25 18:17:20 apu kernel: hda: dma_intr: status=0x51 { DriveReady
SeekComplete Error }
Feb 25 18:17:20 apu kernel: hda: dma_intr: error=0x40 {
UncorrectableError }, LBAsect=70366, sector=70280
Feb 25 18:17:20 apu kernel: end_request: I/O error, dev 03:01 (hda),
sector 70280

I assume my hard disk /dev/hda has bad blocks which have not been used
before.

Here are my questions:

1) Can a bug in a filesystem, LVM or VFS cause -directly or
subsequently- such an I/O Error?

2) If this is not a filesystem problem, how can I protect my maschine
from such errors? Are their hard drives out there _without_ badblocks,
or how do modern drives handle badblocks anyway?

3) If I had say ext3 installed, how would ext3 handle such badblocks
(assuming they weren't there when the drive was formatted).

Thank you very much for your support. Please CC your reply to my email,
since I'm not a subscriber to linux-kernel.

With regards,

;Martin Rode



-- 
Dipl.-Kfm. Martin Rode
martin.rode@zeroscale.com

Zeroscale GmbH & Co. KG
Frankfurter Allee 73d
10247 Berlin

http://www.zeroscale.com/
http://www.programmfabrik.de/

Fon +49-(0)30-4281-8001
Fax +49-(0)30-4281-8008
Funk +49-(0)163-5321400
