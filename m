Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965062AbWIKVXf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965062AbWIKVXf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 17:23:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965067AbWIKVXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 17:23:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:9942 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965062AbWIKVXf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 17:23:35 -0400
From: Andi Kleen <ak@suse.de>
To: Dave Jones <davej@redhat.com>
Subject: Re: Split multi-line printk in oops output.
Date: Mon, 11 Sep 2006 22:24:38 +0200
User-Agent: KMail/1.9.1
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060911030721.GA4733@redhat.com> <200609110744.15450.ak@suse.de> <20060911060755.GA8271@redhat.com>
In-Reply-To: <20060911060755.GA8271@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609112224.38726.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 11 September 2006 08:07, Dave Jones wrote:
> On Mon, Sep 11, 2006 at 07:44:15AM +0200, Andi Kleen wrote:
>  > >  	print_modules();
>  > > -	printk(KERN_EMERG "CPU:    %d\nEIP:    %04x:[<%08lx>]    %s VLI\n"
>  > > -			"EFLAGS: %08lx   (%s %.*s) \n",
>  > > -		smp_processor_id(), 0xffff & regs->xcs, regs->eip,
>  > > -		print_tainted(), regs->eflags, system_utsname.release,
>  > > +	printk(KERN_EMERG "CPU:    %d\n", smp_processor_id());
>  > > +	printk(KERN_EMERG "EIP:    %04x:[<%08lx>]    %s VLI\n",
>  > > +		0xffff & regs->xcs, regs->eip, print_tainted());
>  > > +	printk(KERN_EMERG "EFLAGS: %08lx   (%s %.*s)\n",
>  >
>  > Still only using a single printk would be slightly safer
>
> Signed-off-by: Dave Jones <davej@redhat.com>

Added thanks., Please include the full description on reposted patches
in the future too.

-Andi

