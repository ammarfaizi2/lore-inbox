Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262276AbVGFKJu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262276AbVGFKJu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 06:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262179AbVGFKGW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 06:06:22 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:50394 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262157AbVGFINh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 04:13:37 -0400
Date: Wed, 6 Jul 2005 10:12:34 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [1/48] Suspend2 2.1.9.8 for 2.6.12: submit_intro
Message-ID: <20050706081150.GC1412@elf.ucw.cz>
References: <11206164393426@foobar.com> <11206164393057@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11206164393057@foobar.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On St 06-07-05 12:20:39, Nigel Cunningham wrote:
> diff -ruNp 300-reboot-handler-hook.patch-old/kernel/sys.c 300-reboot-handler-hook.patch-new/kernel/sys.c
> --- 300-reboot-handler-hook.patch-old/kernel/sys.c	2005-06-20 11:47:32.000000000 +1000
> +++ 300-reboot-handler-hook.patch-new/kernel/sys.c	2005-07-04 23:14:18.000000000 +1000
> @@ -436,12 +436,12 @@ asmlinkage long sys_reboot(int magic1, i
>  		machine_restart(buffer);
>  		break;
>  
> -#ifdef CONFIG_SOFTWARE_SUSPEND
> +#ifdef CONFIG_SUSPEND2
>  	case LINUX_REBOOT_CMD_SW_SUSPEND:
>  		{
> -			int ret = software_suspend();
> +			suspend2_try_suspend();
>  			unlock_kernel();
> -			return ret;
> +			return 0;
>  		}
>  #endif

It would be nice to return meaningfull error code when something
fails...


								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
