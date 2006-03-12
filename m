Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751035AbWCLWL6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035AbWCLWL6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 17:11:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751056AbWCLWL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 17:11:58 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:59313 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750991AbWCLWL6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 17:11:58 -0500
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, garloff@suse.de,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] KERN_SETUID_DUMPABLE in /proc/sys/fs/
References: <20060310155738.GL5766@tpkurt.garloff.de>
	<20060310145605.08bf2a67.akpm@osdl.org>
	<1142061816.3055.6.camel@laptopd505.fenrus.org>
	<20060310234155.685456cd.akpm@osdl.org>
	<1142063254.3055.9.camel@laptopd505.fenrus.org>
	<20060310235103.4e9c9457.akpm@osdl.org>
	<1142064294.3055.13.camel@laptopd505.fenrus.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 12 Mar 2006 15:07:47 -0700
In-Reply-To: <1142064294.3055.13.camel@laptopd505.fenrus.org> (Arjan van de
 Ven's message of "Sat, 11 Mar 2006 09:04:54 +0100")
Message-ID: <m1r757xqoc.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> writes:

>
> diff -purN linux-2.6.16-rc5/include/linux/sysctl.h
> linux-2.6.16-rc5-setuid/include/linux/sysctl.h
> --- linux-2.6.16-rc5/include/linux/sysctl.h 2006-02-27 09:13:31.000000000 +0100
> +++ linux-2.6.16-rc5-setuid/include/linux/sysctl.h 2006-03-11 09:02:13.000000000
> +0100
> @@ -144,7 +144,6 @@ enum
>  	KERN_UNKNOWN_NMI_PANIC=66, /* int: unknown nmi panic flag */
>  	KERN_BOOTLOADER_TYPE=67, /* int: boot loader type */
>  	KERN_RANDOMIZE=68, /* int: randomize virtual address space */
> -	KERN_SETUID_DUMPABLE=69, /* int: behaviour of dumps for setuid core */
>  	KERN_SPIN_RETRY=70,	/* int: number of spinlock retries */
>  	KERN_ACPI_VIDEO_FLAGS=71, /* int: flags for setting up video after ACPI
> sleep */
>  };
> @@ -759,6 +758,9 @@ enum
>  	FS_AIO_NR=18,	/* current system-wide number of aio requests */
>  	FS_AIO_MAX_NR=19, /* system-wide maximum number of aio requests */
>  	FS_INOTIFY=20,	/* inotify submenu */
> + /* Note: the following got misplaced but this mistake is
> +			   now part of the ABI */
> +	FS_SETUID_DUMPABLE=21, /* int: behaviour of dumps for setuid core */
This must be number 69 here.  Or else we break the sys_sysctl ABI.
>  };
>  

Eric
