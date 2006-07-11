Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750833AbWGKUaZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750833AbWGKUaZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 16:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbWGKUaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 16:30:25 -0400
Received: from fmr17.intel.com ([134.134.136.16]:8642 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750833AbWGKUaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 16:30:24 -0400
Subject: Re: [PATCH] irqtrace-option-off-compile-fix
From: Tim Chen <tim.c.chen@linux.intel.com>
Reply-To: tim.c.chen@linux.intel.com
To: Ingo Molnar <mingo@elte.hu>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
In-Reply-To: <20060711194505.GA25611@elte.hu>
References: <1152577120.7654.9.camel@localhost.localdomain>
	 <1152601989.3128.10.camel@laptopd505.fenrus.org>
	 <1152635003.7654.40.camel@localhost.localdomain>
	 <1152637993.3128.96.camel@laptopd505.fenrus.org>
	 <1152635804.7654.44.camel@localhost.localdomain>
	 <1152641141.3128.104.camel@laptopd505.fenrus.org>
	 <1152644540.3578.1.camel@localhost.localdomain>
	 <20060711194505.GA25611@elte.hu>
Content-Type: text/plain
Organization: Intel
Date: Tue, 11 Jul 2006 12:48:58 -0700
Message-Id: <1152647338.3578.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-8) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-11 at 21:45 +0200, Ingo Molnar wrote:
> * Tim Chen <tim.c.chen@linux.intel.com> wrote:
> 
> > > The one you want is CONFIG_TRACE_IRQFLAGS .. which is the one that 
> > > actually turns the tracing on
> > 
> > I could not turn off CONFIG_TRACE_IRQFLAGS_SUPPORT in .config 
> > directly. The command "scripts/kconfig/conf -s arch/x86_64/Kconfig" in 
> > Makefile overwrites changes made to CONFIG_TRACE_IRQFLAGS_SUPPORT in 
> > .config file.  So this is always turned on in .config if the option 
> > TRACE_IRQFLAGS_SUPPORT is set in arch/x86_64/Kconfig.debug.  I may be 
> > missing something.  Any suggestions?
> 
> correct, that flag is always set - it signals towards the core kernel 
> that the architecture in question (x86_64) that it has trace-irqflags 
> support. NOTE: this does not mean that irqflags tracing is turned on - 
> that is another option: CONFIG_TRACE_IRQFLAGS.
> 
> unsetting the support flag makes no sense and will likely break the 
> build. There is no overhead from irqflags tracing if it's turned off. 
> (even if the CONFIG_TRACE_IRQFLAGS_SUPPORT option is set)
> 
> does this explain things? We could rename the boolean value to 
> CONFIG_TRACE_IRQFLAGS_SUPPORT_AVAILABLE perhaps, to avoid future 
> confusion.
> 
> 	Ingo

Thanks for clarifying.

