Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161223AbWKJPTn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161223AbWKJPTn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 10:19:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161829AbWKJPTn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 10:19:43 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:32471 "EHLO smtp3-g19.free.fr")
	by vger.kernel.org with ESMTP id S1161223AbWKJPTm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 10:19:42 -0500
Message-ID: <45549889.5000300@legoater.org>
Date: Fri, 10 Nov 2006 16:19:37 +0100
From: Cedric Le Goater <cedric@legoater.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: Kirill Korotaev <dev@sw.ru>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, xemul@openvz.org, devel@openvz.org,
       oleg@tv-sign.ru, hch@infradead.org, matthltc@us.ibm.com,
       ckrm-tech@lists.sourceforge.net
Subject: Re: [PATCH 1/13] BC: atomic_dec_and_lock_irqsave() helper
References: <45535C18.4040000@sw.ru> <45535CFA.5080601@sw.ru>
In-Reply-To: <45535CFA.5080601@sw.ru>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Kirill, Hello Pavel,

Kirill Korotaev wrote:
> Oleg Nesterov noticed to me that the construction like
> (used in beancounter patches and free_uid()):
> 
>   local_irq_save(flags);
>   if (atomic_dec_and_lock(&refcnt, &lock))
> 	  ...
> 
> is not that good for preemtible kernels, since with preemption
> spin_lock() can schedule() to reduce latency. However, it won't schedule
> if interrupts are disabled.
> 
> So this patch introduces atomic_dec_and_lock_irqsave() as a logical
> counterpart to atomic_dec_and_lock().

You should probably send that one independently from the BC 
patchset. 

C.
