Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261394AbUKOBtR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261394AbUKOBtR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 20:49:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261398AbUKOBtR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 20:49:17 -0500
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:45582 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S261394AbUKOBtN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 20:49:13 -0500
Date: Mon, 15 Nov 2004 01:49:07 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Stas Sergeev <stsp@aknet.ru>, Andrew Morton <akpm@osdl.org>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.10-rc1-mm5
In-Reply-To: <Pine.LNX.4.61.0411141759250.3754@musoma.fsmlabs.com>
Message-ID: <Pine.LNX.4.58L.0411150143580.22313@blysk.ds.pg.gda.pl>
References: <41967669.3070707@aknet.ru> <Pine.LNX.4.61.0411131504360.4183@musoma.fsmlabs.com>
 <41968F16.1080706@aknet.ru> <Pine.LNX.4.61.0411141759250.3754@musoma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Nov 2004, Zwane Mwaikambo wrote:

> @@ -453,12 +453,12 @@ asmlinkage void __init start_kernel(void
>  	preempt_disable();
>  	build_all_zonelists();
>  	page_alloc_init();
> -	trap_init();
>  	printk("Kernel command line: %s\n", saved_command_line);
>  	parse_early_param();
>  	parse_args("Booting kernel", command_line, __start___param,
>  		   __stop___param - __start___param,
>  		   &unknown_bootoption);
> +	trap_init();
>  	sort_main_extable();
>  	rcu_init();
>  	init_IRQ();

 Are you sure you want to make exception handling not to be set up as soon
as possible?  Please note this also includes stuff in cpu_init().

  Maciej
