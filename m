Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751023AbWA2PPV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751023AbWA2PPV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 10:15:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751024AbWA2PPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 10:15:21 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:46527 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750930AbWA2PPU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 10:15:20 -0500
Date: Sun, 29 Jan 2006 16:15:10 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Make software suspend work with CONFIG_MEMORY_HOTPLUG=n
Message-ID: <20060129151509.GC1764@elf.ucw.cz>
References: <20060127204315.GA30447@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060127204315.GA30447@redhat.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=178339
> 
> pageset_cpuup_callback() is marked __meminit, but software suspend
> needs it.  Unfortunatly, if you don't have CONFIG_MEMORY_HOTPLUG set,
> the __meminit translates to __init, resulting in this...

> Signed-off-by: Dave Jones <davej@redhat.com>

ACK. Please push...
							Pavel

> --- linux-2.6.15.noarch/mm/page_alloc.c~	2006-01-27 15:40:35.000000000 -0500
> +++ linux-2.6.15.noarch/mm/page_alloc.c	2006-01-27 15:40:40.000000000 -0500
> @@ -1939,7 +1939,7 @@ static inline void free_zone_pagesets(in
>  	}
>  }
>  
> -static int __meminit pageset_cpuup_callback(struct notifier_block *nfb,
> +static int pageset_cpuup_callback(struct notifier_block *nfb,
>  		unsigned long action,
>  		void *hcpu)
>  {


-- 
Thanks, Sharp!
