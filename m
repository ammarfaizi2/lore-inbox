Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262313AbTCMNmZ>; Thu, 13 Mar 2003 08:42:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262324AbTCMNmZ>; Thu, 13 Mar 2003 08:42:25 -0500
Received: from mta03bw.bigpond.com ([139.134.6.86]:48333 "EHLO
	mta03bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S262313AbTCMNmX> convert rfc822-to-8bit; Thu, 13 Mar 2003 08:42:23 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Srihari Vijayaraghavan <harisri@bigpond.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Request for help - tcpdump on many ethernet cards simulateneously
Date: Fri, 14 Mar 2003 00:51:19 +1100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200303140051.19453.harisri@bigpond.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a requirement to capture network traffic on 5 Fast Ethernet cards 
simultaneously and store it in the local file system using tcpdump utility 
(3.7.2 Latest).

I ran some initial tests on RH 2.4.9 based kernel on a test machine with:
2 Xeon 2.8 GHz/512 KB Cache
1 GB RAM
U160 10K SCSI drives on Hardware RAID 1 under Compaq SmartArray controller 
(cciss.o)
4 Intel Ether Expro 100 Tx cards (eepro100.o), 1 Broadcom Gigabit (tg3.o)
All connected to a Cisco Fast Ethernet Switch (100 Tx only)

I captured approx 3 million packets of 1500 bytes on each adapter 
simultaneously over a period few minutes (it takes about 10 secs to fill up 
approx 500 MB in the EXT2 file system). During this period CPU (nearly 100% 
utilised), Memory (only few megabytes remained as free, rest all occupied by 
cache/buffer) and IO were really busy. The tcpdump utility reported that 
kernel hasn't dropped a single packet in that duration, which is a good news.

Is there anyone out there who has done similar work and would like to share 
the knowledge about:
1. Kernel version
2. File system used (parameters if any)
3. Network card and driver
4. SCSI/HW RAID controller card and driver
5. Tunning parameters for any sub-system if any
6. Any advise in general (don't use more than 1 GB RAM, use XFS, use aa/rmap, 
use 2.5 :-) etc..)

What I am really worried about is kernel may start dropping the packets after 
few hours/days and/or tcpdump/kernel may not be able to keep up with the 
network load due to IO load on the hard drives, memory pressure etc.. 

Are there any known bad effects on a 4 GB RAM configuration? (the production 
system will have 4 GB RAM)

By tomorrow I will have the opportunity to run it for few hours and see if it 
misbehaves (on 2.4.18-RH-latest and 2.4.20/21-pre. -aa if possible). I could 
also capture vmstat etc..

Thanks for your help.
-- 
Hari
harisri@bigpond.com

