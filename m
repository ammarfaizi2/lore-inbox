Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292522AbSCRT3d>; Mon, 18 Mar 2002 14:29:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292539AbSCRT3X>; Mon, 18 Mar 2002 14:29:23 -0500
Received: from WARSL402PIP5.highway.telekom.at ([195.3.96.70]:64569 "HELO
	email02.aon.at") by vger.kernel.org with SMTP id <S292522AbSCRT3I>;
	Mon, 18 Mar 2002 14:29:08 -0500
Content-Type: text/plain; charset=US-ASCII
From: Gerald Roth <gerald.roth@aon.at>
Organization: University of Graz, Austria
To: linux-kernel@vger.kernel.org
Subject: filesystem corruption (2.4.18, reiserfs)
Date: Mon, 18 Mar 2002 20:32:13 +0100
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020318192914Z292522-889+123822@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

last friday i got a severe filesystem corruption on two reiserfs partitions 
with a plain 2.4.18 kernel. both partitions (one of them unfortunately the 
root partition) have been lost when KDE3rc2/XFree4.2/Kernel 2.4.18 totally 
locked up my machine while it was idle...

rebooting resulted in a "unable to mount root fs" error. when trying to 
repair the fs using reiserfsck on a rescue system, i got the following errors:

reiserfs_open: bread failed reading block 16
reiserfs_open: neither new nor old reiserfs format found on /dev/hdaX 

(X = 5,6), the errors were identical on both partitions.

software info:
kernel 2.4.18, reiserfs compiled into the kernel
reiserfs version on disk: 3.5
distr: suse 7.3, XFree86 4.2.0, KDE 3-rc

hardware info: 
cpu: amd duron 900
chipset: via kt133 (686a southbrigde)
ram: 256mb pc133
hdisk: IBM IC35L060AVER07-0, 60 GB, running at ATA66, use_dma, 32bit io

the system was totally stable, even under high load. the crash happened when 
it was idle...

hth
gerald

ps: please cc' me as i am not subscribed
