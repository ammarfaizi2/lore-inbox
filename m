Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751201AbWELLFs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbWELLFs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 07:05:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbWELLFs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 07:05:48 -0400
Received: from webapps.arcom.com ([194.200.159.168]:12050 "EHLO
	webapps.arcom.com") by vger.kernel.org with ESMTP id S1751201AbWELLFr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 07:05:47 -0400
Message-ID: <44646C08.9000800@cantab.net>
Date: Fri, 12 May 2006 12:05:44 +0100
From: David Vrabel <dvrabel@cantab.net>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: mb@bu3sch.de
CC: akpm@osdl.org, Deepak Saxena <dsaxena@plexity.net>,
       bcm43xx-dev@lists.berlios.de, linux-kernel@vger.kernel.org,
       Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: [patch 5/9] Add Geode HW RNG driver
References: <20060512103522.898597000@bu3sch.de> <20060512103648.229129000@bu3sch.de>
In-Reply-To: <20060512103648.229129000@bu3sch.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 May 2006 11:05:43.0881 (UTC) FILETIME=[036F0B90:01C675B4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mb@bu3sch.de wrote:
> Signed-off-by: Michael Buesch <mb@bu3sch.de>
> Index: hwrng/drivers/char/hw_random/Kconfig
> ===================================================================
> --- hwrng.orig/drivers/char/hw_random/Kconfig	2006-05-08 00:11:59.000000000 +0200
> +++ hwrng/drivers/char/hw_random/Kconfig	2006-05-08 00:12:08.000000000 +0200
> @@ -35,3 +35,16 @@
>  	  module will be called amd-rng.
>  
>  	  If unsure, say Y.
> +
> +config HW_RANDOM_GEODE
> +	tristate "AMD Geode HW Random Number Generator support"
> +	depends on HW_RANDOM && (X86 || IA64) && PCI
                                     ^^^^^^^
IA64?

> +	default y
> +	---help---
> +	  This driver provides kernel-side support for the Random Number
> +	  Generator hardware found on AMD Geode based motherboards.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called geode-rng.

You need to state which members of the Geode family have this hardware.
 e.g., Is it only the Geode LX CPUs?

David Vrabel
