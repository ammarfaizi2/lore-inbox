Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261415AbUKOEFn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261415AbUKOEFn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 23:05:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261434AbUKOEFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 23:05:24 -0500
Received: from fsmlabs.com ([168.103.115.128]:28037 "EHLO musoma.fsmlabs.com")
	by vger.kernel.org with ESMTP id S261415AbUKOCPC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 21:15:02 -0500
Date: Sun, 14 Nov 2004 19:14:40 -0700 (MST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
cc: Stas Sergeev <stsp@aknet.ru>, Andrew Morton <akpm@osdl.org>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.10-rc1-mm5
In-Reply-To: <Pine.LNX.4.58L.0411150143580.22313@blysk.ds.pg.gda.pl>
Message-ID: <Pine.LNX.4.61.0411141912010.3754@musoma.fsmlabs.com>
References: <41967669.3070707@aknet.ru> <Pine.LNX.4.61.0411131504360.4183@musoma.fsmlabs.com>
 <41968F16.1080706@aknet.ru> <Pine.LNX.4.61.0411141759250.3754@musoma.fsmlabs.com>
 <Pine.LNX.4.58L.0411150143580.22313@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Nov 2004, Maciej W. Rozycki wrote:

> On Sun, 14 Nov 2004, Zwane Mwaikambo wrote:
> 
> > @@ -453,12 +453,12 @@ asmlinkage void __init start_kernel(void
> >  	preempt_disable();
> >  	build_all_zonelists();
> >  	page_alloc_init();
> > -	trap_init();
> >  	printk("Kernel command line: %s\n", saved_command_line);
> >  	parse_early_param();
> >  	parse_args("Booting kernel", command_line, __start___param,
> >  		   __stop___param - __start___param,
> >  		   &unknown_bootoption);
> > +	trap_init();
> >  	sort_main_extable();
> >  	rcu_init();
> >  	init_IRQ();
> 
>  Are you sure you want to make exception handling not to be set up as soon
> as possible?  Please note this also includes stuff in cpu_init().

As long as we don't end up having to shuffle around more stuff so that 
parameters take effect. Anyway, i prefer your patch, this was a testing 
hack.

Thanks,
	Zwane

