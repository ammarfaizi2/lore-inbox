Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964784AbWGEJrI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964784AbWGEJrI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 05:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964780AbWGEJrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 05:47:08 -0400
Received: from mx1.redhat.com ([66.187.233.31]:40074 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964784AbWGEJrH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 05:47:07 -0400
Date: Wed, 5 Jul 2006 05:46:57 -0400
From: Dave Jones <davej@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [CPUFREQ] Fix implicit declarations in ondemand.
Message-ID: <20060705094657.GB1877@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <20060705092254.GA30744@redhat.com> <20060705023641.21507b34.akpm@osdl.org> <1152092585.32572.45.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1152092585.32572.45.camel@pmac.infradead.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2006 at 10:43:05AM +0100, David Woodhouse wrote:
 > On Wed, 2006-07-05 at 02:36 -0700, Andrew Morton wrote:
 > > On Wed, 5 Jul 2006 05:22:54 -0400 Dave Jones <davej@redhat.com> wrote:
 > > 
 > > > drivers/cpufreq/cpufreq_ondemand.c: In function ‘dbs_check_cpu’:
 > > > drivers/cpufreq/cpufreq_ondemand.c:238: error: implicit declaration
 > > of function ‘jiffies64_to_cputime64’
 > > > drivers/cpufreq/cpufreq_ondemand.c:239: error: implicit declaration
 > > of function ‘cputime64_sub’
 > 
 > > > +#include <asm/cputime.h>
 > 
 > > But kernel_stat.h already includes cputime.h, as does sched.h, and
 > > pretty much everything pulls in sched.h.
 > > 
 > > It's not bad to avoid a dependency upon nested includes, but I do
 > > wonder how this error came about?? 
 > 
 > asm-powerpc/cputime.h doesn't declare jiffies64_to_cputime64() or
 > cputime64_sub()

The curious part is why it isn't picking up the definition from asm-generic
like x86-64 & friends do.

		Dave

-- 
http://www.codemonkey.org.uk
