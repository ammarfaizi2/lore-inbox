Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283287AbRK2Pt6>; Thu, 29 Nov 2001 10:49:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283286AbRK2Pts>; Thu, 29 Nov 2001 10:49:48 -0500
Received: from [64.42.30.110] ([64.42.30.110]:23561 "HELO mail.clouddancer.com")
	by vger.kernel.org with SMTP id <S283282AbRK2Ptk>;
	Thu, 29 Nov 2001 10:49:40 -0500
To: irajasek@in.ibm.com, linux-kernel@vger.kernel.org
Message-Id: <20011129154451.BF6667843A@phoenix.clouddancer.com>
Date: Thu, 29 Nov 2001 07:44:51 -0800 (PST)
From: klink@clouddancer.com (Colonel)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colonel <klink@clouddancer.com>
To: irajasek@in.ibm.com
CC: linux-kernel@vger.kernel.org
In-reply-to: <OF8DFA00F6.3DAC22D2-ON65256B31.003CB38A@in.ibm.com>
	(irajasek@in.ibm.com)
Subject: Re: Routing table problems
Reply-to: klink@clouddancer.com
In-Reply-To:  <OF8DFA00F6.3DAC22D2-ON65256B31.003CB38A@in.ibm.com>

   From: "Rajasekhar Inguva" <irajasek@in.ibm.com>
   Date:	Sat, 29 Dec 2001 17:17:48 +0530

   I am facing a problem ( ???, maybe it works that way, but i really dont
   know ) with regards to routing table behavior when using ifconfig on a
   network interface.

   1) netstat -nr      Shows my default gateway for network 0.0.0.0

   2) ifconfig eth0 down

   3) netstat -nr      No entry for the default gateway is shown (
   understandable )

   4) ifconfig eth0 up

   After the the 4'th command, my interface is up and has it's IP address set
   correctly. But .....

   netstat -nr  does not show my default gateway for network 0.0.0.0 !!.
   Pinging any IP outside of my subnet, results in "Network is unreachable"
   error.


While the linux kernel is certainly omnipotent, it's crystal ball is
sometimes hazy.  How would it know what the default gateway should
be???  Typically after the interface is configured, you command:

/sbin/route add default gw $GATEWAY netmask 0.0.0.0 metric 1

Some routing daemons will handle that for you, but even they need
appropriate configuration.



