Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261483AbUL3Amh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261483AbUL3Amh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 19:42:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261477AbUL3AmD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 19:42:03 -0500
Received: from em.njupt.edu.cn ([202.119.230.11]:13503 "HELO njupt.edu.cn")
	by vger.kernel.org with SMTP id S261483AbUL3Akv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 19:40:51 -0500
Message-ID: <304370586.05150@njupt.edu.cn>
X-WebMAIL-MUA: [10.10.136.115]
From: "Zhenyu Wu" <y030729@njupt.edu.cn>
To: tgraf@suug.ch
Cc: linux-kernel@vger.kernel.org
Date: Thu, 30 Dec 2004 09:36:26 +0800
Reply-To: "Zhenyu Wu" <y030729@njupt.edu.cn>
X-Priority: 3
Subject: Re: VQs in Gred!
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > HOW does the Gred schedule packets of differnet priorities?
> 
> The packets are all enqueued onto the same queue. Gred is not
> about prioritizing but only about dropping, hence once the packet
> is enqueued it doesn't make sense to differ anymore. The difference

Ok. Then, if the average packet(qave) does not exceed the threshhold, that is, the
packet has not been dropped, it will be enqueued into the physical queue, right?
So we can't see the different process of scheduling packets which are from
different kinds of traffic, we just know which packet might be dropped, right?

> to normal red is that one can use separate red calculation
> parameters per tcindex flow. tcindex is usually set via dsmark/
> tcindex with contents of the dscp field. You might want to use a
> more aggressive set of parameters for your bulk flows and treat
> your interactive flows with more respect.

what does "the more aggressive set of parameters" mean? The parameters to Gred?

Thank you very much!
Best,


