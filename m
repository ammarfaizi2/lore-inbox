Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264374AbUADAK3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 19:10:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264375AbUADAK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 19:10:29 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:60424 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264371AbUADAJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 19:09:58 -0500
Date: Sun, 4 Jan 2004 00:09:55 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [minor & trivial patch] kill some potential warnings about inline keyword placement - 2.6.1-rc1-mm1
Message-ID: <20040104000955.B11953@flint.arm.linux.org.uk>
Mail-Followup-To: Jesper Juhl <juhl-lkml@dif.dk>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.56.0401040046450.4664@jju_lnx.backbone.dif.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.56.0401040046450.4664@jju_lnx.backbone.dif.dk>; from juhl-lkml@dif.dk on Sun, Jan 04, 2004 at 01:01:26AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 04, 2004 at 01:01:26AM +0100, Jesper Juhl wrote:
> --- linux-2.6.1-rc1-mm1-orig/include/linux/efi.h        2003-12-31 05:48:26.000000000 +0100
> +++ linux-2.6.1-rc1-mm1/include/linux/efi.h     2004-01-04 00:29:48.000000000 +0100
> @@ -297,8 +297,8 @@ extern u64 efi_mem_attributes (unsigned
>  extern void efi_initialize_iomem_resources(struct resource *code_resource,
>                                         struct resource *data_resource);
>  extern efi_status_t phys_efi_get_time(efi_time_t *tm, efi_time_cap_t *tc);
> -extern unsigned long inline __init efi_get_time(void);
> -extern int inline __init efi_set_rtc_mmss(unsigned long nowtime);
> +inline extern unsigned long __init efi_get_time(void);
> +inline extern int __init efi_set_rtc_mmss(unsigned long nowtime);

For the sake of consistency, can we keep these the same as the rest
of the kernel code please?  IOW:

extern inline unsigned long __init efi_get_time(void);

Thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
