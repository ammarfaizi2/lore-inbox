Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316195AbSFZEgF>; Wed, 26 Jun 2002 00:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316199AbSFZEgE>; Wed, 26 Jun 2002 00:36:04 -0400
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:18936 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S316195AbSFZEgD>; Wed, 26 Jun 2002 00:36:03 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15641.17587.22114.965921@wombat.chubb.wattle.id.au>
Date: Wed, 26 Jun 2002 14:36:03 +1000
To: linux-kernel@vger.kernel.org
Subject: Large Block Device testing -- preliminary results.
X-Mailer: VM 7.04 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
X-Face: .slVUC18R`%{j(W3ztQe~*ATzet;h`*Wv33MZ]*M,}9AP<`+C=U)c#NzI5vK!0^d#6:<_`a
 {#.<}~(T^aJ~]-.C'p~saJ7qZXP-$AY==]7,9?WVSH5sQ}g3,8j>u%@f$/Z6,WR7*E~BFY.Yjw,H6<
 F.cEDj2$S:kO2+-5<]afj@kC!:uw\(<>lVpk)lPZs+2(=?=D/TZPG+P9LDN#1RRUPxdX
Comments: Hyperbole mail buttons accepted, v04.18.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


So far I've been able to test JFS on two megaraid controllers
software-raided together to give a 4-terabyte filesystem on a 32-bit
system; and a single 2.4TB filesystem on a 64-bit machine.

On the 32-bit system:

$ df -k
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/hda2              2403452   1991036    290324  88% /
/dev/hda1                46667     10566     33692  24% /boot
/dev/md0             4016755544  33794668 3982960876   1% /mnt

$ cat /proc/partitions 
major minor  #blocks  name

   9     0 4016911104 md0
   8     0 1990639616 sda
   8    16 1990639616 sdb
   3     0   20066251 hda
   3     1      48194 hda1
   3     2    2441880 hda2
   3     3     979965 hda3
   3     4   16595145 hda4
   3    64   20066251 hdb
   3    65    1028159 hdb1
   3    66   19037025 hdb2

(md0 is a linear RAID of sda, sdb, hdb2 and hda3)

If other people can let me know of their successes/failures, I'd be
quite pleased.

--
Dr Peter Chubb				    peterc@gelato.unsw.edu.au
You are lost in a maze of BitKeeper repositories, all almost the same.
