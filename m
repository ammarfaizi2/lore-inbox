Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964889AbWIKFy1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964889AbWIKFy1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 01:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964890AbWIKFy0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 01:54:26 -0400
Received: from ns2.suse.de ([195.135.220.15]:14546 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964889AbWIKFyZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 01:54:25 -0400
From: Andi Kleen <ak@suse.de>
To: Dave Jones <davej@redhat.com>
Subject: Re: Split multi-line printk in oops output.
Date: Mon, 11 Sep 2006 07:44:15 +0200
User-Agent: KMail/1.9.1
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060911030721.GA4733@redhat.com>
In-Reply-To: <20060911030721.GA4733@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609110744.15450.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>  	print_modules();
> -	printk(KERN_EMERG "CPU:    %d\nEIP:    %04x:[<%08lx>]    %s VLI\n"
> -			"EFLAGS: %08lx   (%s %.*s) \n",
> -		smp_processor_id(), 0xffff & regs->xcs, regs->eip,
> -		print_tainted(), regs->eflags, system_utsname.release,
> +	printk(KERN_EMERG "CPU:    %d\n", smp_processor_id());
> +	printk(KERN_EMERG "EIP:    %04x:[<%08lx>]    %s VLI\n",
> +		0xffff & regs->xcs, regs->eip, print_tainted());
> +	printk(KERN_EMERG "EFLAGS: %08lx   (%s %.*s)\n",

Still only using a single printk would be slightly safer

-Andi
