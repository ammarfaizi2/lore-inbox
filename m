Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263497AbRFANV2>; Fri, 1 Jun 2001 09:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263501AbRFANVS>; Fri, 1 Jun 2001 09:21:18 -0400
Received: from tower.t16.ds.pwr.wroc.pl ([156.17.209.1]:52677 "HELO
	tower.t16.ds.pwr.wroc.pl") by vger.kernel.org with SMTP
	id <S263497AbRFANVF>; Fri, 1 Jun 2001 09:21:05 -0400
Date: Fri, 1 Jun 2001 15:21:00 +0200 (CEST)
From: Przemyslaw Wegrzyn <czajnik@tower.t16.ds.pwr.wroc.pl>
To: linux-kernel@vger.kernel.org
Subject: 2.2.19 SMP - timing problems
Message-ID: <Pine.LNX.4.21.0106011515560.10353-100000@tower.t16.ds.pwr.wroc.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


After adding second  CPU to my server, I get the following strange
behavior:

earth:/home/czajnik# ping -s 10000 213.25.174.24
PING 213.25.174.24 (213.25.174.24): 10000 data bytes
10008 bytes from 213.25.174.24: icmp_seq=0 ttl=255 time=10551.5 ms
10008 bytes from 213.25.174.24: icmp_seq=6 ttl=255 time=535.8 ms
10008 bytes from 213.25.174.24: icmp_seq=7 ttl=255 time=660.6 ms
10008 bytes from 213.25.174.24: icmp_seq=8 ttl=255 time=18.1 ms
10008 bytes from 213.25.174.24: icmp_seq=9 ttl=255 time=9890.6 ms
10008 bytes from 213.25.174.24: icmp_seq=10 ttl=255 time=9765.5 ms
10008 bytes from 213.25.174.24: icmp_seq=11 ttl=255 time=1160.6 ms
10008 bytes from 213.25.174.24: icmp_seq=12 ttl=255 time=1285.6 ms
10008 bytes from 213.25.174.24: icmp_seq=13 ttl=255 time=1410.6 ms

Every ping comes back in below one second, it seems to be a problem with
time measurement. It started to happen after adding second CPU.
We use 2.2.19 + Openwall patch + new AIC7xxx drivers + latest ReiserFS

What can It be ? How can I do any tests ?

-=Czaj-nick=- 

