Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316837AbSE3TUQ>; Thu, 30 May 2002 15:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316839AbSE3TUP>; Thu, 30 May 2002 15:20:15 -0400
Received: from pc132.utati.net ([216.143.22.132]:30116 "HELO
	merlin.webofficenow.com") by vger.kernel.org with SMTP
	id <S316837AbSE3TUP>; Thu, 30 May 2002 15:20:15 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: linux-kernel@vger.kernel.org
Subject: Continuing sis900 problem.
Date: Thu, 30 May 2002 09:21:51 -0400
X-Mailer: KMail [version 1.3.1]
Cc: ollie@sis.com.tw
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020530194949.AA6D3742@merlin.webofficenow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you unplug the cat 5 from an sis900 card and plug it back in, the card
starts holding on to packets for updwards of 15 seconds.

PING mail.trommello.org (208.185.217.233) from 10.0.2.253 : 56(84) bytes of data.
64 bytes from trommello.org (208.185.217.233): icmp_seq=3 ttl=242 time=80.168 msec
64 bytes from trommello.org (208.185.217.233): icmp_seq=0 ttl=242 time=3.481 sec
64 bytes from trommello.org (208.185.217.233): icmp_seq=1 ttl=242 time=2.489 sec
64 bytes from trommello.org (208.185.217.233): icmp_seq=2 ttl=242 time=1.491 sec
64 bytes from trommello.org (208.185.217.233): icmp_seq=4 ttl=242 time=80.174 msec
64 bytes from trommello.org (208.185.217.233): icmp_seq=5 ttl=242 time=85.992 msec
64 bytes from trommello.org (208.185.217.233): icmp_seq=6 ttl=242 time=81.517 msec
64 bytes from trommello.org (208.185.217.233): icmp_seq=7 ttl=242 time=2.000 sec
64 bytes from trommello.org (208.185.217.233): icmp_seq=8 ttl=242 time=1.000 sec
64 bytes from trommello.org (208.185.217.233): icmp_seq=15 ttl=242 time=86.527 msec
64 bytes from trommello.org (208.185.217.233): icmp_seq=16 ttl=242 time=90.386 msec
64 bytes from trommello.org (208.185.217.233): icmp_seq=17 ttl=242 time=80.170 msec
64 bytes from trommello.org (208.185.217.233): icmp_seq=18 ttl=242 time=90.185 msec
64 bytes from trommello.org (208.185.217.233): icmp_seq=9 ttl=242 time=9.599 sec
64 bytes from trommello.org (208.185.217.233): icmp_seq=10 ttl=242 time=8.598 sec
64 bytes from trommello.org (208.185.217.233): icmp_seq=11 ttl=242 time=7.599 sec
64 bytes from trommello.org (208.185.217.233): icmp_seq=12 ttl=242 time=6.599 sec
64 bytes from trommello.org (208.185.217.233): icmp_seq=13 ttl=242 time=5.599 sec
64 bytes from trommello.org (208.185.217.233): icmp_seq=14 ttl=242 time=4.599 sec

This is 100% reproducible on the hardware I've got.  Compile the driver in,
bring the interface up, unplug the cat 5 cable, plug it back in, device is in
la-la land.  (Or maybe the network stack is.  I dunno.)

Last time I mentioned this, other people said they were seeing a similar problem.
Donald Becker's website points you to a SiS URL (404) for support on the driver.

Still using a 2.4.18 kernel...

Rob
