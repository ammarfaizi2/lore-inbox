Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261435AbSIZSf0>; Thu, 26 Sep 2002 14:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261436AbSIZSf0>; Thu, 26 Sep 2002 14:35:26 -0400
Received: from web21407.mail.yahoo.com ([216.136.232.77]:59519 "HELO
	web21407.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S261435AbSIZSfZ>; Thu, 26 Sep 2002 14:35:25 -0400
Message-ID: <20020926183815.30877.qmail@web21407.mail.yahoo.com>
Date: Thu, 26 Sep 2002 11:38:15 -0700 (PDT)
From: Venkatesh Rao <rpranesh@yahoo.com>
Subject: Problems with tcp_retransmit_skb
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I have a strange problem with tcp_retransmit_skb. I
will describe my setup before i describe my problem.

Setup:
ucLinux 2.4.10 based kernel running on a embedded
processor (coldfire) with 40 MIPS processing
capablity.

Problem:
This embedded system sends relatively huge amount of
data (~1.5MB/s) over ethernet to a remote system which
process the data. On a normal case it all works great.
But when there is a lot of traffic on the network
(simulated by running flood ping between two desktop
linux systems connected to the same hub as this
embedded system), embedded systems Linux TCP/IP stack
go haywire. 

More details:
Since there is a high traffic on the network, the
embedded system cannot transmit packet and this
triggers tcp retransmit in the stack. 

But the first check on the tcp_transmit_skb fails

if (atomic_read(&sk->wmem_alloc) > min_t(int,
sk->wmem_queued+(sk->wmem_queued>>2),sk->sndbuf))



__________________________________________________
Do you Yahoo!?
New DSL Internet Access from SBC & Yahoo!
http://sbc.yahoo.com
