Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268026AbUHFAZO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268026AbUHFAZO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 20:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268028AbUHFAZO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 20:25:14 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:48345 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S268026AbUHFAZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 20:25:07 -0400
Date: Thu, 5 Aug 2004 17:25:06 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][PPC32] Fix ebony uart clock
Message-ID: <20040805172505.J14159@home.com>
References: <4112C33A.40904@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <4112C33A.40904@am.sony.com>; from geoffrey.levand@am.sony.com on Thu, Aug 05, 2004 at 04:31:06PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2004 at 04:31:06PM -0700, Geoff Levand wrote:
> ebony-uart-clock-04.08.05.patch:
> 
> This patch corrects the Ebony board's uart clock value to the rate
> of the external Epson SG-615P clock source.  Now good to 115Kbps.
> 
> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com> for CELF
> ---
> 
>   ebony.h |    3 ++-
>   1 files changed, 2 insertions(+), 1 deletion(-)
> 
>   diff -X dontdiff -ruN 
> linux-2.6.8-rc3.orig/arch/ppc/platforms/4xx/ebony.h 
> branch_KGDB/arch/ppc/platforms/4xx/ebony.h
> --- linux-2.6.8-rc3.orig/arch/ppc/platforms/4xx/ebony.h	2004-07-17 
> 21:59:03.000000000 -0700
> +++ branch_KGDB/arch/ppc/platforms/4xx/ebony.h	2004-08-05 
> 15:58:40.000000000 -0700
> @@ -64,7 +64,8 @@
>   #define UART0_IO_BASE	(u8 *) 0xE0000200
>   #define UART1_IO_BASE	(u8 *) 0xE0000300
> 
> -#define BASE_BAUD	33000000/3/16
> +/* external Epson SG-615P */
> +#define BASE_BAUD	691200
> 
>   #define STD_UART_OP(num)					\
>   	{ 0, BASE_BAUD, 0, UART##num##_INT,			\

Looks good for my Ebony board. Andrew, please apply.

-Matt
