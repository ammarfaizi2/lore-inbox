Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277798AbRJRQiw>; Thu, 18 Oct 2001 12:38:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277803AbRJRQim>; Thu, 18 Oct 2001 12:38:42 -0400
Received: from palrel1.hp.com ([156.153.255.242]:1229 "HELO palrel1.hp.com")
	by vger.kernel.org with SMTP id <S277798AbRJRQi0>;
	Thu, 18 Oct 2001 12:38:26 -0400
Message-ID: <C5C45572D968D411A1B500D0B74FF4A80418D57B@xfc01.fc.hp.com>
From: "DICKENS,CARY (HP-Loveland,ex2)" <cary_dickens2@hp.com>
To: "Kernel Mailing List (E-mail)" <linux-kernel@vger.kernel.org>
Cc: "HABBINGA,ERIK (HP-Loveland,ex1)" <erik_habbinga@hp.com>
Subject: Kernel performance in reference to 2.4.5pre1
Date: Thu, 18 Oct 2001 09:38:55 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.5pre1 is the base for comparison, but because privacy issues and company
policies, I can't give out anything but comparative numbers.  These should
be enough to see what has been happening over the last couple of months of
kernel development. 

The tests performed on the same equipment and networks using SPEC SFS NFS
benchmark testing.  We have attempted to limit as many variables as we can.


Hardware:
- 4 Pentium III Xeon processors, 4GB ram
- 45 fibre channel drives, set up in hardware RAID 0/1
- 2 direct Gigabit Ethernet connections between SPEC SFS prime client and
system under test
- reiserfs
- all NFS filesystems exported with sync,no_wdelay to insure O_SYNC writes
to storage
- NFS v3 UDP
- LVM

2.4.7 kernel series
      2.4.7	56%
	2.4.7 (patches: reiserfs osync and Arjan's high memory patch)	81%
	2.4.7 (patches: Mark Hemment's performance(NFS kernel lock) and
Arjan's high memory patch)  79%
	2.4.7 (patches: Mark Hemment's performance(NFS kernel lock)  and
reiserfs osync)  67%
		
2.4.9 kernel series
	2.4.9-ac10		48%
	2.4.9-ac13		40%
	2.4.9-ac13 (patches: Rik's page aging) 40%
	2.4.9-ac15		52%
	2.4.9-ac15	(patches: Rik's page aging and launder patches) 57%
2.4.9-ac16		56%
	2.4.10-pre4	20%
	2.4.10-pre8	40%
	2.4.10-pre10	28%
	2.4.10-pre10aa1	25%
	2.4.10-pre11	33%
	2.4.10-pre12	27%
	2.4.10-pre12 (patches: reiserfs performance patch) 20%
	2.4.10-pre13	13%
	2.4.10-pre13 (patches: Linus' allocate patch) 28%
	2.4.10pre14	43%

2.4.10 kernel series
	2.4.10		46%
2.4.10 (patches: Andrea's vmtweak) 62%
	2.4.10(patches: Andrea's vmtweaks2) 62%
2.4.10-ac4		57%
	2.4.11pre2		51%
	2.4.11pre2	(patches: irq rewrite patch with default setting of
20000) 50%
	2.4.11pre2 (patches: irq rewrite patch with setting of 10000) 50%
2.4.11pre2 (patches: irq rewrite patch with setting of 30000) 49%
2.4.11pre3aa1	50%
2.4.11pre6aa1	46%
2.4.11pre6aa1(patches: uses the older lvm instead.) 47%
	

2.4.12 kernel series
2.4.12		45%
	2.4.13pre1		51%
	2.4.12-ac2		54%
	2.4.12-ac3		55%


Cary Dickens
Hewlett-Packard

