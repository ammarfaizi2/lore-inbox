Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269088AbUIHKLn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269088AbUIHKLn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 06:11:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269089AbUIHKLn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 06:11:43 -0400
Received: from fw.osdl.org ([65.172.181.6]:32186 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269088AbUIHKLm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 06:11:42 -0400
Date: Wed, 8 Sep 2004 03:09:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [patch] max-sectors-2.6.9-rc1-bk14-A0
Message-Id: <20040908030944.4cd0e3a0.akpm@osdl.org>
In-Reply-To: <20040908100448.GA4994@elte.hu>
References: <20040908100448.GA4994@elte.hu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> the attached patch introduces two new /sys/block values:
> 
>    /sys/block/*/queue/max_hw_sectors_kb
>    /sys/block/*/queue/max_sectors_kb
> 
>  max_hw_sectors_kb is the maximum that the driver can handle and is
>  readonly. max_sectors_kb is the current max_sectors value and can be
>  tuned by root. PAGE_SIZE granularity is enforced.
> 
>  It's all locking-safe and all affected layered drivers have been updated
>  as well. The patch has been in testing for a couple of weeks already as
>  part of the voluntary-preempt patches and it works just fine - people
>  use it to reduce IDE IRQ handling latencies.

Could you remind us what the cause of the latency is, and its duration?

(Am vaguely surprised that it's an issue at, what, 32 pages?  Is something
sucky happening?)

