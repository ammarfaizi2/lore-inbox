Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281457AbRKMDki>; Mon, 12 Nov 2001 22:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281458AbRKMDk3>; Mon, 12 Nov 2001 22:40:29 -0500
Received: from alcatraz.triton.net ([209.172.11.53]:56464 "HELO
	alcatraz.triton.net") by vger.kernel.org with SMTP
	id <S281457AbRKMDkN>; Mon, 12 Nov 2001 22:40:13 -0500
Subject: Errors in dmesg with reiserFS and adaptec 3400s, RAID 0
From: Jake Roersma <jaker@alcatraz.triton.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15 (Preview Release)
Date: 12 Nov 2001 22:41:10 -0500
Message-Id: <1005622870.9934.14.camel@alcatraz>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am running reiserFS and kernel version 2.4.13 on a dual PIII 1Ghz with a 60 GIG Raid 0 on Adaptec 3400s.  
I had an issue the other day where the machine locked up and all of my qmail processes went defunct, 
which are the only processes using the reiserFS partition amd is mounted on /var/qmail. My partitions 
look like this:

Filesystem            Size  Used Avail Use% Mounted on
/dev/sda1              16G 1011M   15G   7% /			EXT2
/dev/sdb1              51G  8.3G   43G  17% /var/qmail		REISERFS

The dmesg output then,looks a lot like what i am getting after a few days now, I get the following errors 
in dmesg, is this normal or is there something I may have missed?? 


vs-13060: reiserfs_update_sd: stat data of object [74166 890651 0x0 SD] (nlink == 1) not found (pos 5)
vs-13060: reiserfs_update_sd: stat data of object [74166 890651 0x0 SD] (nlink == 1) not found (pos 5)
vs-13060: reiserfs_update_sd: stat data of object [74166 890651 0x0 SD] (nlink == 1) not found (pos 5)
vs-13060: reiserfs_update_sd: stat data of object [74166 890651 0x0 SD] (nlink == 1) not found (pos 5)
vs-13060: reiserfs_update_sd: stat data of object [74166 890651 0x0 SD] (nlink == 1) not found (pos 5)
vs-13060: reiserfs_update_sd: stat data of object [74166 890651 0x0 SD] (nlink == 1) not found (pos 5)
vs-13060: reiserfs_update_sd: stat data of object [74166 890651 0x0 SD] (nlink == 1) not found (pos 5)
vs-13060: reiserfs_update_sd: stat data of object [74166 857686 0x0 SD] (nlink == 1) not found (pos 4)
vs-13060: reiserfs_update_sd: stat data of object [74166 857686 0x0 SD] (nlink == 1) not found (pos 4)
vs-13060: reiserfs_update_sd: stat data of object [74166 857686 0x0 SD] (nlink == 1) not found (pos 4)
vs-13060: reiserfs_update_sd: stat data of object [74166 857686 0x0 SD] (nlink == 1) not found (pos 4)
vs-13060: reiserfs_update_sd: stat data of object [74166 857686 0x0 SD] (nlink == 1) not found (pos 4)
vs-13060: reiserfs_update_sd: stat data of object [74166 857686 0x0 SD] (nlink == 1) not found (pos 4)
vs-13060: reiserfs_update_sd: stat data of object [74166 857686 0x0 SD] (nlink == 1) not found (pos 4)
vs-13060: reiserfs_update_sd: stat data of object [74166 857686 0x0 SD] (nlink == 1) not found (pos 4)
vs-13060: reiserfs_update_sd: stat data of object [74166 857686 0x0 SD] (nlink == 1) not found (pos 4)
vs-13060: reiserfs_update_sd: stat data of object [74166 857686 0x0 SD] (nlink == 1) not found (pos 4)
vs-13060: reiserfs_update_sd: stat data of object [74166 857686 0x0 SD] (nlink == 1) not found (pos 4)
vs-13060: reiserfs_update_sd: stat data of object [74166 850980 0x0 SD] (nlink == 1) not found (pos 2)
vs-13060: reiserfs_update_sd: stat data of object [74166 850980 0x0 SD] (nlink == 1) not found (pos 2)
vs-13060: reiserfs_update_sd: stat data of object [74166 850980 0x0 SD] (nlink == 1) not found (pos 2)
vs-13060: reiserfs_update_sd: stat data of object [74166 811599 0x0 SD] (nlink == 1) not found (pos 1)
vs-13060: reiserfs_update_sd: stat data of object [74166 811599 0x0 SD] (nlink == 1) not found (pos 1)
vs-13060: reiserfs_update_sd: stat data of object [74166 811599 0x0 SD] (nlink == 1) not found (pos 1)
vs-13060: reiserfs_update_sd: stat data of object [74166 811599 0x0 SD] (nlink == 1) not found (pos 1)
vs-13060: reiserfs_update_sd: stat data of object [74166 811599 0x0 SD] (nlink == 1) not found (pos 1)
vs-13060: reiserfs_update_sd: stat data of object [74166 811599 0x0 SD] (nlink == 1) not found (pos 1)
vs-13060: reiserfs_update_sd: stat data of object [74166 811599 0x0 SD] (nlink == 1) not found (pos 1)
vs-13060: reiserfs_update_sd: stat data of object [74166 811599 0x0 SD] (nlink == 1) not found (pos 1)
vs-13060: reiserfs_update_sd: stat data of object [74166 811599 0x0 SD] (nlink == 1) not found (pos 1)
vs-13060: reiserfs_update_sd: stat data of object [74166 811599 0x0 SD] (nlink == 1) not found (pos 1)
vs-13060: reiserfs_update_sd: stat data of object [74166 824785 0x0 SD] (nlink == 1) not found (pos 1)
vs-13060: reiserfs_update_sd: stat data of object [74166 824785 0x0 SD] (nlink == 1) not found (pos 1)
vs-13060: reiserfs_update_sd: stat data of object [74166 824785 0x0 SD] (nlink == 1) not found (pos 1)
vs-13060: reiserfs_update_sd: stat data of object [74166 824785 0x0 SD] (nlink == 1) not found (pos 1)
vs-13060: reiserfs_update_sd: stat data of object [74166 824785 0x0 SD] (nlink == 1) not found (pos 1)
vs-13060: reiserfs_update_sd: stat data of object [74166 824785 0x0 SD] (nlink == 1) not found (pos 1)
vs-13060: reiserfs_update_sd: stat data of object [74166 845863 0x0 SD] (nlink == 1) not found (pos 1)
vs-13060: reiserfs_update_sd: stat data of object [74166 845863 0x0 SD] (nlink == 1) not found (pos 1)
vs-13060: reiserfs_update_sd: stat data of object [74166 845863 0x0 SD] (nlink == 1) not found (pos 1)
vs-13060: reiserfs_update_sd: stat data of object [74166 845863 0x0 SD] (nlink == 1) not found (pos 1)
vs-13060: reiserfs_update_sd: stat data of object [74166 863873 0x0 SD] (nlink == 1) not found (pos 1)
vs-13060: reiserfs_update_sd: stat data of object [74166 863873 0x0 SD] (nlink == 1) not found (pos 1)
vs-13060: reiserfs_update_sd: stat data of object [74166 863873 0x0 SD] (nlink == 1) not found (pos 1)
vs-13060: reiserfs_update_sd: stat data of object [74166 863873 0x0 SD] (nlink == 1) not found (pos 1)
vs-13060: reiserfs_update_sd: stat data of object [74166 863873 0x0 SD] (nlink == 1) not found (pos 1)
vs-13060: reiserfs_update_sd: stat data of object [74166 863873 0x0 SD] (nlink == 1) not found (pos 1)
vs-13060: reiserfs_update_sd: stat data of object [74166 780693 0x0 SD] (nlink == 1) not found (pos 1)
vs-13060: reiserfs_update_sd: stat data of object [74166 780693 0x0 SD] (nlink == 1) not found (pos 1)
vs-13060: reiserfs_update_sd: stat data of object [74166 780693 0x0 SD] (nlink == 1) not found (pos 1)
vs-13060: reiserfs_update_sd: stat data of object [74166 860197 0x0 SD] (nlink == 1) not found (pos 1)
vs-13060: reiserfs_update_sd: stat data of object [74166 860197 0x0 SD] (nlink == 1) not found (pos 1)
vs-13060: reiserfs_update_sd: stat data of object [74166 860197 0x0 SD] (nlink == 1) not found (pos 1)
vs-13060: reiserfs_update_sd: stat data of object [74166 865137 0x0 SD] (nlink == 1) not found (pos 1)
vs-13060: reiserfs_update_sd: stat data of object [74166 865137 0x0 SD] (nlink == 1) not found (pos 1)
vs-13060: reiserfs_update_sd: stat data of object [74166 865137 0x0 SD] (nlink == 1) not found (pos 1)
vs-13060: reiserfs_update_sd: stat data of object [74166 844324 0x0 SD] (nlink == 1) not found (pos 1)
vs-13060: reiserfs_update_sd: stat data of object [74166 844324 0x0 SD] (nlink == 1) not found (pos 1)
vs-13060: reiserfs_update_sd: stat data of object [74166 844324 0x0 SD] (nlink == 1) not found (pos 1)
vs-13060: reiserfs_update_sd: stat data of object [74166 858275 0x0 SD] (nlink == 1) not found (pos 4)
vs-13060: reiserfs_update_sd: stat data of object [74166 858275 0x0 SD] (nlink == 1) not found (pos 4)
vs-13060: reiserfs_update_sd: stat data of object [74166 858275 0x0 SD] (nlink == 1) not found (pos 4)
vs-13060: reiserfs_update_sd: stat data of object [74166 858275 0x0 SD] (nlink == 1) not found (pos 4)
vs-13060: reiserfs_update_sd: stat data of object [74166 858275 0x0 SD] (nlink == 1) not found (pos 4)
vs-13060: reiserfs_update_sd: stat data of object [74166 858275 0x0 SD] (nlink == 1) not found (pos 4)
vs-13060: reiserfs_update_sd: stat data of object [74166 775323 0x0 SD] (nlink == 1) not found (pos 1)
vs-13060: reiserfs_update_sd: stat data of object [74166 775323 0x0 SD] (nlink == 1) not found (pos 1)
vs-13060: reiserfs_update_sd: stat data of object [74166 775323 0x0 SD] (nlink == 1) not found (pos 1)
vs-13060: reiserfs_update_sd: stat data of object [74166 775323 0x0 SD] (nlink == 1) not found (pos 1)
vs-13060: reiserfs_update_sd: stat data of object [74166 775323 0x0 SD] (nlink == 1) not found (pos 1)
vs-13060: reiserfs_update_sd: stat data of object [74166 775323 0x0 SD] (nlink == 1) not found (pos 1)
vs-13060: reiserfs_update_sd: stat data of object [74166 775323 0x0 SD] (nlink == 1) not found (pos 1)
vs-13060: reiserfs_update_sd: stat data of object [74166 775323 0x0 SD] (nlink == 1) not found (pos 1)
vs-13060: reiserfs_update_sd: stat data of object [74166 775323 0x0 SD] (nlink == 1) not found (pos 1)
vs-13060: reiserfs_update_sd: stat data of object [74166 775323 0x0 SD] (nlink == 1) not found (pos 1)
vs-13060: reiserfs_update_sd: stat data of object [74166 786517 0x0 SD] (nlink == 1) not found (pos 5)
vs-13060: reiserfs_update_sd: stat data of object [74166 786517 0x0 SD] (nlink == 1) not found (pos 5)
vs-13060: reiserfs_update_sd: stat data of object [74166 786517 0x0 SD] (nlink == 1) not found (pos 5)
vs-13060: reiserfs_update_sd: stat data of object [74166 786517 0x0 SD] (nlink == 1) not found (pos 5)
vs-13060: reiserfs_update_sd: stat data of object [74166 786517 0x0 SD] (nlink == 1) not found (pos 5)
vs-13060: reiserfs_update_sd: stat data of object [74166 796839 0x0 SD] (nlink == 1) not found (pos 1)
vs-13060: reiserfs_update_sd: stat data of object [74166 796839 0x0 SD] (nlink == 1) not found (pos 1)
vs-13060: reiserfs_update_sd: stat data of object [74166 796839 0x0 SD] (nlink == 1) not found (pos 1)
vs-13060: reiserfs_update_sd: stat data of object [74166 796839 0x0 SD] (nlink == 1) not found (pos 1)
vs-13060: reiserfs_update_sd: stat data of object [74166 796839 0x0 SD] (nlink == 1) not found (pos 1)
vs-13060: reiserfs_update_sd: stat data of object [74166 796839 0x0 SD] (nlink == 1) not found (pos 1)
vs-13060: reiserfs_update_sd: stat data of object [74166 796839 0x0 SD] (nlink == 1) not found (pos 1)
vs-13060: reiserfs_update_sd: stat data of object [74166 796839 0x0 SD] (nlink == 1) not found (pos 1)
vs-13060: reiserfs_update_sd: stat data of object [74166 796839 0x0 SD] (nlink == 1) not found (pos 1)
vs-13060: reiserfs_update_sd: stat data of object [74166 796839 0x0 SD] (nlink == 1) not found (pos 1)
vs-13060: reiserfs_update_sd: stat data of object [74166 796839 0x0 SD] (nlink == 1) not found (pos 1)
vs-13060: reiserfs_update_sd: stat data of object [74166 796839 0x0 SD] (nlink == 1) not found (pos 1)
vs-13060: reiserfs_update_sd: stat data of object [74166 796839 0x0 SD] (nlink == 1) not found (pos 1)
vs-13060: reiserfs_update_sd: stat data of object [74166 796839 0x0 SD] (nlink == 1) not found (pos 1)
PAP-5660: reiserfs_do_truncate: wrong result -1 of search for [74166 890651 0xfffffffffffffff DIRECT]
vs-: reiserfs_delete_solid_item: [74166 890651 0x0 SD] not found<4>PAP-5660: reiserfs_do_truncate: wrong result -1 of search for [74166 857686 0xfffffffffffffff DIRECT]
vs-: reiserfs_delete_solid_item: [74166 857686 0x0 SD] not found<4>PAP-5660: reiserfs_do_truncate: wrong result -1 of search for [74166 850980 0xfffffffffffffff DIRECT]
vs-: reiserfs_delete_solid_item: [74166 850980 0x0 SD] not found<4>PAP-5660: reiserfs_do_truncate: wrong result -1 of search for [74166 811599 0xfffffffffffffff DIRECT]
vs-: reiserfs_delete_solid_item: [74166 811599 0x0 SD] not found<4>PAP-5660: reiserfs_do_truncate: wrong result -1 of search for [74166 785162 0xfffffffffffffff DIRECT]
vs-: reiserfs_delete_solid_item: [74166 785162 0x0 SD] not found<4>PAP-5660: reiserfs_do_truncate: wrong result -1 of search for [74166 824785 0xfffffffffffffff DIRECT]
vs-: reiserfs_delete_solid_item: [74166 824785 0x0 SD] not found<4>PAP-5660: reiserfs_do_truncate: wrong result -1 of search for [74166 845863 0xfffffffffffffff DIRECT]
vs-: reiserfs_delete_solid_item: [74166 845863 0x0 SD] not found<4>PAP-5660: reiserfs_do_truncate: wrong result -1 of search for [74166 863873 0xfffffffffffffff DIRECT]
vs-: reiserfs_delete_solid_item: [74166 863873 0x0 SD] not found<4>PAP-5660: reiserfs_do_truncate: wrong result -1 of search for [74166 785931 0xfffffffffffffff DIRECT]
vs-: reiserfs_delete_solid_item: [74166 785931 0x0 SD] not found<4>PAP-5660: reiserfs_do_truncate: wrong result -1 of search for [74166 789672 0xfffffffffffffff DIRECT]
vs-: reiserfs_delete_solid_item: [74166 789672 0x0 SD] not found<4>PAP-5660: reiserfs_do_truncate: wrong result -1 of search for [74166 860197 0xfffffffffffffff DIRECT]
vs-: reiserfs_delete_solid_item: [74166 860197 0x0 SD] not found<4>PAP-5660: reiserfs_do_truncate: wrong result -1 of search for [74166 865137 0xfffffffffffffff DIRECT]
vs-: reiserfs_delete_solid_item: [74166 865137 0x0 SD] not found<4>PAP-5660: reiserfs_do_truncate: wrong result -1 of search for [74166 844324 0xfffffffffffffff DIRECT]
vs-: reiserfs_delete_solid_item: [74166 844324 0x0 SD] not found<4>PAP-5660: reiserfs_do_truncate: wrong result -1 of search for [74166 858275 0xfffffffffffffff DIRECT]
vs-: reiserfs_delete_solid_item: [74166 858275 0x0 SD] not found<4>PAP-5660: reiserfs_do_truncate: wrong result -1 of search for [74166 870194 0xfffffffffffffff DIRECT]
vs-: reiserfs_delete_solid_item: [74166 870194 0x0 SD] not found<4>PAP-5660: reiserfs_do_truncate: wrong result -1 of search for [74166 786517 0xfffffffffffffff DIRECT]
vs-: reiserfs_delete_solid_item: [74166 786517 0x0 SD] not found<4>PAP-5660: reiserfs_do_truncate: wrong result -1 of search for [74166 831675 0xfffffffffffffff DIRECT]
vs-: reiserfs_delete_solid_item: [74166 831675 0x0 SD] not found<4>PAP-5660: reiserfs_do_truncate: wrong result -1 of search for [74166 853719 0xfffffffffffffff DIRECT]
vs-: reiserfs_delete_solid_item: [74166 853719 0x0 SD] not found<4>PAP-5660: reiserfs_do_truncate: wrong result -1 of search for [74166 796839 0xfffffffffffffff DIRECT]
vs-: reiserfs_delete_solid_item: [74166 796839 0x0 SD] not found<7>TCP: Treason uncloaked! Peer 148.75.149.26:21041/110 shrinks window 4087426749:4087426758. Repaired.


-- 
Jake Roersma
Network Engineer
Triton Technologies, Inc
(800)837-4253 x 125

