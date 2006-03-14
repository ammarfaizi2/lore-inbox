Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932431AbWCNKys@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932431AbWCNKys (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 05:54:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932445AbWCNKys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 05:54:48 -0500
Received: from jaguar.mkp.net ([192.139.46.146]:64156 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S932431AbWCNKyr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 05:54:47 -0500
To: nagar@watson.ibm.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: Patch 2/9] Initialization
References: <1142296834.5858.3.camel@elinux04.optonline.net>
	<1142297101.5858.10.camel@elinux04.optonline.net>
From: Jes Sorensen <jes@sgi.com>
Date: 14 Mar 2006 05:54:46 -0500
In-Reply-To: <1142297101.5858.10.camel@elinux04.optonline.net>
Message-ID: <yq0slpluwi1.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Shailabh" == Shailabh Nagar <nagar@watson.ibm.com> writes:

Shailabh> delayacct-setup.patch Initialization code related to
Shailabh> collection of per-task "delay" statistics which measure how
Shailabh> long it had to wait for cpu, sync block io, swapping
Shailabh> etc. The collection of statistics and the interface are in
Shailabh> other patches. This patch sets up the data structures and
Shailabh> allows the statistics collection to be disabled through a
Shailabh> kernel boot paramater.

Shailabh> +#ifdef CONFIG_TASK_DELAY_ACCT
Shailabh> +struct task_delay_info {
Shailabh> +	spinlock_t	lock;
Shailabh> +
Shailabh> +	/* For each stat XXX, add following, aligned appropriately
Shailabh> +	 *
Shailabh> +	 * struct timespec XXX_start, XXX_end;
Shailabh> +	 * u64 XXX_delay;
Shailabh> +	 * u32 XXX_count;
Shailabh> +	 */
Shailabh> +};
Shailabh> +#endif

Hmmm

I thought you were going to change this to do

u64 some_delay
u32 foo_count
u32 bar_count
u64 another_delay

To avoid wasting space on 64 bit platforms.

Jes
