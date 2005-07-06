Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262214AbVGFIRS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262214AbVGFIRS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 04:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261824AbVGFIOu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 04:14:50 -0400
Received: from nproxy.gmail.com ([64.233.182.193]:28642 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262163AbVGFGhR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 02:37:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mNjm5NrwhfuWx8cHhLAR7c4vEkKx9Q0JasIyqgtJVTdfVbRatnVvg5n5U88roKspMEpJ4EYTwOfu6JmwHaLRNfzAb3u+VCDTyTjE17cxFfHtRokcvxRrMCyM79VNJiYWihNzym/ncvnHWcepHkspszt08LpTX3EACmNF86a+yhA=
Message-ID: <84144f02050705233723e70b9b@mail.gmail.com>
Date: Wed, 6 Jul 2005 09:37:16 +0300
From: Pekka Enberg <penberg@gmail.com>
Reply-To: Pekka Enberg <penberg@gmail.com>
To: Nigel Cunningham <nigel@suspend2.net>
Subject: Re: [PATCH] [1/48] Suspend2 2.1.9.8 for 2.6.12: submit_intro
Cc: linux-kernel@vger.kernel.org, Pekka Enberg <penberg@cs.helsinki.fi>
In-Reply-To: <11206164393057@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <11206164393426@foobar.com> <11206164393057@foobar.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/05, Nigel Cunningham <nigel@suspend2.net> wrote:
> diff -ruNp 300-reboot-handler-hook.patch-old/kernel/sys.c 300-reboot-handler-hook.patch-new/kernel/sys.c
> --- 300-reboot-handler-hook.patch-old/kernel/sys.c      2005-06-20 11:47:32.000000000 +1000
> +++ 300-reboot-handler-hook.patch-new/kernel/sys.c      2005-07-04 23:14:18.000000000 +1000
> @@ -436,12 +436,12 @@ asmlinkage long sys_reboot(int magic1, i
>                 machine_restart(buffer);
>                 break;
> 
> -#ifdef CONFIG_SOFTWARE_SUSPEND
> +#ifdef CONFIG_SUSPEND2
>         case LINUX_REBOOT_CMD_SW_SUSPEND:
>                 {
> -                       int ret = software_suspend();
> +                       suspend2_try_suspend();
>                         unlock_kernel();
> -                       return ret;

Are both mechanisms intended to live in the kernel? If not, where's
the patch to remove the old code?
