Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964786AbWGEJnP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964786AbWGEJnP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 05:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964780AbWGEJnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 05:43:14 -0400
Received: from canuck.infradead.org ([205.233.218.70]:54483 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S964786AbWGEJnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 05:43:13 -0400
Subject: Re: [CPUFREQ] Fix implicit declarations in ondemand.
From: David Woodhouse <dwmw2@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Dave Jones <davej@redhat.com>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060705023641.21507b34.akpm@osdl.org>
References: <20060705092254.GA30744@redhat.com>
	 <20060705023641.21507b34.akpm@osdl.org>
Content-Type: text/plain; charset=UTF-8
Date: Wed, 05 Jul 2006 10:43:05 +0100
Message-Id: <1152092585.32572.45.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.6.dwmw2.1) 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-07-05 at 02:36 -0700, Andrew Morton wrote:
> On Wed, 5 Jul 2006 05:22:54 -0400 Dave Jones <davej@redhat.com> wrote:
> 
> > drivers/cpufreq/cpufreq_ondemand.c: In function ‘dbs_check_cpu’:
> > drivers/cpufreq/cpufreq_ondemand.c:238: error: implicit declaration
> of function ‘jiffies64_to_cputime64’
> > drivers/cpufreq/cpufreq_ondemand.c:239: error: implicit declaration
> of function ‘cputime64_sub’

> > +#include <asm/cputime.h>

> But kernel_stat.h already includes cputime.h, as does sched.h, and
> pretty much everything pulls in sched.h.
> 
> It's not bad to avoid a dependency upon nested includes, but I do
> wonder how this error came about?? 

asm-powerpc/cputime.h doesn't declare jiffies64_to_cputime64() or
cputime64_sub()

-- 
dwmw2

