Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263894AbTGPGZI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 02:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269961AbTGPGZI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 02:25:08 -0400
Received: from magic-mail.adaptec.com ([208.236.45.100]:29082 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP id S263894AbTGPGZE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 02:25:04 -0400
Date: Wed, 16 Jul 2003 12:43:24 +0530 (IST)
From: Nagendra Singh Tomar <nagendra_tomar@adaptec.com>
X-X-Sender: tomar@localhost.localdomain
Reply-To: nagendra_tomar@adaptec.com
To: linux-kernel@vger.kernel.org
Subject: lock_sock and friends !
Message-ID: <Pine.LNX.4.44.0307161243130.4633-100000@localhost.localdomain>
Organization: Adaptec
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I posted this on linux-net and did not get any reply, hoping to get a  
reply here ..


---------- Forwarded message ----------
Date: Tue, 15 Jul 2003 11:52:35 +0530
From: "Tomar, Nagendra" <nagendra_tomar@adaptec.com>
To: linux-net@vger.kernel.org
Subject: lock_sock and friends !

Hi,
   From reading the Linux 2.4 networking code I can figure out that any 
activity that can change the state of the socket (it can be sequence 
numbers getting updated or geting more free sndbuf memory because of
some 
packet on the retransmission queue being ACKed) is done after taking the

socket lock (lock_sock from user context and bh_lock_sock from BH 
context).
I would like some authority on this to confirm this. Is the following 
statement true.
At any time (even on SMP machines) only one piece of the code will be 
working on a socket. Of course the piece of code in question is one that

changes the state of the socket, either by processing a newly received 
packet or by calling tcp_free_skb() to add to the free socket memory.

If any clarification is needed pls feel free to contact me.

Any comments are highly welcome.

Thanx
tomar

-
To unsubscribe from this list: send the line "unsubscribe linux-net" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html


