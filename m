Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267750AbTBUVcV>; Fri, 21 Feb 2003 16:32:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267753AbTBUVcU>; Fri, 21 Feb 2003 16:32:20 -0500
Received: from mailout10.sul.t-online.com ([194.25.134.21]:56984 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267750AbTBUVcT> convert rfc822-to-8bit; Fri, 21 Feb 2003 16:32:19 -0500
Content-Type: text/plain; charset=US-ASCII
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Ion Badulescu <ionut@badula.org>, Mikael Pettersson <mikpe@user.it.uu.se>
Subject: Re: UP local APIC is deadly on SMP Athlon
Date: Fri, 21 Feb 2003 22:41:23 +0100
User-Agent: KMail/1.4.3
Cc: Jeff Garzik <jgarzik@pobox.com>, <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0302211535510.17290-100000@guppy.limebrokerage.com>
In-Reply-To: <Pine.LNX.4.44.0302211535510.17290-100000@guppy.limebrokerage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200302212241.23251.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 21 February 2003 21:42, Ion Badulescu wrote:

Hi Ion,

> And this is what I found: eliminating two lines from
> APIC_init_uniprocessor() makes the problem go away.
> diff -urNX diff_kernel_excludes linux-2.4.10-pre12/arch/i386/kernel/apic.c
> linux-2.4.10-pre11++/arch/i386/kernel/apic.c ---
> linux-2.4.10-pre12/arch/i386/kernel/apic.c	Wed Feb 19 23:53:15 2003 +++
> linux-2.4.10-pre11++/arch/i386/kernel/apic.c	Fri Feb 21 15:37:06 2003 @@
> -1087,9 +1087,6 @@
>
>  	connect_bsp_APIC();
>
> -	phys_cpu_present_map = 1;
> -	apic_write_around(APIC_ID, boot_cpu_id);
> -
>  	apic_pm_init2();
>
>  	setup_local_APIC();
>
> [patch against 2.4.10-pre12, but 2.4.21-pre4 is reasonably similar]
Don't do this. I am pretty sure it will break all Intels. I still cannot 
understand why this fixes your AMD Athlon problem.

ciao, Marc
