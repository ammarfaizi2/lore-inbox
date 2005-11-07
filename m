Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932392AbVKGBDx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932392AbVKGBDx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 20:03:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932394AbVKGBDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 20:03:52 -0500
Received: from ozlabs.org ([203.10.76.45]:3530 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932392AbVKGBDw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 20:03:52 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17262.42750.810366.294231@cargo.ozlabs.ibm.com>
Date: Mon, 7 Nov 2005 11:59:42 +1100
From: Paul Mackerras <paulus@samba.org>
To: Mike Kravetz <kravetz@us.ibm.com>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Subject: Re: [PATCH 4/4] Memory Add Fixes for ppc64
In-Reply-To: <20051104232109.GE25545@w-mikek2.ibm.com>
References: <20051104231552.GA25545@w-mikek2.ibm.com>
	<20051104232109.GE25545@w-mikek2.ibm.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Kravetz writes:

> ppc64 needs a special sysfs probe file for adding new memory.
> 
> Signed-off-by: Mike Kravetz <kravetz@us.ibm.com>
> 
> diff -Naupr linux-2.6.14-git7/arch/ppc64/Kconfig linux-2.6.14-git7.work/arch/ppc64/Kconfig
> --- linux-2.6.14-git7/arch/ppc64/Kconfig	2005-11-04 21:21:06.000000000 +0000
> +++ linux-2.6.14-git7.work/arch/ppc64/Kconfig	2005-11-04 22:11:16.000000000 +0000
> @@ -277,6 +277,10 @@ config HAVE_ARCH_EARLY_PFN_TO_NID
>  	def_bool y
>  	depends on NEED_MULTIPLE_NODES
>  
> +config ARCH_MEMORY_PROBE
> +	def_bool y
> +	depends on MEMORY_HOTPLUG
> +

Does arch/powerpc/Kconfig need a similar fix then?

Paul.
