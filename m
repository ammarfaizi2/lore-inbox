Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315953AbSEJM7R>; Fri, 10 May 2002 08:59:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315968AbSEJM7Q>; Fri, 10 May 2002 08:59:16 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:61614 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S315953AbSEJM7O>; Fri, 10 May 2002 08:59:14 -0400
Message-ID: <4457.192.168.100.10.1021035540.squirrel@deathstar.rocnet.de>
Date: Fri, 10 May 2002 14:59:00 +0200 (CEST)
Subject: error packets with syslog
From: "Claus Rosenberger" <Claus.Rosenberger@rocnet.de>
To: <linux-kernel@vger.kernel.org>
X-Priority: 3
Importance: Normal
X-MSMail-Priority: Normal
Reply-To: Claus.Rosenberger@rocnet.de
X-Mailer: SquirrelMail (version 1.2.6)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

we use two vpn gateways with ipsec and two terminal servers behind it.

one server write syslog entries to the other subnet accross the vpn. these
packets marked as error packets in the first gateway.

TerminalServer-1
          |
Gateway-1
          |
Gateway-2
          |
Destination for Logging


TerminalServer-1 has following syslog.conf entry :

 *.*   @10.2.4.6

Gateway-1 show following interface statistic, if syslog-rule is active :

eth0      Link encap:Ethernet  HWaddr 00:B0:D0:68:74:3E
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:47798 errors:0 dropped:0 overruns:0 frame:0
          TX packets:336401 errors:0 dropped:0 overruns:0 carrier:0
          collisions:231 txqueuelen:100
          Interrupt:5

eth1      Link encap:Ethernet  HWaddr 00:03:47:42:03:A7
          inet addr:10.1.1.1  Bcast:10.1.255.255  Mask:255.255.0.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:764146 errors:509636 dropped:509636 overruns:20263
          frame:0          TX packets:45921 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100
          Interrupt:11 Memory:fe000000-fe020000

ipsec0    Link encap:Ethernet  HWaddr 00:B0:D0:68:74:3E
          UP RUNNING NOARP  MTU:16260  Metric:1
          RX packets:17547 errors:0 dropped:5 overruns:0 frame:0
          TX packets:17639 errors:2030 dropped:0 overruns:0 carrier:2030
          collisions:0 txqueuelen:10

if i stopped the syslog-rule on TerminalServer-1 i didn't get any error
packets. if the rule is active i got a lot of them. why ?
informations of servers :

TerminalServer-1 : RedHat 7.0 with delivered RedHat-Kernel
Gateway-1 : RedHat 7.1 with Kernel 2.4.3 and FreeSWan 1.9.




