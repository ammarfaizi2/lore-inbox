Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267244AbRGKXur>; Wed, 11 Jul 2001 19:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267206AbRGKXuh>; Wed, 11 Jul 2001 19:50:37 -0400
Received: from usc.edu ([128.125.253.136]:37370 "EHLO usc.edu")
	by vger.kernel.org with ESMTP id <S267259AbRGKXuZ>;
	Wed, 11 Jul 2001 19:50:25 -0400
Date: Wed, 11 Jul 2001 16:47:46 -0700 (PDT)
From: Laurent Itti <itti@java.usc.edu>
To: linux-kernel@vger.kernel.org
Subject: receive stats null for bond0 in 2.4.6
Message-ID: <Pine.SV4.3.96.1010711163709.5481B-100000@java.usc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all:

just installed 2.4.6 and all is well except that all stats in
/proc/net/dev are at zero on the receive side for our 3x100Mbps
channel-bonded network interface (bond0, using kernel module "bonding").
The interface works great (we do receive packets).  Transmit side stats
appear ok. All stats also ok on the 3 ethernet boards that are enslaved
into the bond.

any idea? thanks!

  -- laurent


bond0 = eth1 + eth2 + eth3 (eth0 is not enslaved).

[itti@iLab1 ~]$ cat /proc/net/dev
Inter-|   Receive                                                |
Transmit
 face |bytes    packets errs drop fifo frame compressed multicast|bytes
packets errs drop fifo colls carrier compressed
    lo:1196053455 3162886    0    0    0     0          0         0
1196053455 3162886    0    0    0     0       0          0
 bond0:       0       0    0    0    0     0          0         0
1178655990 11823521    0    0    0     0       0          0
  eth0:1087068641 1222724    0    0    0     0          0         0
38597714  315369 3240    0    0 12601    6480          0
  eth1:166095439 1917632    0    0    0     0          0         0
398336394 3941174    0    0    0     0       0          0
  eth2:165918470 1916726    0    0    0     0          0         0
390110017 3941174    0    0    8     0       0          0
  eth3:165932863 1921640    0    0    0     0          0         0
393562846 3941173    0    0    6     0       0          0


-----------------------------------------------------------------------
Laurent Itti - University of Southern California, Computer Science Dept
Hedco Neuroscience Building, HNB-30A - Los Angeles, CA 90089-2520 - USA
Email: itti@java.usc.edu  - Tel: +1(213)740-3527 - Fax: +1(213)740-5687
-----------------------------------------------------------------------


