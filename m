Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932296AbWFTFYg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932296AbWFTFYg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 01:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964990AbWFTFYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 01:24:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50122 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964939AbWFTFWH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 01:22:07 -0400
Date: Mon, 19 Jun 2006 22:22:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jim Cromie <jim.cromie@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch -mm 05/20] chardev: GPIO for SCx200 & PC-8736x: put
 gpio_dump on a diet
Message-Id: <20060619222204.362b30ca.akpm@osdl.org>
In-Reply-To: <44944976.80400@gmail.com>
References: <448DB57F.2050006@gmail.com>
	<cfe85dfa0606121150y369f6beeqc643a1fe5c7ce69b@mail.gmail.com>
	<44944976.80400@gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Jun 2006 12:27:02 -0600
Jim Cromie <jim.cromie@gmail.com> wrote:

> +        u32 config = scx200_gpio_configure(index, ~0, 0);
> +
> +        printk(KERN_INFO NAME ": GPIO-%02u: 0x%08lx %s %s %s %s %s %s %s\n",
> +               index, (unsigned long) config,
> +               (config & 1) ? "OE"      : "TS",		/* output enabled / tristate */
> +               (config & 2) ? "PP"      : "OD",		/* push pull / open drain */
> +               (config & 4) ? "PUE"     : "PUD",	/* pull up enabled/disabled */
> +               (config & 8) ? "LOCKED"  : "",		/* locked / unlocked */
> +               (config & 16) ? "LEVEL"  : "EDGE",	/* level/edge input */
> +               (config & 32) ? "HI"     : "LO",		/* trigger on rising/falling edge */ 
> +               (config & 64) ? "DEBOUNCE" : "");	/* debounce */
>  }

Please use hard tabs.

Casting `config' to ulong isn't needed here.
