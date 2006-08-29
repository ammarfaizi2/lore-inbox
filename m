Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932146AbWH2HNr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbWH2HNr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 03:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbWH2HNr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 03:13:47 -0400
Received: from brick.kernel.dk ([62.242.22.158]:7234 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S932146AbWH2HNr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 03:13:47 -0400
Date: Tue, 29 Aug 2006 09:16:30 +0200
From: Jens Axboe <axboe@kernel.dk>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] sys_ioprio_set: don't disable irqs
Message-ID: <20060829071630.GR30609@kernel.dk>
References: <20060826205949.GA1140@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060826205949.GA1140@oleg>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 27 2006, Oleg Nesterov wrote:
> It is not good to disable interrupts while traversing all tasks in the system.
> As I see it, sys_ioprio_get() doesn't need to do it at all, sys_ioprio_set()
> does it for cfq_ioc_set_ioprio(), the latter can disable irqs itself.
> 
> Also, add a comment to explain why do we need tasklist_lock.
> 
> Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

You should work against the 'block' branch in the block git repo, things
tend to change... I've applied your ioprio.c bit, the other one is not
needed anymore.

-- 
Jens Axboe

