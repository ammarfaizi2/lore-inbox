Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261276AbVEKWFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbVEKWFP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 18:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbVEKWFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 18:05:15 -0400
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:61481 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S261276AbVEKWFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 18:05:08 -0400
X-IronPort-AV: i="3.93,96,1115010000"; 
   d="scan'208"; a="260442659:sNHT23598992"
Date: Wed, 11 May 2005 17:05:07 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: Abhay Salunke <Abhay_Salunke@dell.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 2.6.12-rc3] dell_rbu: New Dell BIOS update driver
Message-ID: <20050511220507.GA11723@lists.us.dell.com>
References: <20050510220520.GA30741@littleblue.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050510220520.GA30741@littleblue.us.dell.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2005 at 05:05:20PM -0500, Abhay Salunke wrote:
> The dell_rbu driver is required for updating BIOS on DELL servers and client
> systems. The driver lets a user application download the BIOS image in to
> contiguous physical memory pages; the driver exposes the memory via sysfs
> filesystem. The update mechanism basically has two approcahes; one by
> allocating contiguous physical memory and the second approach is by allocating
> small chunks of contiguous physical memory.

[snip]

> diff -uprN linux-2.6.11.8.ORIG/drivers/firmware/Kconfig linux-2.6.11.8/drivers/firmware/Kconfig
> --- linux-2.6.11.8.ORIG/drivers/firmware/Kconfig	2005-05-09 15:13:06.257801832 -0500
> +++ linux-2.6.11.8/drivers/firmware/Kconfig	2005-05-09 16:30:47.746147888 -0500
> @@ -58,4 +58,16 @@ config EFI_PCDP
>  
>  	  See <http://www.dig64.org/specifications/DIG64_HCDPv20_042804.pdf>
>  
> +config DELL_RBU
> +        bool "BIOS update support for DELL systems via sysfs"

Trivial: needs to be tristate, not bool, to make a module.  Change
help text then accordingly.

Thanks,
Matt

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
