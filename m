Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262418AbUHIPRl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262418AbUHIPRl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 11:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265944AbUHIPPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 11:15:16 -0400
Received: from smtp.rol.ru ([194.67.21.9]:61608 "EHLO smtp.rol.ru")
	by vger.kernel.org with ESMTP id S264238AbUHIPMO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 11:12:14 -0400
Message-ID: <411794E8.6000806@vlnb.net>
Date: Mon, 09 Aug 2004 19:14:48 +0400
From: Vladislav Bolkhovitin <vst@vlnb.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: ru, en-us
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86 bitops.h commentary on instruction reordering
References: <20040805200622.GA17324@logos.cnet> <411392E0.6080507@vlnb.net> <20040806143359.GC20911@logos.cnet> <4113A579.5060702@vlnb.net> <20040806155328.GA21546@logos.cnet> <4113B752.7050808@vlnb.net> <20040806170931.GA21683@logos.cnet>
In-Reply-To: <20040806170931.GA21683@logos.cnet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
>>>Yes correct. *mb() usually imply barrier(). 
>>>
>>>About the flush, each architecture defines its own instruction for doing 
>>>so,
>>>PowerPC has  "sync" and "isync" instructions (to flush the whole cache 
>>>and instruction cache respectively), MIPS has "sync" and so on..
>>
>>So, there is no platform independent way for doing that in the kernel?
> 
> 
> Not really. x86 doesnt have such an instruction.

But how then spin_lock() works? It guarantees memory sync between CPUs, 
doesn't it? Otherwise how can it prevent possible races with concurrent 
data modifications?

Vlad
