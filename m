Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266163AbUAQUQn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 15:16:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266165AbUAQUQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 15:16:43 -0500
Received: from ookhoi.xs4all.nl ([213.84.114.66]:64651 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S266163AbUAQUQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 15:16:40 -0500
Date: Sat, 17 Jan 2004 21:16:39 +0100
From: Sander <sander@humilis.net>
To: Andi Kleen <ak@muc.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, jh@suse.cz
Subject: several oopses during boot (was: Re: [PATCH] Add CONFIG for -mregparm=3)
Message-ID: <20040117201639.GA16420@favonius>
Reply-To: sander@humilis.net
References: <20040114090603.GA1935@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040114090603.GA1935@averell>
X-Uptime: 13:35:14 up 28 days,  3:23, 37 users,  load average: 2.44, 2.99, 3.13
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi and Andrew,

Andi Kleen wrote (ao):
> Using -mregparm=3 shrinks the kernel further:

...

> This patch adds an option to use -mregparm=3 while compiling the kernel.
> I did an LTP run and it showed no additional failures over an non 
> regparm kernel.
> 
> According to some gcc developers it should be safe to use in all
> gccs that are still supports (2.95 and up) 
> 
> I didn't make it the default because it will break all binary only
> modules (although they can be fixed by adding a wrapper that 
> calls them with "asmlinkage"). Actually it may be a good idea to 
> make this default with 2.7.1 or somesuch.

...
  
> +config REGPARM
> +	bool "Use register arguments (EXPERIMENTAL)"
> +	default n
> +	help
> +	Compile the kernel with -mregparm=3. This uses an different ABI
> +	and passes the first three arguments of a function call in registers.
> +	This will probably break binary only modules.	

This gives several oopses on my system during boot, after which is seems
dead.

2.6.1-mm4
VIA C3 Ezra

It mounts its root filesystem over nfs and has netconsole compiled in.

Without the REGPARM option the system boots and runs fine.

Should I post the oopses, the result of ksymoops, a dmesg and kernel
config or is this an already known issue?

Kind regards, Sander

-- 
Humilis IT Services and Solutions
http://www.humilis.net
