Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262447AbTEFHUA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 03:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262445AbTEFHUA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 03:20:00 -0400
Received: from [12.47.58.20] ([12.47.58.20]:37908 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S262447AbTEFHT7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 03:19:59 -0400
Date: Tue, 6 May 2003 00:34:12 -0700
From: Andrew Morton <akpm@digeo.com>
To: "David S. Miller" <davem@redhat.com>
Cc: rusty@rustcorp.com.au, dipankar@in.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kmalloc_percpu
Message-Id: <20030506003412.45e0949b.akpm@digeo.com>
In-Reply-To: <20030505.231553.68055974.davem@redhat.com>
References: <20030505235549.5df75866.akpm@digeo.com>
	<20030505.225748.35026531.davem@redhat.com>
	<20030506002229.631a642a.akpm@digeo.com>
	<20030505.231553.68055974.davem@redhat.com>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 May 2003 07:32:26.0234 (UTC) FILETIME=[A43895A0:01C313A1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> wrote:
>
> As just pointed out by dipankar the only issue is NUMA...
> so it has to be something more sophisticated than simply
> kmalloc()[smp_processor_id];

The proposed patch doesn't do anything about that either.

+	ptr = alloc_bootmem(PERCPU_POOL_SIZE * NR_CPUS);

So yes, we need an api which could be extended to use node-affine memory at
some time in the future.  I think we have that.

