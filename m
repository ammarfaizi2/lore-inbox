Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264978AbSLBUMg>; Mon, 2 Dec 2002 15:12:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264983AbSLBUMg>; Mon, 2 Dec 2002 15:12:36 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:20385 "EHLO
	muur.intranet.vanheusden.com") by vger.kernel.org with ESMTP
	id <S264978AbSLBUMf>; Mon, 2 Dec 2002 15:12:35 -0500
From: "Folkert van Heusden" <folkert@vanheusden.com>
To: <linux-kernel@vger.kernel.org>
Subject: [2.4.20] problem with updating time fields?
Date: Mon, 2 Dec 2002 21:20:01 +0100
Message-ID: <002001c29a40$31ca6f50$3640a8c0@boemboem>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I thing I might be onto something:
when I do an ls -l in some directory, I get:
root@muur:/usr/local/etc# ls -l /data2/backup/
total 446036
-rw-r--r--    1 root     root       209975 Dec  2 01:12 backup.log.bz2
-rw-r--r--    1 root     root     269022417 Dec  2 01:12 data.tar.bz2
-rw-r--r--    1 root     root         6651 Dec  2 01:12 data2.tar.bz2
-rw-r--r--    1 root     root     39717149 Dec  2 00:15 root.tar.bz2
-rw-r--r--    1 root     root     147302102 Dec  2 00:44 usr.tar.bz2
If I connect with ftp to that machine and do
the ls in the same dir, I get:
ftp> ls
200 PORT command successful.
150 Opening ASCII mode data connection for file list.
-rw-r--r--   1 root     root       209975 Dec  2 00:12 backup.log.bz2
-rw-r--r--   1 root     root     269022417 Dec  2 00:12 data.tar.bz2
-rw-r--r--   1 root     root         6651 Dec  2 00:12 data2.tar.bz2
-rw-r--r--   1 root     root     39717149 Dec  1 23:15 root.tar.bz2
-rw-r--r--   1 root     root     147302102 Dec  1 23:44 usr.tar.bz2
Dec 1! that's different from what the ls gives me!

I mount /data2 as ext3 (fstab: /dev/hda6       /data2  ext3    defaults
0 0),
nothing fancy.

Bug? Or am I ignorant?


Folkert van Heusden
http://www.vanheusden.com/Linux/kernel_patches.php3

