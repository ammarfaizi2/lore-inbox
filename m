Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750758AbWIYJZ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbWIYJZ3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 05:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750784AbWIYJZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 05:25:29 -0400
Received: from symlink.to.noone.org ([85.10.207.172]:5051 "EHLO sym.noone.org")
	by vger.kernel.org with ESMTP id S1750758AbWIYJZ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 05:25:29 -0400
Date: Mon, 25 Sep 2006 11:25:28 +0200
From: Tobias Klauser <tklauser@distanz.ch>
To: Amol Lad <amol@verismonetworks.com>
Cc: kernel Janitors <kernel-janitors@lists.osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [KJ] [PATCH] misc_register error return handling
Message-ID: <20060925092528.GL10725@distanz.ch>
References: <1159174740.25016.36.camel@amol.verismonetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1159174740.25016.36.camel@amol.verismonetworks.com>
X-Editor: Vi IMproved 6.3
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006-09-25 at 10:59:00 +0200, Amol Lad <amol@verismonetworks.com> wrote:
> Ignore previous patch (mail client linewrap issue...)
> 
> Some drivers do not handle failure of misc_register. 
> 
> Added return value checks appropriately in defaulting drivers
> 
> Tested with:
> - allmodconfig
> - Manually tweaking Kconfig/Makefiles to make sure that the changed
> files compiles without any errors/warnings
> 
> Signed-off-by: Amol Lad <amol@verismonetworks.com>
> ---
>  arch/i386/kernel/apm.c             |   23 +++++++++++++++++------
>  arch/um/drivers/mmapper_kern.c     |    6 ++++--
>  arch/x86_64/kernel/mce.c           |    6 +++++-
>  drivers/char/watchdog/ep93xx_wdt.c |    4 ++++
>  drivers/input/misc/hp_sdc_rtc.c    |    7 ++++++-
>  drivers/macintosh/apm_emu.c        |    8 +++++++-
>  drivers/macintosh/smu.c            |   11 ++++++++---
>  drivers/macintosh/via-pmu.c        |   11 ++++++++---

Split up by driver/subsystem, please.
