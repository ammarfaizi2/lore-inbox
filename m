Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264231AbUE2Jqt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264231AbUE2Jqt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 05:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264238AbUE2Jqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 05:46:49 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:59572 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S264231AbUE2Jqr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 05:46:47 -0400
Message-ID: <40B85C05.5080302@colorfullife.com>
Date: Sat, 29 May 2004 11:46:45 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.4.1) Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC,PATCH] use nonatomic bitops for cpumask_t
References: <40B85071.8090402@colorfullife.com>
In-Reply-To: <40B85071.8090402@colorfullife.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:

> Hi,
>
> I'm checking for callers that rely on the atomicity of the bitops, but 
> so far everyone has it's own locks.

One exception is the x86 tlb flush code, thus my patch is wrong. We 
could add nonatomic __cpu_set and __cpu_clear bitops, but I'm not sure 
if it's worth the effort, cpu bitops aren't that common 
(kernel/rcupdate.c and balance_node could use the __ versions).

Sorry for the noise (and don't check who wrote the x86 tlb flush code)
--
    Manfred

