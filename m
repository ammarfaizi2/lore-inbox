Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266967AbUBLBiN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 20:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266625AbUBLBiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 20:38:13 -0500
Received: from fed1mtao07.cox.net ([68.6.19.124]:58587 "EHLO
	fed1mtao07.cox.net") by vger.kernel.org with ESMTP id S266714AbUBLBiK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 20:38:10 -0500
Date: Wed, 11 Feb 2004 18:38:05 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][5/6] A different KGDB stub
Message-ID: <20040211183805.A8586@home.com>
References: <20040212000355.GF19676@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040212000355.GF19676@smtp.west.cox.net>; from trini@kernel.crashing.org on Wed, Feb 11, 2004 at 05:03:55PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 11, 2004 at 05:03:55PM -0700, Tom Rini wrote:
> The following is the ppc32-specific bits to this KGDB stub.

<snip>
> -	/* We are dorking with a live trap table, all irqs off */
> -}
> +	unsigned int tt;		/* Trap type code for powerpc */
> +	unsigned char signo;		/* Signal that we map this trap into */
> +} hard_trap_info[] = {
> +#if defined(CONFIG_40x)
> +	{ 0x0100, 0x02 /* SIGINT */  },		/* critical input interrupt */
> +	{ 0x0200, 0x0b /* SIGSEGV */ },		/* machine check */
> +	{ 0x0300, 0x0b /* SIGSEGV */ },		/* data storage */

This table should be at least CONFIG_4xx and probably
(CONFIG_4xx || CONFIG_BOOKE) if/when e500 support comes
into 2.6.

-Matt
