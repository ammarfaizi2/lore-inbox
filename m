Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263218AbVCKEEy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263218AbVCKEEy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 23:04:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263173AbVCKECK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 23:02:10 -0500
Received: from 206.175.9.210.velocitynet.com.au ([210.9.175.206]:16791 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261701AbVCKDvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 22:51:11 -0500
Subject: Re: [PATCH] AGP support for powermac G5
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Paul Mackerras <paulus@samba.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Dave Jones <DaveJ@redhat.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Jerome Glisse <j.glisse@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linuxppc64-dev@ozlabs.org
In-Reply-To: <16945.2617.625095.404994@cargo.ozlabs.ibm.com>
References: <16945.2617.625095.404994@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Message-Id: <1110513167.3049.45.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 11 Mar 2005 14:52:47 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, 2005-03-11 at 14:02, Paul Mackerras wrote:
> +struct agp_bridge_driver u3_agp_driver = {
> +	.owner			= THIS_MODULE,
> +	.aperture_sizes		= (void *)u3_sizes,
> +	.size_type		= U32_APER_SIZE,
> +	.num_aperture_sizes	= 8,
> +	.configure		= uninorth_configure,
> +	.fetch_size		= uninorth_fetch_size,
> +	.cleanup		= uninorth_cleanup,
> +	.tlb_flush		= uninorth_tlbflush,
> +	.mask_memory		= agp_generic_mask_memory,
> +	.masks			= NULL,
> +	.cache_flush		= null_cache_flush,
> +	.agp_enable		= uninorth_agp_enable,
> +	.create_gatt_table	= uninorth_create_gatt_table,
> +	.free_gatt_table	= uninorth_free_gatt_table,
> +	.insert_memory		= u3_insert_memory,
> +	.remove_memory		= u3_remove_memory,
> +	.alloc_by_type		= agp_generic_alloc_by_type,
> +	.free_by_type		= agp_generic_free_by_type,
> +	.agp_alloc_page		= agp_generic_alloc_page,
> +	.agp_destroy_page	= agp_generic_destroy_page,
> +	.cant_use_aperture	= 1,
> +	.needs_scratch_page	= 1,
> +};
> +

No power management support? :>

Regards,

Nigel
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com
Bus: +61 (2) 6291 9554; Hme: +61 (2) 6292 8028;  Mob: +61 (417) 100 574

Maintainer of Suspend2 Kernel Patches http://suspend2.net

