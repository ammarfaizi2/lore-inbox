Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264389AbTEPJLj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 05:11:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264391AbTEPJLj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 05:11:39 -0400
Received: from goliath.sylaba.poznan.pl ([195.216.104.3]:12260 "EHLO
	goliath.sylaba.poznan.pl") by vger.kernel.org with ESMTP
	id S264389AbTEPJLc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 05:11:32 -0400
Subject: Copying disks using cat makes 2.4.20 very unresponsive
From: Olaf =?iso-8859-2?Q?Fr=B1czyk?= <olaf@cbk.poznan.pl>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 16 May 2003 11:26:01 +0200
Message-Id: <1053077162.1718.43.camel@venus>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

If I copy disk or partition eg. /dev/hda1 to /dev/hdc1:
cat /dev/hda1 > /dev/hdc1 the system becomes __highly__ unresponsive
The same is for:
cat /dev/zero > /dev/hda1
Processor is about 90 % idle
'cat' takes about 3-5 % CPU.
Load average is about 5
Working with X is impossible (about 1 second freeze every 1-2 seconds).
renice -19 for X makes no difference.

What is really strange, if I use 'dd' eg.:
dd if=/dev/hda1 of=/dev/hdc1 bs=1024 count=1000000
there are NO freezes at all.
The system works smoothly. Load is about 1.2.
dd takes for some time 30% CPU and then until finishes about 0.2 % CPU.
I have tried bs=512,1024,2048,4096,8192,16384.
It works smoothly with all above values.
Also cat /dev/hda1 > /dev/null doesn't hurt.

My system description:
I have linux 2.4.20.
System is based on RedHat 8.0. Tried with RH 9.0 also.
Motherboard ASUS A7V266A (via KT266A chipset)
512MB RAM
2 IBM SCSI disks connected to Adaptec 2940U2W
CD-RW, DVD-RAM connected to the same Adaptec card
2 IBM IDE disks connected to motherboard controller.
IDE disks use DMA, and are set to UDMA-100

System is installed on SCSI disks.

Please CC me.

Regards,

Olaf Fraczyk




