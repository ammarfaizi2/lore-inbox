Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266771AbTAIPnh>; Thu, 9 Jan 2003 10:43:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266792AbTAIPnh>; Thu, 9 Jan 2003 10:43:37 -0500
Received: from home.wiggy.net ([213.84.101.140]:54942 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id <S266771AbTAIPnf>;
	Thu, 9 Jan 2003 10:43:35 -0500
Date: Thu, 9 Jan 2003 16:52:14 +0100
From: Wichert Akkerman <wichert@wiggy.net>
To: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: ipv6 stack seems to forget to send ACKs
Message-ID: <20030109155214.GX22951@wiggy.net>
Mail-Followup-To: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
References: <20030108130850.GQ22951@wiggy.net> <20030109123857.A15625@bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030109123857.A15625@bitwizard.nl>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously Rogier Wolff wrote:
> Can you check the stats counters, to see if they are indeed dropped?

It seems no packets are dropped:

Ip:
    269716 total packets received
    0 forwarded
    0 incoming packets discarded
    206853 incoming packets delivered
    221800 requests sent out
    75513 reassemblies required
    12713 packets reassembled ok
    10798 fragments created
Icmp:
    0 ICMP messages received
    0 input ICMP message failed.
    ICMP input histogram:
    0 ICMP messages sent
    0 ICMP messages failed
    ICMP output histogram:
Tcp:
    666 active connections openings
    0 passive connection openings
    0 failed connection attempts
    0 connection resets received
    2 connections established
    58949 segments received
    65043 segments send out
    0 segments retransmited
    18 bad segments received.
    82 resets sent
TcpExt:
    ArpFilter: 0
    7 TCP sockets finished time wait in fast timer
    1091 delayed acks sent
    2 delayed acks further delayed because of locked socket
    6 packets directly queued to recvmsg prequeue.
    6 packets directly received from prequeue
    52427 packets header predicted
    TCPPureAcks: 1259
    TCPHPAcks: 10858
    TCPRenoRecovery: 0
    TCPSackRecovery: 0
    TCPSACKReneging: 0
    TCPFACKReorder: 0
    TCPSACKReorder: 0
    TCPRenoReorder: 0
    TCPTSReorder: 0
    TCPFullUndo: 0
    TCPPartialUndo: 0
    TCPDSACKUndo: 0
    TCPLossUndo: 0
    TCPLoss: 0
    TCPLostRetransmit: 0
    TCPRenoFailures: 0
    TCPSackFailures: 0
    TCPLossFailures: 0
    TCPFastRetrans: 0
    TCPForwardRetrans: 0
    TCPSlowStartRetrans: 0
    TCPTimeouts: 0
    TCPRenoRecoveryFail: 0
    TCPSackRecoveryFail: 0
    TCPSchedulerFailed: 0
    TCPRcvCollapsed: 0
    TCPDSACKOldSent: 0
    TCPDSACKOfoSent: 0
    TCPDSACKRecv: 0
    TCPDSACKOfoRecv: 0
    TCPAbortOnSyn: 0
    TCPAbortOnData: 24
    TCPAbortOnClose: 67
    TCPAbortOnMemory: 0
    TCPAbortOnTimeout: 0
    TCPAbortOnLinger: 0
    TCPAbortFailed: 0
    TCPMemoryPressures: 0

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>           http://www.wiggy.net/
A random hacker
