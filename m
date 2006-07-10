Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161284AbWGJAvW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161284AbWGJAvW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 20:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964938AbWGJAvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 20:51:22 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:51088 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S964923AbWGJAvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 20:51:21 -0400
Date: Mon, 10 Jul 2006 09:52:54 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-kernel@vger.kernel.org, mbligh@google.com, hch@infradead.org,
       marcelo@kvack.org, arjan@infradead.org, nickpiggin@yahoo.com.au,
       clameter@sgi.com, ak@suse.de
Subject: Re: [RFC 1/8] Add CONFIG_ZONE_DMA to all archesM
Message-Id: <20060710095254.bad0084b.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060708000506.3829.34340.sendpatchset@schroedinger.engr.sgi.com>
References: <20060708000501.3829.25578.sendpatchset@schroedinger.engr.sgi.com>
	<20060708000506.3829.34340.sendpatchset@schroedinger.engr.sgi.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jul 2006 17:05:06 -0700 (PDT)
Christoph Lameter <clameter@sgi.com> wrote:
> As a result of this patch CONFIG_ZONE_DMA should be defined for every
> arch.
> 
> Signed-off-by: Christoph Lameter <clameter@sgi.com>
> 
> Index: linux-2.6.17-mm6/mm/Kconfig
> ===================================================================
> --- linux-2.6.17-mm6.orig/mm/Kconfig	2006-07-03 13:47:22.616084772 -0700
> +++ linux-2.6.17-mm6/mm/Kconfig	2006-07-03 21:26:49.956038556 -0700
> @@ -134,6 +134,10 @@ config SPLIT_PTLOCK_CPUS
>  	default "4096" if PARISC && !PA20
>  	default "4"
>  
> +config ZONE_DMA
> +	def_bool y
> +	depends on GENERIC_ISA_DMA
> +

How about configuring this by

config ZONE_DMA
	def_bool y
	depends on GENERIC_ISA_DMA || ARCH_ZONE_DMA

and set ARCH_ZONE_DMA for each arch ?


-Kame

