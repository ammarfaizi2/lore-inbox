Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261165AbUL2G7j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261165AbUL2G7j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 01:59:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261172AbUL2G7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 01:59:39 -0500
Received: from em.njupt.edu.cn ([202.119.230.11]:12209 "HELO njupt.edu.cn")
	by vger.kernel.org with SMTP id S261165AbUL2G7h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 01:59:37 -0500
Message-ID: <304306892.28448@njupt.edu.cn>
X-WebMAIL-MUA: [10.10.136.115]
From: "Zhenyu Wu" <y030729@njupt.edu.cn>
To: linux-kernel@vger.kernel.org
Date: Wed, 29 Dec 2004 15:54:52 +0800
Reply-To: "Zhenyu Wu" <y030729@njupt.edu.cn>
X-Priority: 3
Subject: VQs in Gred!
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

We know, VQs are used in Gred to offer different schedulers, in order to make
clear what the 
VQs are, I have read the sch_gred.c in net/sched/. In the function gred_enqueue(),
at first it will 
find the VQ(q) according to the lower four bits of the skb->tc_index, then some
parameters of the
q is modified, such as q->packetsin and q->bytesin. At last the packet was put
into the  physical
Queue using __skb_queue_tail(). When dequeue the packet, only the function
__skb_dequeue()
is called, and the VQ parameters are modified. Then the packets from all VQS will
enter and 
store in the physical queue (sch->q), and be dequeued from there. HOW does the
Gred schedule
packets of differnet priorities?

Thanks,



