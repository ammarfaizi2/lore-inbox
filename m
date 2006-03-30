Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750938AbWC3FEz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750938AbWC3FEz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 00:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750995AbWC3FEy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 00:04:54 -0500
Received: from smtp.osdl.org ([65.172.181.4]:23252 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750949AbWC3FEh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 00:04:37 -0500
Date: Wed, 29 Mar 2006 21:04:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Patch 7/8] proc interface for block I/O delays
Message-Id: <20060329210421.549e319b.akpm@osdl.org>
In-Reply-To: <442B2CCC.2080604@watson.ibm.com>
References: <442B271D.10208@watson.ibm.com>
	<442B2CCC.2080604@watson.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shailabh Nagar <nagar@watson.ibm.com> wrote:
>
> delayacct-procfs.patch
> 
> Export I/O delays seen by a task through /proc/<tgid>/stats
> for use in top etc.
> 
> Note that delays for I/O done for swapping in pages (swapin I/O) is
> clubbed together with all other I/O here (this is not the
> case in the netlink interface where the swapin I/O is kept distinct)
> 
> ...
>
> +
> +unsigned long long __delayacct_blkio_ticks(struct task_struct *tsk)

Why unsigned long long here, rather than __u64?

> +{
> +	unsigned long long ret;
> +
> +	if (!tsk->delays)
> +		return 0;

delayacct_blkio_ticks() already checked that.


