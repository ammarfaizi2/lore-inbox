Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751103AbWGKSFo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbWGKSFo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 14:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbWGKSFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 14:05:44 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:42682 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751165AbWGKSFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 14:05:44 -0400
Subject: Re: [PATCH] irqtrace-option-off-compile-fix
From: Arjan van de Ven <arjan@infradead.org>
To: tim.c.chen@linux.intel.com
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, akpm@osdl.org
In-Reply-To: <1152635804.7654.44.camel@localhost.localdomain>
References: <1152577120.7654.9.camel@localhost.localdomain>
	 <1152601989.3128.10.camel@laptopd505.fenrus.org>
	 <1152635003.7654.40.camel@localhost.localdomain>
	 <1152637993.3128.96.camel@laptopd505.fenrus.org>
	 <1152635804.7654.44.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 11 Jul 2006 20:05:41 +0200
Message-Id: <1152641141.3128.104.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-11 at 09:36 -0700, Tim Chen wrote:
> On Tue, 2006-07-11 at 19:13 +0200, Arjan van de Ven wrote:
> > On Tue, 2006-07-11 at 09:23 -0700, Tim Chen wrote:
> > > I was testing on x86_64 and turned off the option in
> > > arch/x86_64/Kconfig.debug. 
> > > 
> > > When the option is turned off, the following functions become undefined:
> > > local_irq_disable()           
> > > local_irq_enable()             
> > > local_irq_save(flags)          
> > > local_irq_restore(flags)       
> > > safe_halt() 
> > > local_save_flags()
> > > irqs_disabled()
> > > irqs_disabled_flags(flags)                   
> > > 
> > > It seems plausible that some users may want to avoid the overhead of
> > > tracing IRQFLAGS by turning the option off.
> > 
> > eh that is a different config option!
> 
> My typo, it is TRACE_IRQFLAGS_SUPPORT in arch/x86_64/Kconfig.debug.


that should never ever be user setable. That just says if you have
support for the api.

The one you want is CONFIG_TRACE_IRQFLAGS .. which is the one that
actually turns the tracing on



