Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751743AbWD0W7L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751743AbWD0W7L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 18:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751748AbWD0W7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 18:59:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33251 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751747AbWD0W7K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 18:59:10 -0400
Date: Thu, 27 Apr 2006 16:01:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net,
       Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: [PATCH] register hot-added memory to iomem resource
Message-Id: <20060427160130.6149550f.akpm@osdl.org>
In-Reply-To: <20060427204904.5037f6ea.kamezawa.hiroyu@jp.fujitsu.com>
References: <20060427204904.5037f6ea.kamezawa.hiroyu@jp.fujitsu.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:
>
> This patch registers hot-added memory to iomem_resource.
> By this, /proc/iomem can show hot-added memory.
> This patch is against 2.6.17-rc2-mm1.
> 
> Note: kdump uses /proc/iomem to catch memory range when it is installed.
>       So, kdump should be re-installed after /proc/iomem change.
> 

What do you mean by "kdump should be reinstalled"?  The kdump userspace
tools need to re-run kexec_load()?

If so, why?

And how is kdump to know that memory was hot-added?  Do we generate a
hotplug event?

Thanks.
