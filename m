Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261417AbUKSOUC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261417AbUKSOUC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 09:20:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbUKSOSO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 09:18:14 -0500
Received: from zhabb.mics.msu.su ([158.250.28.142]:51645 "EHLO
	zhabb.mics.msu.su") by vger.kernel.org with ESMTP id S261430AbUKSORc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 09:17:32 -0500
X-SMScore: 0
X-SMRecipient: linux-kernel@vger.kernel.org
From: Peter Volkov Alexandrovich <pvolkov@mics.msu.su>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6 and route nat. Who know what is going on?
Date: Fri, 19 Nov 2004 17:20:13 +0300
User-Agent: KMail/1.7.1
Organization: GPI RAN
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411191720.13423.pvolkov@mics.msu.su>
X-OriginalArrivalTime: 19 Nov 2004 14:20:06.0703 (UTC) FILETIME=[DE5D33F0:01C4CE42]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

The problem I have is route nat.

Short question: Must "route nat", mentioned in ip-cref documentation coming 
with iproute2 package, work with 2.6.9 kernel?

Long question and description of the problem:
There is an appendix C in ip-cref by Alexey Kuznetsov called "Route NAT 
Status". I've followed this configuration with 2.4.2x kernel and everything 
works. But now I'm forced to move to 2.6.9 kernel due to new SATA controller 
in my server. And problem is that it is not working. When I issue:

# ip route nat <inet_ip_address> via <local_ip_address>

I the answer is: RTNETLINK answers: invalid argument

So seems like some option is not enabled in my kernel. Well actually I have 
all options and suboptions enabled in my kernel configuration under "TCP/IP 
networking" -> "IP: advanced router".

I've tried 2.6.8.1 kernel. And found out that there exist option "IP: fast 
network address translation" under "IP: advanced router" that is absent in 
2.6.9. When I enable this option the kernel seems to accept my command. My 
router starts to answer arp requests for <inet_ip_addres>, as it should. But 
no route DNAT seems to occur. If I add some LOG rule to FORWARD iptables chain 
I can see packets to <inet_ip_address> being forwarded but not DNATed as it 
should.

Who supports this route nat code in the kernel? Are they going to support this 
cool feature or it's deprecated and I should look for other solution? How 
can this be done???

I've tried to google and I've even tried to find an answer in sources, but 
with no success also. I've asked about this about in LARTC mailing list, where 
Anwara suggested me to ask for help on this list.

If this is the wrong place to ask my question or anybody knows the right place 
for this question, please tell me.

Thank you very much in advance,
-- 

______________________________________

Volkov Peter, <pvolkov@mics.msu.su>
Moscow State University, Phys. Dep.
______________________________________

NO ePATENTS, eSIGN now on:
http://petition.eurolinux.org
and maybe this helps...

Linux 2.4.26-gentoo-r9 i686
Mobile Intel(R) Celeron(R) CPU 1.60GHz
