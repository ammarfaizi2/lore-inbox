Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133084AbRDVAdk>; Sat, 21 Apr 2001 20:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133085AbRDVAdb>; Sat, 21 Apr 2001 20:33:31 -0400
Received: from sunny.pacific.net.sg ([203.120.90.127]:27848 "EHLO
	sunny.pacific.net.sg") by vger.kernel.org with ESMTP
	id <S133084AbRDVAdX>; Sat, 21 Apr 2001 20:33:23 -0400
Message-ID: <3AE2276A.25E7430A@classical.2y.net>
Date: Sun, 22 Apr 2001 08:35:55 +0800
From: joker <linux@classical.2y.net>
X-Mailer: Mozilla 4.77 [en] (Win98; U)
X-Accept-Language: zh,zh-TW,zh-CN,en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: dhcpd help please
In-Reply-To: <3AE2328A.10703@eisenstein.dk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have problem starting dhcpd, this first time try out any 1 can help me
this error message. any can point out my problem
10q in advance

[root@classical]# dhcpd eth0
Internet Software Consortium DHCP Server 2.0pl5
Copyright 1995, 1996, 1997, 1998, 1999 The Internet Software Consortium.
All rights reserved.

Please contribute if you find this software useful.
For info, please visit http://www.isc.org/dhcp-contrib.html

Listening on LPF/eth0/00:01:02:83:51:7e/192.168.8.0
Sending on   LPF/eth0/00:01:02:83:51:7e/192.168.8.0
Can't bind to dhcp address: Address already in use
exiting.
--------------------
[root@homepc]# route -n
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
192.168.8.0     0.0.0.0         255.255.255.0   U     0      0        0 eth0
203.56.56.0    0.0.0.0         255.255.252.0   U     0      0        0 eth1
127.0.0.0       0.0.0.0         255.0.0.0       U     0      0        0 lo
0.0.0.0         203.56.56.1    0.0.0.0         UG    0      0        0 eth1
[f00l@classical f00l]#

---------------------------
[f00l@classical /etc]# cat dhcpd.conf
# Sample /etc/dhcpd.conf
# (add your comments here)
default-lease-time 600;
max-lease-time 7200;
option subnet-mask 255.255.255.0;
option broadcast-address 192.168.8.255;
option routers 192.168.8.254;
option domain-name-servers 203.56.1.21,203.56.1.22;
option domain-name "homepc.linux.org";
option netbios-name-servers 192.168.8.1;

subnet 192.168.8.0 netmask 255.255.255.0 {
   range 192.168.8.30 192.168.8.35;
}




