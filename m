Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263526AbTL2POJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 10:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263527AbTL2POJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 10:14:09 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:50831 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S263526AbTL2POI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 10:14:08 -0500
Message-ID: <3FF044A2.3050503@colorfullife.com>
Date: Mon, 29 Dec 2003 16:13:38 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Srivatsa Vaddagiri <vatsa@in.ibm.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: in_atomic doesn't count local_irq_disable?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srivatsa Vaddagiri wrote:

>This is basically because down_read was called with interrupts disabled ..
>__might_sleep was "unable" to dump the stack of callers which 
>lead to this problem ..

What do you mean with unable? Could you post what was printed?

I guess it's a get_user within either spin_lock_irq() or local_irq_disable. Without more info about the context, it's difficult to figure out if the page fault handler or the caller should be updated
--
	Manfred



