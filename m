Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130636AbRAWLCs>; Tue, 23 Jan 2001 06:02:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130681AbRAWLCi>; Tue, 23 Jan 2001 06:02:38 -0500
Received: from inet-smtp3.oracle.com ([205.227.43.23]:30181 "EHLO
	inet-smtp3.oracle.com") by vger.kernel.org with ESMTP
	id <S130636AbRAWLC3>; Tue, 23 Jan 2001 06:02:29 -0500
Message-ID: <3A6D6417.2C6AD35@oracle.com>
Date: Tue, 23 Jan 2001 11:59:35 +0100
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Support Services
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: xircom_tulip_cb reports wrong stats in /proc/net/dev
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Happens on 2.4.1pre10 as well. On the crossed Ethernet cable to my cheap
 home ne2k-pci @ 10Mbit stats are correct. /proc/net/dev is wrong, so
 it doesn't matter if I use 'ifconfig' or 'ip'. Figures in "errs" are
 exactly the same as "carrier" and grow for example by simply pinging a
 remote host. Output of ifconfig/ip:

[asuardi@princess asuardi]$ ifconfig eth0
eth0      Link encap:Ethernet  HWaddr 00:10:A4:F9:19:A0  
          inet addr:144.24.10.49  Bcast:144.24.10.255  Mask:255.255.255.0
          UP BROADCAST NOTRAILERS RUNNING  MTU:1500  Metric:1
          RX packets:9488 errors:0 dropped:0 overruns:0 frame:0
          TX packets:2 errors:3221 dropped:0 overruns:0 carrier:3221
          collisions:0 txqueuelen:100 
          Interrupt:11 Base address:0x1800 

[asuardi@princess asuardi]$ ip -s link show eth0
2: eth0: <BROADCAST,NOTRAILERS,UP> mtu 1500 qdisc pfifo_fast qlen 100
    link/ether 00:10:a4:f9:19:a0 brd ff:ff:ff:ff:ff:ff
    RX: bytes  packets  errors  dropped overrun mcast   
    3676327    9901     0       0       0       0      
    TX: bytes  packets  errors  dropped carrier collsns 
    132        2        3223    0       3223    0      

The other difference in respect to my home setup is that this is DHCP,
 while I set up a fixed IP address at home.

Any ideas ? Thanks in advance,

--alessandro      <alessandro.suardi@oracle.com> <asuardi@uninetcom.it>

Linux:  kernel 2.2.19p7/2.4.1p10 glibc-2.2 gcc-2.96-69 binutils-2.10.1.0.4
Oracle: Oracle8i 8.1.7.0.0 Enterprise Edition for Linux
motto:  Tell the truth, there's less to remember.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
