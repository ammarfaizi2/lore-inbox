Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261889AbVCLALZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261889AbVCLALZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 19:11:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261884AbVCLAK5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 19:10:57 -0500
Received: from peabody.ximian.com ([130.57.169.10]:54968 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261761AbVCLAFc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 19:05:32 -0500
Subject: Re: [2.6 patch] drivers/pnp/: possible cleanups
From: Adam Belay <abelay@novell.com>
To: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>
Cc: perex@suse.cz, linux-kernel@vger.kernel.org
In-Reply-To: <20050311181606.GC3723@stusta.de>
References: <20050311181606.GC3723@stusta.de>
Content-Type: text/plain
Date: Fri, 11 Mar 2005 19:02:42 -0500
Message-Id: <1110585763.12485.223.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch essential makes it impossible for PnP protocols to be
modules.  Currently, they are all in-kernel.  If that is acceptable...,
then this patch looks fine to me.  Any comments?

Thanks,
Adam

On Fri, 2005-03-11 at 19:16 +0100, Adrian Bunk wrote:
> This patch contains the following possible cleanups:
> - make needlessly global code static
> - #if 0 the following unused global function:
>   - core.c: pnp_remove_device
> - remove the following unneeded EXPORT_SYMBOL's:
>   - card.c: pnp_add_card
>   - card.c: pnp_remove_card
>   - card.c: pnp_add_card_device
>   - card.c: pnp_remove_card_device
>   - card.c: pnp_add_card_id
>   - core.c: pnp_register_protocol
>   - core.c: pnp_unregister_protocol
>   - core.c: pnp_add_device
>   - core.c: pnp_remove_device
>   - pnpacpi/core.c: pnpacpi_protocol
>   - driver.c: pnp_add_id
>   - isapnp/core.c: isapnp_read_byte
>   - manager.c: pnp_auto_config_dev
>   - resource.c: pnp_register_dependent_option
>   - resource.c: pnp_register_independent_option
>   - resource.c: pnp_register_irq_resource
>   - resource.c: pnp_register_dma_resource
>   - resource.c: pnp_register_port_resource
>   - resource.c: pnp_register_mem_resource
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 


