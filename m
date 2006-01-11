Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751585AbWANJdw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751585AbWANJdw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 04:33:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751583AbWANJdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 04:33:52 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:20231 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1751186AbWANJdw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 04:33:52 -0500
Date: Wed, 11 Jan 2006 19:59:58 +0000
From: Pavel Machek <pavel@suse.cz>
To: Matt Tolentino <metolent@cs.vt.edu>
Cc: ak@suse.de, akpm@osdl.org, discuss@x86-64.org, kmannth@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 1/2] add __meminit for memory hotplug
Message-ID: <20060111195958.GE2456@ucw.cz>
References: <200601091519.k09FJUi3022305@ap1.cs.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601091519.k09FJUi3022305@ap1.cs.vt.edu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 09-01-06 10:19:30, Matt Tolentino wrote:
> Add __meminit to the __init lineup to ensure functions default
> to __init when memory hotplug is not enabled.  Replace __devinit
> with __meminit on functions that were changed when the memory
> hotplug code was introduced.  
> 
> diff -urNp linux-2.6.15/include/linux/init.h linux-2.6.15-matt/include/linux/init.h
> --- linux-2.6.15/include/linux/init.h	2006-01-02 22:21:10.000000000 -0500
> +++ linux-2.6.15-matt/include/linux/init.h	2006-01-06 11:04:10.000000000 -0500
> @@ -241,6 +241,18 @@ void __init parse_early_param(void);
>  #define __cpuexitdata	__exitdata
>  #endif
>  
> +#ifdef CONFIG_MEMORY_HOTPLUG
> +#define __meminit
> +#define __meminitdata
> +#define __memexit
> +#define __memexitdata

You should document these...

-- 
Thanks, Sharp!
