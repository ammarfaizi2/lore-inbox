Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280810AbRKLOyv>; Mon, 12 Nov 2001 09:54:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280818AbRKLOyl>; Mon, 12 Nov 2001 09:54:41 -0500
Received: from smtprelay7.dc2.adelphia.net ([64.8.50.39]:60671 "EHLO
	smtprelay7.dc2.adelphia.net") by vger.kernel.org with ESMTP
	id <S280815AbRKLOyd>; Mon, 12 Nov 2001 09:54:33 -0500
Message-ID: <00b201c16b81$9d7aaba0$5101a8c0@pbc.adelphia.net>
From: "Ben Israel" <ben@genesis-one.com>
To: <linux-kernel@vger.kernel.org>
Cc: "John O'Neil" <joneil@genesis-one.com>
Subject: File System Performance
Date: Mon, 12 Nov 2001 08:54:57 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My System:
Pentium III 800MHz
128M SDRAM
Aug 2001 MSC Linux
XFS File System

My Results:
hdparm /dev/hda

/dev/hda:
 multcount    =  0 (off)
 I/O support  =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 3739/255/63, sectors = 60074784, start = 0

hdparm -t /dev/hda

/dev/hda:
 Timing buffered disk reads:  64 MB in  2.71 seconds = 23.62 MB/sec

time cp -r /usr/src/linux-2.4.6 tst

real 0m47.376s
user 0m0.180s
sys 0m2.710s

du -bs tst
144187392 tst

Actual Performance
2*144MB/48s=6MB/sec

Notes:
1) for consistent results; data size should exceed file cache.
2) cp reads and writes files: so 2*3MB/sec = 6MB/sec fileio on a 24MB/sec
drive

My Questions:
Is there a way of identifying what the file system is doing here?
Is there a way to improve it?
What tools are there to identify and time the raw disk io done by the file
system?





