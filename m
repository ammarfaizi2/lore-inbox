Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266173AbSKOLbW>; Fri, 15 Nov 2002 06:31:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266153AbSKOLaw>; Fri, 15 Nov 2002 06:30:52 -0500
Received: from [195.39.17.254] ([195.39.17.254]:7940 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S266157AbSKOL3o>;
	Fri, 15 Nov 2002 06:29:44 -0500
Date: Thu, 14 Nov 2002 23:59:23 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Shawn Starr <spstarr@sh0n.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Fix drivers/acpi/sleep.c compile error if swsusp is disabled
Message-ID: <20021114225922.GA1334@elf.ucw.cz>
References: <200211132304.03608.spstarr@sh0n.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211132304.03608.spstarr@sh0n.net>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Hi, this should fix this compile problem (if this is correct).
> 
> Please apply.

It would silently do nothing, that's bad.

Could you make it so that CONFIG_ACPI_SLEEP is not selectable without
CONFIG_SOFTWARE_SUSPEND  and move CONFIG_SOFTWARE_SUSPEND into "power
managment" submenu?
								Pavel
>                 break;
> 
>         case ACPI_STATE_S2:
> +#ifdef CONFIG_SOFTWARE_SUSPEND
>         case ACPI_STATE_S3:
>                 do_suspend_lowlevel(0);
> +#endif
>                 break;
>         }
>         local_irq_restore(flags);
> 
> 

-- 
When do you have heart between your knees?
