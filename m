Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261604AbUC0GSp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 01:18:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261610AbUC0GSp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 01:18:45 -0500
Received: from pao-nav01.pao.digeo.com ([12.47.58.24]:39440 "HELO
	pao-nav01.pao.digeo.com") by vger.kernel.org with SMTP
	id S261604AbUC0GSo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 01:18:44 -0500
Date: Fri, 26 Mar 2004 22:17:31 -0800
From: Andrew Morton <akpm@digeo.com>
To: davidm@hpl.hp.com
Cc: linux-kernel@vger.kernel.org, Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: replace MAX_MAP_COUNT with /proc/sys/vm/max_map_count
Message-Id: <20040326221731.54772019.akpm@digeo.com>
In-Reply-To: <16485.5722.591616.846576@napali.hpl.hp.com>
References: <16485.5722.591616.846576@napali.hpl.hp.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Mar 2004 06:17:30.0850 (UTC) FILETIME=[2F6DEC20:01C413C3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mosberger <davidm@napali.hpl.hp.com> wrote:
>
> Below is a warmed up version of a patch originally done by Werner
> Almesberger (see http://tinyurl.com/25zra) to replace the
> MAX_MAP_COUNT limit with a sysctl variable.

Fair enough.

>  int sysctl_overcommit_memory = 0;	/* default is heuristic overcommit */
>  int sysctl_overcommit_ratio = 50;	/* default is 50% */
> +int sysctl_max_map_count = DEFAULT_MAX_MAP_COUNT;
>  atomic_t vm_committed_space = ATOMIC_INIT(0);
>  
>  EXPORT_SYMBOL(sysctl_overcommit_memory);
>  EXPORT_SYMBOL(sysctl_overcommit_ratio);
> +EXPORT_SYMBOL(sysctl_max_map_count);
>  EXPORT_SYMBOL(vm_committed_space);

The SELinux guys may want to hook into this.  I assume that's why these
symbols are exported to modules at present?

Stephen, if my surmise is correct could you please prep the final patch?
