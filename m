Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264318AbRFLKz5>; Tue, 12 Jun 2001 06:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264323AbRFLKzq>; Tue, 12 Jun 2001 06:55:46 -0400
Received: from mgw-x3.nokia.com ([131.228.20.26]:26077 "EHLO mgw-x3.nokia.com")
	by vger.kernel.org with ESMTP id <S264318AbRFLKzk>;
	Tue, 12 Jun 2001 06:55:40 -0400
Date: Tue, 12 Jun 2001 13:53:56 +0300
To: ext Emmanuel Varagnat <varagnat@crm.mot.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: sk_buff allocation
Message-ID: <20010612135356.A31447@Hews1193nrc>
In-Reply-To: <3B25F227.5A5EEBB4@crm.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <3B25F227.5A5EEBB4@crm.mot.com>
User-Agent: Mutt/1.3.18i
From: alexey.vyskubov@nokia.com (Alexey Vyskubov)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm writing a module that is able to modify outgoing packets.
> This is done by registering a new entry in ptype_all.
> But my problem is that in dev_queue_xmit_nit the sk_buff is
> cloned and that my function get this clone. So my modification
> on skb->data isn't take into account by the ethernet driver.

Why don't you use netfilter hooks? Write your hook for NF_IP_POST_ROUTING; it
will receive sk_buff **pskb, so you can completely replace old skbuff with new.

-- 
Alexey
