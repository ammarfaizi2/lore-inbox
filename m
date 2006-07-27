Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751446AbWG0OcH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446AbWG0OcH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 10:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751513AbWG0OcG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 10:32:06 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:30372 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751455AbWG0OcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 10:32:05 -0400
Subject: Re: lockdep: results on ARM
From: Arjan van de Ven <arjan@infradead.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20060727142425.GA5178@flint.arm.linux.org.uk>
References: <20060727142425.GA5178@flint.arm.linux.org.uk>
Content-Type: text/plain
Organization: Intel International BV
Date: Thu, 27 Jul 2006 16:32:03 +0200
Message-Id: <1154010723.3039.59.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-27 at 15:24 +0100, Russell King wrote:
> +#ifdef __ARCH_WANT_INTERRUPTS_ON_CTXSW
> +	p->hardirqs_enabled = 1;
> +#else
>  	p->hardirqs_enabled = 0;
> +#endif

if __ARCH_WANT_INTERRUPTS_ON_CTXSW is set to 1 for arm you can turn this
into

p->hardirqs_enabled = __ARCH_WANT_INTERRUPTS_ON_CTXSW + 0;

and save the ifdef ;)


