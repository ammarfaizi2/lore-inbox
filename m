Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932355AbVLUTkm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355AbVLUTkm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 14:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbVLUTkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 14:40:42 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:39863 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S1751192AbVLUTkm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 14:40:42 -0500
Date: Wed, 21 Dec 2005 12:40:41 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Mark Maule <maule@sgi.com>
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH 1/4] msi archetecture init hook
Message-ID: <20051221194041.GG2361@parisc-linux.org>
References: <20051221184337.5003.85653.32527@attica.americas.sgi.com> <20051221184342.5003.74247.39285@attica.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051221184342.5003.74247.39285@attica.americas.sgi.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2005 at 12:42:36PM -0600, Mark Maule wrote:
> Index: msi/include/asm-sparc/msi.h
> ===================================================================
> --- msi.orig/include/asm-sparc/msi.h	2005-12-13 12:22:42.785246074 -0600
> +++ msi/include/asm-sparc/msi.h	2005-12-13 16:09:49.194541334 -0600
> @@ -28,4 +28,6 @@
>  			      "i" (ASI_M_CTL), "r" (MSI_ASYNC_MODE) : "g3");
>  }
>  
> +static inline int msi_arch_init(void)	{ return 0; }
> +
>  #endif /* !(_SPARC_MSI_H) */

Ah, look at the header for asm-sparc/msi.h:

 * msi.h:  Defines specific to the MBus - Sbus - Interface.

Not Message Signalled Interrupts at all ;-)
