Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265784AbUHSMN4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265784AbUHSMN4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 08:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265812AbUHSMN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 08:13:56 -0400
Received: from the-village.bc.nu ([81.2.110.252]:39042 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S265784AbUHSMNy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 08:13:54 -0400
Subject: Re: Use global system_state to avoid system-state confusion
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>,
       Andrew Morton <akpm@zip.com.au>, benh@kernel.crashing.org,
       David Brownell <david-b@pacbell.net>
In-Reply-To: <20040819113600.GA1317@elf.ucw.cz>
References: <20040819113600.GA1317@elf.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092913877.27919.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 19 Aug 2004 12:11:18 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-08-19 at 12:36, Pavel Machek wrote:
> Hi!
> 
> I started using system_state (already defined in kernel.h) to allow
> drivers to do something different in response to swsusp. This at least
> kills ide-disk.c hack.
> 
> Please apply,
>  
> -	printk("Shutdown: %s\n", drive->name);
>  	dev->bus->suspend(dev, PM_SUSPEND_STANDBY);
>  }

Please leave the printk - its very handy for debugging IDE exit paths,
and those are not entirely bug free yet.
