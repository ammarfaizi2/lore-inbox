Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264639AbUHJMYh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264639AbUHJMYh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 08:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264585AbUHJMYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 08:24:37 -0400
Received: from smtp.rol.ru ([194.67.21.9]:3799 "EHLO smtp.rol.ru")
	by vger.kernel.org with ESMTP id S264639AbUHJMYE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 08:24:04 -0400
Message-ID: <4118BEFD.9090605@vlnb.net>
Date: Tue, 10 Aug 2004 16:26:37 +0400
From: Vladislav Bolkhovitin <vst@vlnb.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: ru, en-us
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com
Subject: Re: [PATCH] x86 bitops.h commentary on instruction reordering
References: <2pY7Y-W1-7@gated-at.bofh.it> <2qdJL-3sh-27@gated-at.bofh.it>	<2qePx-4eM-21@gated-at.bofh.it> <2qf8S-4pI-31@gated-at.bofh.it>	<2qg4V-54c-17@gated-at.bofh.it> <2qgoh-5og-29@gated-at.bofh.it>	<2qhkn-649-41@gated-at.bofh.it> <2rkgh-zP-45@gated-at.bofh.it>	<2rlFk-1wC-27@gated-at.bofh.it> <2rmhX-20I-17@gated-at.bofh.it>	<2roWw-40d-19@gated-at.bofh.it> <2roWw-40d-17@gated-at.bofh.it> <m3657st39b.fsf@averell.firstfloor.org>
In-Reply-To: <m3657st39b.fsf@averell.firstfloor.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> That makes them a *lot* slower on some systems. And most of the
> set_bits in the kernel don't need strong ordering.
> 
> 
>>difference with versions with `__` prefix (__set_bit(), for example)?
>>Just adding the comments will lead to creating different functions
>>with gurantees by everyone who need it in all over the kernel. Is it
>>the right thing? In some places in SCST we heavy rely on non-ordering
>>guarantees.
> 
> 
> Better add lots of memory barriers then.

It looks like we have to do that now.

Thanks,
Vlad
