Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266726AbSKLRzR>; Tue, 12 Nov 2002 12:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266731AbSKLRzR>; Tue, 12 Nov 2002 12:55:17 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:6126 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S266726AbSKLRzQ>; Tue, 12 Nov 2002 12:55:16 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200211121801.gACI1ro25294@devserv.devel.redhat.com>
Subject: Re: Kill obsolete and  unused suspend/resume code from IDE
To: pavel@ucw.cz (Pavel Machek)
Date: Tue, 12 Nov 2002 13:01:53 -0500 (EST)
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org (kernel list),
       alan@redhat.com
In-Reply-To: <20021112175154.GA6881@elf.ucw.cz> from "Pavel Machek" at Nov 12, 2002 06:51:54 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This code in ide is obsolete and unused. I have followup patch to
> integrate IDE into sysfs. Please apply,

The code is not obsolete, it is not unused

> +	do_idedisk_standby(drive);
>  	if ((drive->id->cfs_enable_2 & 0x3000) && drive->wcache)
>  		if (do_idedisk_flushcache(drive))
>  			printk (KERN_INFO "%s: Write Cache FAILED Flushing!\n",

What locking rules are you using here ?

Linus please reject this patch. Its just getting in the way of actually
fixing the IDE code properly.
