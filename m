Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132368AbRARObf>; Thu, 18 Jan 2001 09:31:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130425AbRARObU>; Thu, 18 Jan 2001 09:31:20 -0500
Received: from mail5.svr.pol.co.uk ([195.92.193.20]:11050 "EHLO
	mail5.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S130077AbRAROaz>; Thu, 18 Jan 2001 09:30:55 -0500
Date: Thu, 18 Jan 2001 14:34:08 +0000 (GMT)
From: James Stevenson <mistral@stev.org>
To: linux-kernel@vger.kernel.org
Subject: [PF_PACKET] and failed checksums
Message-ID: <Pine.LNX.4.21.0101181421400.7439-100000@cyrix.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-BadReturnPath: mistral@cyrix.home rewritten as mistral@stev.org
  using "From" header
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi

when i use a PF_PACKET / raw socket when i read data from the
socket everything is fine apart from udp packets which are going to
the machine on port 2049 sometimes the checksums fail i belive that
the data might be getting changed on the udp pakcet somewhere inside the
kernel as with the same program on another machine sees the packets
fine (no csum error) on the way into the machine. and also the kernel
does not report a checksum error though the data out of the raw socket
seems not to be the same but however this only seems to happen on a
machine which is an nfs server and only on packets to the nfs 
server port [2049] 

would anyone be able to shed some light on this ?

greatly shortend log below

UDP 192.168.1.2[690] -> 192.168.1.1[701] Len:48
UDP 192.168.1.1[701] -> 192.168.1.2[690] Len:28
UDP 192.168.1.1[2540] -> 192.168.1.1[701] Len:80
UDP 192.168.1.1[701] -> 192.168.1.1[2540] Len:32
UDP 192.168.1.1[2540] -> 192.168.1.3[53] Len:42
UDP 192.168.1.3[53] -> 192.168.1.1[2540] Len:119
UDP 192.168.1.1[2540] -> 192.168.1.1[701] Len:80
UDP 192.168.1.1[701] -> 192.168.1.1[2540] Len:32
UDP 192.168.1.1[2540] -> 192.168.1.3[53] Len:42
UDP linux.home[2540] -> 192.168.1.3[53] Len:42
UDP ns.home[53] -> linux.home[2540] Len:113
FAILED UDP CHECKSUM: cyrix.home -> linux.home Packet: 26765 Sniffer: 43102 L:124
UDP linux.home[2049] -> cyrix.home[800] Len:128
UDP cyrix.home[800] -> linux.home[2049] Len:140
UDP linux.home[2049] -> cyrix.home[800] Len:96
UDP linux.home[2049] -> cyrix.home[800] Len:96
FAILED UDP CHECKSUM: cyrix.home -> linux.home Packet: 25007 Sniffer: 40064 L:124
UDP linux.home[2049] -> cyrix.home[800] Len:128
UDP cyrix.home[800] -> linux.home[2049] Len:140
UDP linux.home[2049] -> cyrix.home[800] Len:96
UDP linux.home[2049] -> cyrix.home[800] Len:96
FAILED UDP CHECKSUM: cyrix.home -> linux.home Packet: 17756 Sniffer: 31277 L:120
UDP linux.home[2049] -> cyrix.home[800] Len:128
UDP cyrix.home[800] -> linux.home[2049] Len:140
FAILED UDP CHECKSUM: cyrix.home -> linux.home Packet: 16044 Sniffer: 28285 L:120
UDP linux.home[2049] -> cyrix.home[800] Len:128
UDP cyrix.home[800] -> linux.home[2049] Len:140
UDP linux.home[2049] -> cyrix.home[800] Len:96

-- 
---------------------------------------------
Check Out: http://stev.org
E-Mail: mistral@stev.org
  2:20pm  up 2 days, 21:41,  3 users,  load average: 0.14, 0.25, 0.15

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
