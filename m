Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318020AbSGRGNy>; Thu, 18 Jul 2002 02:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318021AbSGRGNy>; Thu, 18 Jul 2002 02:13:54 -0400
Received: from odin.cit.act.edu.au ([161.50.48.2]:48336 "EHLO
	odin.cit.act.edu.au") by vger.kernel.org with ESMTP
	id <S318020AbSGRGNy>; Thu, 18 Jul 2002 02:13:54 -0400
Message-ID: <C1126026D9293645B970FB72C66907961F53EE@rdmail.cit.act.edu.au>
From: "Piggin, Nick" <Nick.Piggin@cit.act.edu.au>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: 2.4.19-rc1,2 + ext3 data=journal: data loss on unmount
Date: Thu, 18 Jul 2002 16:12:49 +1000
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I have a PIV server with two IDE disks, one used for the filesystem, the
other for swap, external journals, and a backup directory.

All partitions are ext3 data=journal, all but the backup directory have
external journals. Please mail me for more HW info if needed and I apologise
if this has already come up (I did search the archives) or is a "known"
"feature".

I have a script which basically does the following

mount /mnt/backup
tar cvf $FILENAME directory
bzip2 $FILENAME
umount /mnt/backup

Upon remounting and inspection, the resulting bzip2 file is corrupted every
time. Adding a sync after bzip2 corrects the problem.

Thanks
Nick

PS. sorry if this mail turns out bad - I'm at work.
