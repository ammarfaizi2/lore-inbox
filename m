Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131411AbRCNPMZ>; Wed, 14 Mar 2001 10:12:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131460AbRCNPMQ>; Wed, 14 Mar 2001 10:12:16 -0500
Received: from ns.cfrcta.ro ([212.93.137.147]:61197 "HELO mail.cfrcta.ro")
	by vger.kernel.org with SMTP id <S131414AbRCNPMD>;
	Wed, 14 Mar 2001 10:12:03 -0500
Message-ID: <3AAF8A14.5035DDAA@cfrcta.ro>
Date: Wed, 14 Mar 2001 17:11:16 +0200
From: Adrian Turcu <adi@cfrcta.ro>
Organization: Romanian Railway Company
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-adi-01 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Bond driver on kernel-2.4.2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm trying to use a bond device using two (2) ethernet NICs for two RH Linux nodes.
The link between the 2 Linux nodes is made it using 2 crossover cables for each NIC.

I did not find any additional docs for this except kernel help and something
in iputils package and probably I'm going wrong somewhere, because
after the devices (bond and ethXX) are up when I try to ping the other node
I got a lot of lost packages and the speed don't seems to be improved.

I'm using RedHat 6.2 with iputils-20001010-1.6x.rpm and 2.4.2-kernel with
bond driver built-in.

Here are the settings for one of nodes (the other is almost the same except IPs):

/etc/sysconfig/network-scrips/ifcfg-bond0:

DEVICE=bond0
USERCTL=no
ONBOOT=yes
BOOTPROTO=none
BROADCAST=192.168.1.255
NETWORK=192.168.1.0
NETMASK=255.255.255.0
IPADDR=192.168.1.198

/etc/sysconfig/network-scrips/ifcfg-eth0:

DEVICE=eth0
USERCTL=no
ONBOOT=yes
MASTER=bond0
SLAVE=yes
BOOTPROTO=none

/etc/sysconfig/network-scrips/ifcfg-eth1:

DEVICE=eth1
USERCTL=no
ONBOOT=yes
MASTER=bond0
SLAVE=yes
BOOTPROTO=none

/etc/host.conf

order hosts, bind
multi on

The /etc/hosts file contains the IPs for each of the nodes on both.

I have to mention that I cannot even open any TCP connection between nodes
which in normal case (without bond interface) is possible.

Any help will be highly appreciated,
Thank you


-- 
Adrian Turcu
System Administrator
