Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261400AbTCTGyQ>; Thu, 20 Mar 2003 01:54:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261396AbTCTGyQ>; Thu, 20 Mar 2003 01:54:16 -0500
Received: from w1312.hostcentric.net ([66.40.206.254]:32270 "HELO
	w1312.hostcentric.net") by vger.kernel.org with SMTP
	id <S261394AbTCTGyO>; Thu, 20 Mar 2003 01:54:14 -0500
Message-Id: <5.2.0.9.0.20030320124211.00a90270@mail.impulsesoft.com>
Illegal-Object: Syntax error in X-Sender: address found on vger.kernel.org:
	X-Sender:	nalin@impulsesoft.com@mail.impulsesoft.com
					     ^-illegal special character in phrase
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Thu, 20 Mar 2003 12:51:01 +0530
To: linux-kernel@vger.kernel.org
From: Nalin Gupta <nalin@impulsesoft.com>
Subject: sock_sendmsg( ) from tasklet/interrupt context
Cc: linux-net@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Friends,

Is it correct to invoke "sock_sendmsg"  for UDP 
socket,  from  "net_tx_action"  Tasklet  context.

I understand that tasklet is interrupt context, for this reason i masked

sock->sk->allocation &=  ~__GFP_WAIT;

even tried merely assigned GFP_ATOMIC

It always panic at    skb_head_from_pool / __skb_dequeue inline function 
called from alloc_skb.

Thanks in advance,

regards,
- nalin

