Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264386AbUFKXBp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264386AbUFKXBp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 19:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264388AbUFKXBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 19:01:45 -0400
Received: from fw.osdl.org ([65.172.181.6]:41676 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264386AbUFKXBo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 19:01:44 -0400
Date: Fri, 11 Jun 2004 16:04:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ducrot Bruno <ducrot@poupinou.org>
Cc: poup@poupinou.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix cpumask.h in mainline for UPu
Message-Id: <20040611160425.0acdfd89.akpm@osdl.org>
In-Reply-To: <20040611162307.GA18176@poupinou.org>
References: <20040611162307.GA18176@poupinou.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bruno Ducrot <poup@poupinou.org> wrote:
>
> I'm trying to replace for_each_cpu() with for_each_cpu_mask() in
> arch/i386/kernel/cpu/cpufreq/p4-clockmod.c
> 
> Unfortunately, though, davej pointed me that for_each_cpu_mask()
> is not defined in -bk if CONFIG_SMP is not defined.  Since this macro is
> the only one not defined if compiled for UP, and since -mm tree do have
> the correct behaviour already, is it possible to get this patch in mainline
> before this portion of -mm is merged?
> 
> +#define for_each_cpu_mask(cpu, mask) for (cpu = 0; cpu < 1; cpu++)

Yup, I'll merge that up prior to 2.6.7, thanks.
