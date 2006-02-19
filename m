Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932353AbWBSAVS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353AbWBSAVS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 19:21:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932365AbWBSAVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 19:21:18 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:1549 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932353AbWBSAVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 19:21:17 -0500
Date: Sun, 19 Feb 2006 00:19:55 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Bastian Blank <bastian@waldi.eu.org>,
       Arthur Othieno <apgo@patchbomb.org>, Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH/RFC] remove duplicate #includes, take II, part B
Message-ID: <20060219001954.GA18663@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Linux Kernel ML <linux-kernel@vger.kernel.org>,
	Bastian Blank <bastian@waldi.eu.org>,
	Arthur Othieno <apgo@patchbomb.org>,
	Jean Delvare <khali@linux-fr.org>
References: <20060218145525.GA32618@MAIL.13thfloor.at> <20060218145847.GC32618@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060218145847.GC32618@MAIL.13thfloor.at>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 18, 2006 at 03:58:47PM +0100, Herbert Poetzl wrote:
> diff -NurpP linux-2.6.16-rc4/include/asm-arm/arch-clps711x/hardware.h linux-2.6.16-rc4-rmd/include/asm-arm/arch-clps711x/hardware.h
> --- linux-2.6.16-rc4/include/asm-arm/arch-clps711x/hardware.h	2004-08-14 12:55:32 +0200
> +++ linux-2.6.16-rc4-rmd/include/asm-arm/arch-clps711x/hardware.h	2006-02-18 15:30:15 +0100
> @@ -180,7 +180,6 @@
>  #define  CEIVA_BASE		CLPS7111_VIRT_BASE
>  
>  #include <asm/hardware/clps7111.h>
> -#include <asm/hardware/ep7212.h>
>  
>  
>  /*

This looks like a candidate for probably wrong.  (I'm not convinced myself
because it relies on too many config variables.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
