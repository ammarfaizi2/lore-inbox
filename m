Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265222AbUHAGKe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265222AbUHAGKe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 02:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265224AbUHAGKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 02:10:34 -0400
Received: from fw.osdl.org ([65.172.181.6]:62353 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265222AbUHAGKd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 02:10:33 -0400
Date: Sat, 31 Jul 2004 23:08:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: Anton Blanchard <anton@samba.org>
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] use for_each_cpu
Message-Id: <20040731230859.138ba584.akpm@osdl.org>
In-Reply-To: <20040801060144.GI30253@krispykreme>
References: <20040801060144.GI30253@krispykreme>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Blanchard <anton@samba.org> wrote:
>
> The per cpu schedule counters need to be summed up over all possible cpus.
>  When testing hotplug cpu remove I saw the sum of the online cpu count
>  for nr_uninterruptible go negative which made the load average go nuts.

I think the preferred approach here is to transfer the count over to the
current CPU in the CPU_DEAD handler.
