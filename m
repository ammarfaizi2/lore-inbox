Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261642AbSLVNjz>; Sun, 22 Dec 2002 08:39:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261724AbSLVNjy>; Sun, 22 Dec 2002 08:39:54 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:35993 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261642AbSLVNjx> convert rfc822-to-8bit; Sun, 22 Dec 2002 08:39:53 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: WOLK - Working Overloaded Linux Kernel
To: linux-kernel@vger.kernel.org
Subject: Read this and be ashamed ;) or: Awfull performance loss since 2.4.18 to 2.4.21-pre2
Date: Sun, 22 Dec 2002 14:47:11 +0100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200212221439.28075.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

not much to say about, just read. All are vanilla kernels w/o any patch.

/dev/hda5 on /home type ext3 (rw,data=ordered)
/dev/hda5             10080488    731488   8836932   8% /home

UDMA100 IDE Drive, DMA is on. All these runs were done right after bootup.
Mashine is a Celeron 1,3GHz, 512MB RAM, 512MB SWAP.

root@codeman:[/] # uname -r
2.4.18
root@codeman:[/] # dd if=/dev/zero of=/home/largefile bs=16384 count=131072
131072+0 records in
131072+0 records out
2147483648 bytes transferred in 119.140681 seconds (18024772 bytes/sec)
root@codeman:[/] # 

root@codeman:[/] # uname -r
2.4.19
root@codeman:[/] # dd if=/dev/zero of=/home/largefile bs=16384 count=131072 
131072+0 records in
131072+0 records out
2147483648 bytes transferred in 140.305836 seconds (15305733 bytes/sec)

root@codeman:[/] # uname -r
2.4.20
root@codeman:[/] # dd if=/dev/zero of=/home/largefile bs=16384 count=131072
131072+0 records in
131072+0 records out
2147483648 bytes transferred in 172.327570 seconds (12461637 bytes/sec)

root@codeman:[/] # uname -r
2.4.21-pre2
root@codeman:[/] # dd if=/dev/zero of=/home/largefile bs=16384 count=131072          
131072+0 records in
131072+0 records out
2147483648 bytes transferred in 177.743959 seconds (12081894 bytes/sec)


ciao, Marc
