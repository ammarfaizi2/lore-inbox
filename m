Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277316AbRJEFqB>; Fri, 5 Oct 2001 01:46:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277315AbRJEFpw>; Fri, 5 Oct 2001 01:45:52 -0400
Received: from wolf.ericsson.net.nz ([203.97.68.250]:58268 "EHLO
	wolf.ericsson.net.nz") by vger.kernel.org with ESMTP
	id <S277308AbRJEFph>; Fri, 5 Oct 2001 01:45:37 -0400
Date: Fri, 5 Oct 2001 17:46:03 +1200 (NZST)
From: Mark Henson <kern@wolf.ericsson.net.nz>
To: <linux-kernel@vger.kernel.org>
Subject: Throughput @100Mbs on link of ~10ms latency
Message-ID: <Pine.LNX.4.33.0110051704430.16678-100000@wolf.ericsson.net.nz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Can someone give me a pointer to a FAQ on how to tune a 2.4 machine to
achieve high throughput (approx i/f speed 100Mbits/sec) on a link with the
following characteristics:



Latency		Throughput

9-10ms		3.8 MByte/s
3-4ms		7-8MByte/s

I have implemented:

echo "4096 87380 4194304" > /proc/sys/net/ipv4/tcp_rmem
echo "4096 65536 4194304" > /proc/sys/net/ipv4/tcp_wmem

from http://www-didc.lbl.gov/tcp-wan.html

this lifted the performance from ~1MByte/s to the 3.8 above.

When the receiving machine is freebsd I get 10.05 MBytes/s which
is interesting - but when sending from BSD I get the same rate.

cheers
Mark


[root@tsaturn ncftp]# lsmod
Module                  Size  Used by
autofs                 11264   1  (autoclean)
3c59x                  25344   1  (autoclean)
e100                   44240   1  (autoclean)
ipchains               38976   0  (unused)



