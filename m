Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267024AbTBLLsF>; Wed, 12 Feb 2003 06:48:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267043AbTBLLsF>; Wed, 12 Feb 2003 06:48:05 -0500
Received: from [212.122.164.10] ([212.122.164.10]:6016 "EHLO pechkin.minfin.bg")
	by vger.kernel.org with ESMTP id <S267024AbTBLLsB>;
	Wed, 12 Feb 2003 06:48:01 -0500
Reply-To: <larry@minfin.bg>
From: "Kostadin Karaivanov" <larry@minfin.bg>
To: <linux-kernel@vger.kernel.org>
Subject: Strange TCP with 2.5.60 
Date: Wed, 12 Feb 2003 13:52:27 +0200
Message-ID: <000801c2d28d$376df550$1504a8c0@larry2>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4920.2300
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trying to use traceroute i get folowing error:

root@larry:~# uname -a
Linux larry 2.5.60 #20 Tue Feb 11 17:38:42 EET 2003 i686 unknown
root@larry:~# traceroute www.kernel.org
traceroute: findsaddr: Can't find interface

Networking works....... but command route can't give me the status of
default route:

root@larry:~# route -n
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use
Iface
192.168.0.0     0.0.0.0         255.255.240.0   U     0      0        0 eth0
127.0.0.0       0.0.0.0         255.0.0.0       U     0      0        0 lo
root@larry:~# ip route list
192.168.0.0/20 dev eth0  proto kernel  scope link  src 192.168.1.12
127.0.0.0/8 dev lo  scope link
default via 192.168.1.1 dev eth0  metric 1
root@larry:~#

The version of traceroute is 1.4a12
The version of route is net-tools 1.60 / route 1.98 (2001-04-15)

iptables doesn't work as expected too.....

root@larry:~# iptables -A INPUT -i lo -j ACCEPT
root@larry:~# iptables -L -n
Chain INPUT (policy ACCEPT)
target     prot opt source               destination
ACCEPT     all  --  0.0.0.0/0            0.0.0.0/0

Chain FORWARD (policy ACCEPT)
target     prot opt source               destination

Chain OUTPUT (policy ACCEPT)
target     prot opt source               destination

everything works fine with 2.5.59 and 2.4.20

I can provide any additional information if needed



Kostadin Karaivanov
Senior System Administrator @ Ministry Of Finance
tel: +359 2 98592062
larry@minfin.bg

