Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262367AbUBYCYg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 21:24:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262385AbUBYCYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 21:24:36 -0500
Received: from host207-193-149-62.serverdedicati.aruba.it ([62.149.193.207]:21961
	"EHLO chernobyl.investici.org") by vger.kernel.org with ESMTP
	id S262374AbUBYCYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 21:24:34 -0500
Subject: WARNING: kernel is not very fresh, upgrade is recommended. ping
	related
From: Alessandro Sappia <a.sappia@ngi.it>
Reply-To: a.sappia@ngi.it
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1077676638.8323.7.camel@galileo.homenet.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 25 Feb 2004 03:37:19 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

if remote network is down... ping tells me that...

$ ping www.google.it
PING www.google.akadns.net (216.239.59.104) 56(84) bytes of data.
64 bytes from 216.239.59.104: icmp_seq=1 ttl=236 time=62.4 ms
64 bytes from 216.239.59.104: icmp_seq=2 ttl=236 time=57.1 ms
 
--- www.google.akadns.net ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 1001ms
rtt min/avg/max/mdev = 57.147/59.778/62.410/2.642 ms

$ ping www.huljet.it
PING www.huljet.it (151.36.102.249) 56(84) bytes of data.
WARNING: kernel is not very fresh, upgrade is recommended.
>From 151.6.33.78: icmp_seq=2 (BAD CHECKSUM)Destination Host Unreachable
>From 151.6.33.78: icmp_seq=3 (BAD CHECKSUM)Destination Host Unreachable
>From 151.6.33.78: icmp_seq=4 (BAD CHECKSUM)Destination Host Unreachable
 
--- www.huljet.it ping statistics ---
4 packets transmitted, 0 received, +3 errors, 100% packet loss, time
3003ms
 
$

googled (answer refered to 2.4.12)
It looks like a kernel bug. ping sets van icmp filter so it will
only receive source quence, redirect and echo reply icmp packets
but it still received another icmp packet.

what about it ?

$ uname -a
Linux galileo 2.6.2-ck1 #2 Mon Feb 23 16:22:01 CET 2004 i686 Mobile Intel(R) Pentium(R) 4 - M CPU 1.90GHz GenuineIntel GNU/Linux
$ gcc --version
gcc (GCC) 3.3.3 20040217 (Gentoo Linux 3.3.3, propolice-3.3-7)
Copyright (C) 2003 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.


