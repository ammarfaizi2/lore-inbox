Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131799AbRAQOWB>; Wed, 17 Jan 2001 09:22:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132230AbRAQOVl>; Wed, 17 Jan 2001 09:21:41 -0500
Received: from penguin-ext.wise.edt.ericsson.se ([194.237.142.110]:49385 "EHLO
	penguin-ext.wise.edt.ericsson.se") by vger.kernel.org with ESMTP
	id <S131799AbRAQOVb>; Wed, 17 Jan 2001 09:21:31 -0500
To: linux-kernel@vger.kernel.org
Subject: SCHED_FIFO/SCHED_RR in 2.4 vs 2.2
Date: Wed, 17 Jan 2001 15:21:31 +0100
From: Patrik Hagglund <patha@softlab.ericsson.se>
Message-Id: <20010117142125.D4F2E583A@hunny.softlab.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a server program that communicates with a number of client
programs via TCP sockets. I have tried to measure the response time
of the server program by using a program similar to tcpdump (that
uses a packet socket).

However, when I run the server program on 2.4.0 within a
SCHED_FIFO or SCHED_RR scheduling class (instead of SCHED_OTHER)
the average response time gets better (and is more predictable)
but I occasionally get delays that seems to be multiples of 2
seconds, in the range of 2 to 26 seconds. I don't get this
behavior with 2.2.18.

Does anybody have some idea why I get this strange behavior on 2.4.0?

--
Patrik Hägglund
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
