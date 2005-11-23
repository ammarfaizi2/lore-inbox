Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030461AbVKWWqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030461AbVKWWqz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 17:46:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030460AbVKWWqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 17:46:55 -0500
Received: from xenotime.net ([66.160.160.81]:17370 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1030454AbVKWWqw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 17:46:52 -0500
Date: Wed, 23 Nov 2005 14:46:51 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Adrian Bunk <bunk@stusta.de>
cc: Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: [-mm patch] init/main.c: dummy mark_rodata_ro() should be static
In-Reply-To: <20051123223505.GF3963@stusta.de>
Message-ID: <Pine.LNX.4.58.0511231443420.20189@shark.he.net>
References: <20051123033550.00d6a6e8.akpm@osdl.org> <20051123223505.GF3963@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Nov 2005, Adrian Bunk wrote:

> Every inline dummy function should be static.

Please explain why it matters in this case.

> Signed-off-by: Adrian Bunk <bunk@stusta.de>
>
> --- linux-2.6.15-rc2-mm1-full/init/main.c.old	2005-11-23 16:50:45.000000000 +0100
> +++ linux-2.6.15-rc2-mm1-full/init/main.c	2005-11-23 16:50:55.000000000 +0100
> @@ -101,7 +101,7 @@
>  static inline void acpi_early_init(void) { }
>  #endif
>  #ifndef CONFIG_DEBUG_RODATA
> -inline void mark_rodata_ro(void) { }
> +static inline void mark_rodata_ro(void) { }
>  #endif
>
>  #ifdef CONFIG_TC

-- 
~Randy
