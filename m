Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964817AbWJBP4T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964817AbWJBP4T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 11:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750980AbWJBP4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 11:56:18 -0400
Received: from xenotime.net ([66.160.160.81]:42728 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750838AbWJBP4S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 11:56:18 -0400
Date: Mon, 2 Oct 2006 08:57:44 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: David Howells <dhowells@redhat.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] FRV: Permit large kmalloc allocations
Message-Id: <20061002085744.55bf8c28.rdunlap@xenotime.net>
In-Reply-To: <20061002153708.22649.96337.stgit@warthog.cambridge.redhat.com>
References: <20061002153708.22649.96337.stgit@warthog.cambridge.redhat.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 Oct 2006 16:37:08 +0100 David Howells wrote:

> From: David Howells <dhowells@redhat.com>
> 
> Permit kmalloc() to make allocations of up to 32MB if so configured.  This may
> be useful under NOMMU conditions where vmalloc() can't do this.
> 
> Signed-Off-By: David Howells <dhowells@redhat.com>
> ---
> 
>  arch/frv/Kconfig |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/frv/Kconfig b/arch/frv/Kconfig
> index f7b171b..69f9846 100644
> --- a/arch/frv/Kconfig
> +++ b/arch/frv/Kconfig
> @@ -86,6 +86,14 @@ config HIGHPTE
>  	  with a lot of RAM, this can be wasteful of precious low memory.
>  	  Setting this option will put user-space page tables in high memory.
>  
> +config LARGE_ALLOCS
> +	bool "Allow allocating large blocks (> 1MB) of memory"
> +	help
> +	  Allow the slab memory allocator to keep chains for very large memory
> +	  sizes - upto 32MB. You may need this if your system has a lot of RAM,

		up to (2 words)

> +	  and you need to able to allocate very large contiguous chunks. If
> +	  unsure, say N.
> +
>  source "mm/Kconfig"



---
~Randy
