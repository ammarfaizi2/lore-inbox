Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132527AbRDHJct>; Sun, 8 Apr 2001 05:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132533AbRDHJck>; Sun, 8 Apr 2001 05:32:40 -0400
Received: from [194.228.216.178] ([194.228.216.178]:23819 "EHLO
	linux2.sanitas.cz") by vger.kernel.org with ESMTP
	id <S132527AbRDHJca>; Sun, 8 Apr 2001 05:32:30 -0400
Message-ID: <001c01c0c00f$7ce070a0$0200a8c0@kulich.cz>
From: "Oldrich Kepka" <kernel@sanitas.cz>
To: <linux-kernel@vger.kernel.org>
Subject: new queuing discipline
Date: Sun, 8 Apr 2001 11:37:07 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2314.1300
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I am developing new queuing disciline. The purpose of this queue is to delay
outgoing packets. I wrote module sch_delay.o. This module implements delay_e
nqueue() and delay_dequeue() functions. I also modify tc to comunicate throu
gh netlink with my module. Because i want to dequeue only when there are suf
ficiently old packet on the top of the queue, i immediately return from dequ
eue function returning NULL. But the dequeue function is called only when so
me event occures. I found out, that i occures for example when there are new
packet in the queue. No other conditions i found. But i need repeatedly test
the top packet in the queue.

How to accomplish it?

Thanks
Olda




