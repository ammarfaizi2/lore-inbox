Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932118AbVHHRGI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbVHHRGI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 13:06:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932117AbVHHRGI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 13:06:08 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:30860 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S932116AbVHHRGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 13:06:07 -0400
In-Reply-To: <Pine.LNX.4.61.0508040858290.13245@nylon.am.freescale.net>
References: <Pine.LNX.4.61.0508040858290.13245@nylon.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v733)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <C9F14415-10D2-4D15-8609-78215B9E2E34@freescale.com>
Cc: Jiang Bo-r61859 <Tanya.jiang@freescale.com>,
       linux-kernel list <linux-kernel@vger.kernel.org>,
       linuxppc-embedded list <linuxppc-embedded@ozlabs.org>,
       Andrew Morton <akpm@osdl.org>
Content-Transfer-Encoding: 7bit
From: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: [PATCH] ppc32: Fix MPC834x USB memory map offsets
Date: Mon, 8 Aug 2005 12:06:01 -0500
To: Linus Torvalds <torvalds@osdl.org>
X-Mailer: Apple Mail (2.733)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

If this can go into 2.6.13 that would be good since is a fairly  
trivial bug and fix.

- kumar

On Aug 4, 2005, at 8:59 AM, Gala Kumar K.-galak wrote:

> The memory mappings for MPC8349 USB MPH and DR modules were reversed.
>
> Signed-off-by: Li Yang <LeoLi@freescale.com>
> Signed-off-by: Jiang Bo <Tanya.jiang@freescale.com>
> Signed-off-by: Kumar Gala <kumar.gala@freescale.com>
>
> ---
> commit a2227df6ac23000dff7d95411ae5bd8022437ad3
> tree d22a59e837eb881b1292f70e51df561802b279df
> parent 51904043565cdfb348f58ce99377427c5ffe25fd
> author Kumar K. Gala <kumar.gala@freescale.com> Thu, 04 Aug 2005
> 08:57:58 -0500
> committer Kumar K. Gala <kumar.gala@freescale.com> Thu, 04 Aug 2005
> 08:57:58 -0500
>
>  arch/ppc/syslib/mpc83xx_devices.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/ppc/syslib/mpc83xx_devices.c
> b/arch/ppc/syslib/mpc83xx_devices.c
> --- a/arch/ppc/syslib/mpc83xx_devices.c
> +++ b/arch/ppc/syslib/mpc83xx_devices.c
> @@ -191,8 +191,8 @@ struct platform_device ppc_sys_platform_
>          .num_resources     = 2,
>          .resource = (struct resource[]) {
>              {
> -                .start    = 0x22000,
> -                .end    = 0x22fff,
> +                .start    = 0x23000,
> +                .end    = 0x23fff,
>                  .flags    = IORESOURCE_MEM,
>              },
>              {
> @@ -208,8 +208,8 @@ struct platform_device ppc_sys_platform_
>          .num_resources     = 2,
>          .resource = (struct resource[]) {
>              {
> -                .start    = 0x23000,
> -                .end    = 0x23fff,
> +                .start    = 0x22000,
> +                .end    = 0x22fff,
>                  .flags    = IORESOURCE_MEM,
>              },
>              {
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>

