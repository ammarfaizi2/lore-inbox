Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263852AbTKSFXs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 00:23:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263848AbTKSFXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 00:23:48 -0500
Received: from pix-525-pool.redhat.com ([66.187.233.200]:20691 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S263837AbTKSFXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 00:23:46 -0500
Date: Wed, 19 Nov 2003 00:23:27 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: Thomas Habets <thomas@habets.pp.se>
Cc: sparclinux@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: forgotten EXPORT_SYMBOL()s on sparc
Message-ID: <20031119052327.GF25965@devserv.devel.redhat.com>
References: <E1AMJBP-0003L5-00@reptilian.maxnet.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1AMJBP-0003L5-00@reptilian.maxnet.nu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Thomas Habets <thomas@habets.pp.se>
> Date: 	Wed, 19 Nov 2003 04:38:40 +0100

> - --- linux-2.6.0-test9.orig/arch/sparc/kernel/sparc_ksyms.c   2003-10-25
> 20:42:54.000000000 +0200
> +++ linux-2.6.0-test9/arch/sparc/kernel/sparc_ksyms.c       2003-11-19
> 03:09:46.000000000 +0100
> @@ -287,6 +287,8 @@
> 
>  /* Networking helper routines. */
>  /* XXX This is NOVERS because C_LABEL_STR doesn't get the version number.
>  -DaveM */
> +EXPORT_SYMBOL(sparc_flush_page_to_ram);
> +EXPORT_SYMBOL(csum_partial);
>  EXPORT_SYMBOL_NOVERS(__csum_partial_copy_sparc_generic);
> 
>  /* No version information on this, heavily used in inline asm,

I wanted to get rid of sparc_flush_page_to_ram, but for the
moment it may be better to export it... It probably wants
to be next to phys_base, if anywhere.

The csum_partial is exported by kernel/ksyms.c. Why does it fail?

-- Pete
