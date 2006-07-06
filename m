Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965127AbWGFDmr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965127AbWGFDmr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 23:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965155AbWGFDmr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 23:42:47 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:8611
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S965127AbWGFDmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 23:42:46 -0400
Date: Wed, 05 Jul 2006 20:43:11 -0700 (PDT)
Message-Id: <20060705.204311.78725710.davem@davemloft.net>
To: mikpe@it.uu.se
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH 2.6.17 sparc64] fix stack overflow checking in modular
 non-SMP kernels
From: David Miller <davem@davemloft.net>
In-Reply-To: <200607042010.k64KABmC011107@harpo.it.uu.se>
References: <200607042010.k64KABmC011107@harpo.it.uu.se>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikael Pettersson <mikpe@it.uu.se>
Date: Tue, 4 Jul 2006 22:10:11 +0200 (MEST)

> The sparc64 kernel's EXPORT_SYMBOL(_mcount) is inside an
> #ifdef CONFIG_SMP. This breaks modules in non-SMP kernels
> built with stack overflow checking (CONFIG_STACK_DEBUG=y),
> as modules_install reports:
> 
> WARNING: /lib/modules/2.6.17/kernel/drivers/ide/ide-cd.ko needs unknown symbol _mcount
> 
> Trivially fixed by moving EXPORT_SYMBOL(_mcount) outside of
> the #ifdef CONFIG_SMP.
> 
> Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>

Applied, thanks Mikael.
