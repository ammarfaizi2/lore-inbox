Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267515AbUI1DNZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267515AbUI1DNZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 23:13:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267517AbUI1DNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 23:13:25 -0400
Received: from rproxy.gmail.com ([64.233.170.195]:31560 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267515AbUI1DNU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 23:13:20 -0400
Message-ID: <da99aff004092720138ba398a@mail.gmail.com>
Date: Mon, 27 Sep 2004 23:13:20 -0400
From: Madhu Bandireddy <mbandireddy@gmail.com>
Reply-To: Madhu Bandireddy <mbandireddy@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Help: Connection drops with kernel 2.4.21-15 over Broadcom NetXtreme BCM5703 gigabit cards
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We are seeing a large number of connection drops on our SAP
application servers with the following config:

Linux: Redhat Enterprise 3.0
Kernel: 2.4.21-15
HW: Dell 2650 with Broadcom NetXtreme BCM5703 gigabit ethernet card
CPU: 2x 2.8GHz
Memory: 12GB
Ethernet driver: Tigon 3.0

We could not find any errors on the interface itself. We are seeing
most of these connections drops from sites which are connected to our
data center over site-to-site VPN connections with high latencies.
In addition to the Linux servers in our SAP application server set we
also have 2 HP PA-RISC servers running HPUX 11.0 server. We do not see
any such connection drop problems on the HPUX servers. This makes us
believe that the problem is more related to the Linux environment.
Another thing to note is that these connection drops seem to occur
when there a large number of connections (about 500 or so) to each
server.

SAP seems to think this an OS problem. We do not see any error
messages in any of the system logs or on the ethernet interfaces. The
network itself does not show any errors.

Here is the output of netstat -s:
lnas4 Fri Sep 24 11:11:07 CDT 2004
Tcp:
   27157 active connections openings
   37507 passive connection openings
   4 failed connection attempts
   318 connection resets received
   209 connections established
   70267903 segments received
   64033785 segments send out
   49041 segments retransmited
   395 bad segments received.
   3269 resets sent
TcpExt:
   3 packets pruned from receive queue because of socket buffer overrun
   16 ICMP packets dropped because socket was locked
   ArpFilter: 0
   31311 TCP sockets finished time wait in fast timer
   920380 delayed acks sent
   206 delayed acks further delayed because of locked socket
   Quick ack mode was activated 19329 times
   64619380 packets directly queued to recvmsg prequeue.
   337477000 packets directly received from backlog
   1199298288 packets directly received from prequeue
   48 packets dropped from prequeue
   1503618 packets header predicted
   64689963 packets header predicted and directly queued to user
   TCPPureAcks: 740615
   TCPHPAcks: 48292250
   TCPRenoRecovery: 0
   TCPSackRecovery: 675
   TCPSACKReneging: 0
   TCPFACKReorder: 5
   TCPSACKReorder: 2
   TCPRenoReorder: 0
   TCPTSReorder: 0
   TCPFullUndo: 0
   TCPPartialUndo: 0
   TCPDSACKUndo: 0
   TCPLossUndo: 5
   TCPLoss: 641
   TCPLostRetransmit: 0
   TCPRenoFailures: 0
   TCPSackFailures: 2879
   TCPLossFailures: 281
   TCPFastRetrans: 804
   TCPForwardRetrans: 11
   TCPSlowStartRetrans: 30896
   TCPTimeouts: 5143
   TCPRenoRecoveryFail: 0
   TCPSackRecoveryFail: 174
   TCPSchedulerFailed: 1
   TCPRcvCollapsed: 146
   TCPDSACKOldSent: 3987
   TCPDSACKOfoSent: 203
   TCPDSACKRecv: 39
   TCPDSACKOfoRecv: 0
   TCPAbortOnSyn: 0
   TCPAbortOnData: 10
   TCPAbortOnClose: 1
   TCPAbortOnMemory: 0
   TCPAbortOnTimeout: 222
   TCPAbortOnLinger: 0
   TCPAbortFailed: 0
   TCPMemoryPressures: 0

Since the problem seems to be with connections over site-to-site VPN
and are generally more pronounced during periods of high loads. I
believe this is more a tuning issue or a bug.

Any help in resolving this problem is greatly appreciated.

Thanks
Madhu
