Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261997AbVGJR6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261997AbVGJR6E (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 13:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261998AbVGJR6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 13:58:04 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:22236 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261997AbVGJR6C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 13:58:02 -0400
Date: Sun, 10 Jul 2005 19:58:10 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [28/48] Suspend2 2.1.9.8 for 2.6.12: 605-kernel_power_suspend.patch
Message-ID: <20050710175810.GA10904@elf.ucw.cz>
References: <11206164393426@foobar.com> <1120616442343@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1120616442343@foobar.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> diff -ruNp 606-all-settings.patch-old/kernel/power/suspend2_core/all_settings.c 606-all-settings.patch-new/kernel/power/suspend2_core/all_settings.c
> --- 606-all-settings.patch-old/kernel/power/suspend2_core/all_settings.c	1970-01-01 10:00:00.000000000 +1000
> +++ 606-all-settings.patch-new/kernel/power/suspend2_core/all_settings.c	2005-07-04 23:14:19.000000000 +1000
> @@ -0,0 +1,325 @@
> +/*
> + * /kernel/power/suspend2_core/all_settings.c
> + *
> + * Suspend2 is released under the GPLv2.
> + * 
> + * Copyright (C) 2002-2005 Nigel Cunningham <nigel@suspend2.net>
> + *
> + * This file provides the all_settings proc entry, used to save
> + * and restore all suspend2 settings en masse.
> + */
> +
> +#include <linux/mm.h>
> +#include <linux/suspend.h>
> +#include <asm/uaccess.h>
> +
> +#include "plugins.h"
> +#include "proc.h"
> +#include "suspend2_common.h"
> +#include "prepare_image.h"
> +#include "power_off.h"
> +#include "io.h"
> +
> +#define ALL_SETTINGS_VERSION 4
> +
> +static int resume2_len;
> +
> +/*
> + * suspend_write2_compat_proc.
> + *
> + * This entry allows all of the settings to be set at once. 
> + * It was originally for compatibility with pre- /proc/suspend
> + * versions, but has been retained because it makes saving and
> + * restoring the configuration simpler.
> + */

Okay, and it is also extremely ugly. Now you have chance to clean it
up, please drop it.
								Pavel

-- 
teflon -- maybe it is a trademark, but it should not be.
