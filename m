Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270266AbRHHB4A>; Tue, 7 Aug 2001 21:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270268AbRHHBzu>; Tue, 7 Aug 2001 21:55:50 -0400
Received: from [202.81.130.34] ([202.81.130.34]:31496 "EHLO
	seawall.perth.wni.com") by vger.kernel.org with ESMTP
	id <S270267AbRHHBzm>; Tue, 7 Aug 2001 21:55:42 -0400
Message-Id: <5.1.0.14.0.20010808094513.00ab72c8@mailhost>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 08 Aug 2001 09:58:12 +0800
To: linux-kernel@vger.kernel.org
From: Stuart Duncan <sety@perth.wni.com>
Subject: ARP's frustrating behavior 
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm noticing on a machine with dual NICs that they they all seem to answer 
ARP queries, even if the request is not directed to their IP.  Here's an 
example:

---8<---
10:52:03.177863 eth1 B arp who-has eddy tell soliton
10:52:03.177895 eth1 > arp reply eddy (0:3:47:8:1a:64) is-at 0:3:47:8:1a:64 
(0:90:27:41:c9:f4)
10:52:03.177875 eth0 B arp who-has eddy tell soliton
10:52:03.177908 eth0 > arp reply eddy (0:b0:d0:78:bc:92) is-at 
0:b0:d0:78:bc:92 (0:90:27:41:c9:f4)
--8<--

This is a problem for me because eth1 is 1000Mb fibre while eth0 is 100Mb, 
and almost all of the clients are caching the response from eth0 in 
preference to the response from eth1.

I know this appeared on the list once before (20/08/1999, Chris 
Leech.  "ARP (mis)behavior") however there was no definite answer.  My 
questions are:  Is this ARP behavior intentional?  (I can't recreate the 
fault in other UNIX's) and if it is, is there a way to turn it off?

Thank you,
Stuart Duncan


----
Stuart Duncan
Systems Administrator
WNI Weathernews
31 Bishop Street
JOLIMONT WA 6014


