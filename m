Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262786AbVCJWlP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262786AbVCJWlP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 17:41:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262402AbVCJWkc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 17:40:32 -0500
Received: from 70-56-134-246.albq.qwest.net ([70.56.134.246]:14546 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S263310AbVCJWcm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 17:32:42 -0500
Date: Thu, 10 Mar 2005 15:33:15 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Chris Wedgwood <cw@f00f.org>
cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.x --- early boot code references check_acpi_pci()
In-Reply-To: <20050310213309.GA17298@taniwha.stupidest.org>
Message-ID: <Pine.LNX.4.61.0503101529250.15222@montezuma.fsmlabs.com>
References: <20050310213309.GA17298@taniwha.stupidest.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Mar 2005, Chris Wedgwood wrote:

> For x86 (and friends) ACPI_BOOT=y (always) and this code wants to call
> check_acpi_pci().
> 
> Signed-off-by: Chris Wedgwood <cw@f00f.org>
> 
> ===== arch/i386/kernel/earlyquirk.c 1.1 vs edited =====
> --- 1.1/arch/i386/kernel/earlyquirk.c	2005-02-18 06:53:58 -08:00
> +++ edited/arch/i386/kernel/earlyquirk.c	2005-03-10 13:29:55 -08:00
> @@ -8,7 +8,7 @@
>  #include <asm/pci-direct.h>
>  #include <asm/acpi.h>
>  
> -#ifdef CONFIG_ACPI
> +#ifdef CONFIG_ACPI_BOOT
>  static int __init check_bridge(int vendor, int device) 
>  {
>  	/* According to Nvidia all timer overrides are bogus. Just ignore

Thanks Chris

Acked-by: Zwane Mwaikambo <zwane@arm.linux.org.uk>
