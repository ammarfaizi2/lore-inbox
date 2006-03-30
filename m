Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750825AbWC3FD4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbWC3FD4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 00:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750854AbWC3FD4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 00:03:56 -0500
Received: from smtp.osdl.org ([65.172.181.4]:3028 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750825AbWC3FD4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 00:03:56 -0500
Date: Wed, 29 Mar 2006 21:03:40 -0800
From: Andrew Morton <akpm@osdl.org>
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Patch 2/8] Block I/O, swapin delays
Message-Id: <20060329210340.570d63e5.akpm@osdl.org>
In-Reply-To: <442B2836.2020708@watson.ibm.com>
References: <442B271D.10208@watson.ibm.com>
	<442B2836.2020708@watson.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shailabh Nagar <nagar@watson.ibm.com> wrote:
>
> delayacct-blkio-swapin.patch
> 
> Collect per-task block I/O delay statistics.
> 
> Unlike earlier iterations of the delay accounting
> patches, now delays are only collected for the actual
> I/O waits rather than try and cover the delays seen in
> I/O submission paths.
> 
> Account separately for block I/O delays
> incurred as a result of swapin page faults whose
> frequency can be affected by the task/process' rss limit.
> Hence swapin delays can act as feedback for rss limit changes
> independent of I/O priority changes.
> 
> ..
>
> +#define PF_SWAPIN	0x02000000	/* I am doing a swap in */
> 

Is there really no sane alternative to doing it this way?
