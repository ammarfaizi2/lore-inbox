Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261586AbVCRLk0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261586AbVCRLk0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 06:40:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261588AbVCRLk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 06:40:26 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:33931 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261586AbVCRLkN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 06:40:13 -0500
Date: Fri, 18 Mar 2005 12:39:57 +0100
From: Pavel Machek <pavel@ucw.cz>
To: coywolf@gmail.com, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] SUSPEND_PD_PAGES-fix
Message-ID: <20050318113957.GC32253@elf.ucw.cz>
References: <20050316202800.GA22750@everest.sosdg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050316202800.GA22750@everest.sosdg.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


> This fixes SUSPEND_PD_PAGES, which wastes one page under most cases.

Ok, applied to my tree, will eventually propagate it. (I hope it looks
okay to you, rafael).

> Signed-off-by: Coywolf Qi Hunt <coywolf@gmail.com>
> diff -pruN 2.6.11-mm4/include/linux/suspend.h 2.6.11-mm4-cy/include/linux/suspend.h
> --- 2.6.11-mm4/include/linux/suspend.h	2005-03-17 01:22:16.000000000 +0800
> +++ 2.6.11-mm4-cy/include/linux/suspend.h	2005-03-17 04:14:16.000000000 +0800
> @@ -34,7 +34,7 @@ typedef struct pbe {
>  #define SWAP_FILENAME_MAXLENGTH	32
>  
>  
> -#define SUSPEND_PD_PAGES(x)     (((x)*sizeof(struct pbe))/PAGE_SIZE+1)
> +#define SUSPEND_PD_PAGES(x)     (((x)*sizeof(struct pbe)+PAGE_SIZE-1)/PAGE_SIZE)
>  
>  extern dev_t swsusp_resume_device;
>     

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
