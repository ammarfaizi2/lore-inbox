Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262972AbUC2PhT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 10:37:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262974AbUC2PhT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 10:37:19 -0500
Received: from [62.248.102.66] ([62.248.102.66]:51146 "HELO
	eposta.kablonet.com.tr") by vger.kernel.org with SMTP
	id S262972AbUC2PhR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 10:37:17 -0500
From: "Siseci" <siseci@postmark.net>
To: <linux-kernel@vger.kernel.org>
Subject: 2.6.x mount /dev/ram0 problem. 
Date: Mon, 29 Mar 2004 18:34:01 +0300
Message-ID: <BMEEKPMJDEAFABBKPBBNMELBCBAA.siseci@postmark.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-9"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi.
I have a problem about ramdisk.
Kernel version: 2.6.3 and 2.6.4

root@fen:~# dd if=/dev/zero of=/dev/ram0 bs=1024 count=2048
2048+0 records in
2048+0 records out
root@fen:~# mke2fs /dev/ram0
mke2fs 1.18, 11-Nov-1999 for EXT2 FS 0.5b, 95/08/09
Filesystem label=
....

root@fen:~# mount /dev/ram0 /mnt
root@fen:~# ls -al /mnt
total 17
drwxr-xr-x   3 root     root         1024 Mar 29 20:28 ./
drwxr-xr-x  22 root     root         4096 Dec 16 02:28 ../
drwxr-xr-x   2 root     root        12288 Mar 29 20:28 lost+found/

root@fen:/mnt# echo test > /mnt/test
root@fen:/mnt# ls -al /mnt
total 18
drwxr-xr-x   3 root     root         1024 Mar 29 20:29 ./
drwxr-xr-x  22 root     root         4096 Dec 16 02:28 ../
drwxr-xr-x   2 root     root        12288 Mar 29 20:28 lost+found/
-rw-r--r--   1 root     root            5 Mar 29 20:29 test
root@fen:~# umount /mnt
root@fen:~# mount /dev/ram0 /mnt
root@fen:~# ls -al /mnt
total 17
drwxr-xr-x   3 root     root         1024 Mar 29 20:28 ./
drwxr-xr-x  22 root     root         4096 Dec 16 02:28 ../
drwxr-xr-x   2 root     root        12288 Mar 29 20:28 lost+found/

My test file does not appear on /mnt.
This was working with 2.4 kernels
i think the problem is related with 2.6 kernels
What is the problem?

