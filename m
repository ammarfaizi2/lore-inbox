Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271125AbUJVAts@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271125AbUJVAts (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 20:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271139AbUJVAr1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 20:47:27 -0400
Received: from ozlabs.org ([203.10.76.45]:60304 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S271161AbUJVAiQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 20:38:16 -0400
Subject: Re: [PATCH] softirq block request completion
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jens Axboe <axboe@suse.de>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20041021082322.GW10531@suse.de>
References: <20041021082322.GW10531@suse.de>
Content-Type: text/plain
Message-Id: <1098405496.12103.44.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 22 Oct 2004 10:38:16 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-10-21 at 18:23, Jens Axboe wrote:
> +	for (i = 0; i < NR_CPUS; i++) {
> +		struct blk_completion_queue *bcq = &per_cpu(blk_cpu_done, i);

for_each_cpu(i) perhaps?

Not that it matters, but I'm trying to get people out of bad habits 8)

Thanks,
Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

