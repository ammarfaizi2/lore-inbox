Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751539AbWHKFL7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751539AbWHKFL7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 01:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751548AbWHKFL7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 01:11:59 -0400
Received: from ozlabs.tip.net.au ([203.10.76.45]:22196 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751524AbWHKFL6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 01:11:58 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17628.4499.609213.401518@cargo.ozlabs.ibm.com>
Date: Fri, 11 Aug 2006 15:11:47 +1000
From: Paul Mackerras <paulus@samba.org>
To: Tsutomu OWA <tsutomu.owa@toshiba.co.jp>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, mingo@elte.hu,
       tglx@linutronix.de
Subject: Re: [RFC PATCH 1/4] powerpc 2.6.16-rt17: to build on powerpc w/ RT
In-Reply-To: <yyiodushvxs.wl@forest.swc.toshiba.co.jp>
References: <yyiodushvxs.wl@forest.swc.toshiba.co.jp>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tsutomu OWA writes:

> diff -rup -x CVS 2.6.16-rt17/arch/powerpc/kernel/time.c rt-powerpc/arch/powerpc/kernel/time.c
> --- 2.6.16-rt17/arch/powerpc/kernel/time.c	2006-04-26 18:24:28.000000000 +0900
> +++ rt-powerpc/arch/powerpc/kernel/time.c	2006-07-12 13:45:31.000000000 +0900
> @@ -200,6 +200,7 @@ void udelay(unsigned long usecs)
>  }
>  EXPORT_SYMBOL(udelay);
>  
> +#ifndef CONFIG_GENERIC_TIME

I would be very surprised if this is all that is required for
CONFIG_GENERIC_TIME to work correctly on powerpc.  Have you verified
that the CONFIG_GENERIC_TIME stuff works correctly on powerpc and
provides all the features provided by the current implementation?

Paul.
