Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268370AbUJTPyb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268370AbUJTPyb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 11:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266663AbUJTPx7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 11:53:59 -0400
Received: from smtp804.mail.sc5.yahoo.com ([66.163.168.183]:26015 "HELO
	smtp804.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267866AbUJTPZY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 11:25:24 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove MODULE_PARM from arch/i386
Date: Wed, 20 Oct 2004 10:25:18 -0500
User-Agent: KMail/1.6.2
Cc: Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>
References: <1098259264.10571.147.camel@localhost.localdomain>
In-Reply-To: <1098259264.10571.147.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Message-Id: <200410201025.18345.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 20 October 2004 03:01 am, Rusty Russell wrote:
> Name: Remove MODULE_PARM from i386 arch
> Status: Compiled on 2.6-bk
> Depends: Module/MODULE_PARM-defconfig.patch.gz
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> 
> This patch removes MODULE_PARM for everything under arch/i386.
> Currently only APM.
> 
> diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .3678-linux-2.6-bk/arch/i386/kernel/apm.c .3678-linux-2.6-bk.updated/arch/i386/kernel/apm.c
> --- .3678-linux-2.6-bk/arch/i386/kernel/apm.c   2004-10-19 14:33:50.000000000 +1000
> +++ .3678-linux-2.6-bk.updated/arch/i386/kernel/apm.c   2004-10-20 17:56:12.000000000 +1000
> @@ -2393,27 +2393,27 @@ module_exit(apm_exit);
>  MODULE_AUTHOR("Stephen Rothwell");
>  MODULE_DESCRIPTION("Advanced Power Management");
>  MODULE_LICENSE("GPL");
> -MODULE_PARM(debug, "i");
> +module_param(debug, bool, 0644);
>  MODULE_PARM_DESC(debug, "Enable debug mode");
> -MODULE_PARM(power_off, "i");
> +module_param(power_off, bool, 0444);
                                 ^^^^^
I am wondering if we need to waste kernel resources by creating sysfs
attributes for parameters that can not be changed at runtime (by user
or kernel)...

-- 
Dmitry
