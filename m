Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964780AbWGEJ6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964780AbWGEJ6E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 05:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964781AbWGEJ6D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 05:58:03 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21409 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964780AbWGEJ6C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 05:58:02 -0400
Date: Wed, 5 Jul 2006 02:57:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dave Jones <davej@redhat.com>
Cc: dwmw2@infradead.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [CPUFREQ] Fix implicit declarations in ondemand.
Message-Id: <20060705025744.ea6ee5ed.akpm@osdl.org>
In-Reply-To: <20060705094657.GB1877@redhat.com>
References: <20060705092254.GA30744@redhat.com>
	<20060705023641.21507b34.akpm@osdl.org>
	<1152092585.32572.45.camel@pmac.infradead.org>
	<20060705094657.GB1877@redhat.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jul 2006 05:46:57 -0400
Dave Jones <davej@redhat.com> wrote:

> On Wed, Jul 05, 2006 at 10:43:05AM +0100, David Woodhouse wrote:
>  > On Wed, 2006-07-05 at 02:36 -0700, Andrew Morton wrote:
>  > > On Wed, 5 Jul 2006 05:22:54 -0400 Dave Jones <davej@redhat.com> wrote:
>  > > 
>  > > > drivers/cpufreq/cpufreq_ondemand.c: In function ‘dbs_check_cpu’:
>  > > > drivers/cpufreq/cpufreq_ondemand.c:238: error: implicit declaration
>  > > of function ‘jiffies64_to_cputime64’
>  > > > drivers/cpufreq/cpufreq_ondemand.c:239: error: implicit declaration
>  > > of function ‘cputime64_sub’
>  > 
>  > > > +#include <asm/cputime.h>
>  > 
>  > > But kernel_stat.h already includes cputime.h, as does sched.h, and
>  > > pretty much everything pulls in sched.h.
>  > > 
>  > > It's not bad to avoid a dependency upon nested includes, but I do
>  > > wonder how this error came about?? 
>  > 
>  > asm-powerpc/cputime.h doesn't declare jiffies64_to_cputime64() or
>  > cputime64_sub()
> 
> The curious part is why it isn't picking up the definition from asm-generic
> like x86-64 & friends do.
> 

CONFIG_VIRT_CPU_ACCOUNTING.
