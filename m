Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264097AbUEMMiS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264097AbUEMMiS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 08:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264174AbUEMMiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 08:38:18 -0400
Received: from niit.caravan.ru ([217.23.131.158]:36619 "EHLO mail.tv-sign.ru")
	by vger.kernel.org with ESMTP id S264097AbUEMMiO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 08:38:14 -0400
Message-ID: <40A36C94.EB004C37@tv-sign.ru>
Date: Thu, 13 May 2004 16:39:48 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.6-mm2
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Andrew Morton wrote:
>
> +yield_irq.patch
>
> From: Nick Piggin
>
> this_rq_lock does a local_irq_disable, and sched_yield()
> needs to undo that.

I beleive it is safe to enter schedule() with interrupts
disabled. schedule() does spin_lock_irq()->local_irq_disable()
anyway.

Could you please explain, why it is needed?

Oleg.
