Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270823AbRHNUdY>; Tue, 14 Aug 2001 16:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270814AbRHNUdE>; Tue, 14 Aug 2001 16:33:04 -0400
Received: from smtp1.one.net ([216.23.22.220]:62727 "HELO us.net")
	by vger.kernel.org with SMTP id <S270827AbRHNUcU>;
	Tue, 14 Aug 2001 16:32:20 -0400
Message-ID: <056601c12500$39d9fe60$b214860a@amdmb>
From: "Ryan Shrout" <rshrout@amdmb.com>
To: <linux-kernel@vger.kernel.org>
Subject: Slow SCSI Disk Access on AMI Elite 1600 controller
Date: Tue, 14 Aug 2001 16:32:24 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6700
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, I am fairly new to all this, so bear with me as I try to explain the
problem fully.  :)

First, my problem was centered around Mysql.  I had a problem of processes
spawning and spawning (sometimes over 100 of them at a time).  A simply
mysqld restart would solve the matter for most of the day, but the problem
always persisited.  One the people in the mysql list pointed me to check my
disk performance.  I came up with this:

[root@dagger /root]# hdparm -Tt /dev/sda

/dev/sda:
 Timing buffer-cache reads:   128 MB in  0.93 seconds =137.63 MB/sec
 Timing buffered disk reads:  64 MB in 13.92 seconds =  4.60 MB/sec

My systems specs are:
Tyan Thunder K7 Dual-Athlon (non-Via chipsets) motherboard
2 - 1.2 Ghz Athlon MP CPUs
1 GB PC2100 Registered DDR DRAM
AMI Elite 1600 SCSI RAID controller with 64 MB SDRAM
4 - 15K RPM Cheetah SCSI HDDs
Red Hat Linux 7.2

Obivously, 4.60 MB/sec is WAY too slow for this setup, and the mysql people
assumed this was probably what was causing the Mysqld server to crap out.

So, I then started trying to figure out to raise the buffered disk read
speed.  My only solution I came across -- find out if the SCSI
controllers/drives were in asynchronous mode and if they are, change them to
synchronous mode.

Now, how can I tell what mode my SCSI disks are in and how can I change it
to synchronous if it isn't set that way already?

Thank you!!!

Ryan Shrout
Owner - Amdmb.com
http://www.amdmb.com/
rshrout@amdmb.com

