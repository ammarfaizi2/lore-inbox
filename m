Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261570AbVALXe4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261570AbVALXe4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 18:34:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261560AbVALXeu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 18:34:50 -0500
Received: from gprs214-252.eurotel.cz ([160.218.214.252]:17555 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261570AbVALXdz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 18:33:55 -0500
Date: Thu, 13 Jan 2005 00:33:40 +0100
From: Pavel Machek <pavel@suse.cz>
To: hugang@soulinfo.com, linux-kernel@vger.kernel.org
Subject: Re: PATCH swsusp: page rellocation speed up (fwd)
Message-ID: <20050112233340.GR1408@elf.ucw.cz>
References: <20050112194446.GC1464@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050112194446.GC1464@openzaurus.ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > attached patch should speed up page rellocation at time of resume. Please test.
> > The diff is against 2.6.10-bk8
> > 
> ....
> 
> really cool, Passed in my x86 and ppc.
> 
> Here is a patch to make pagedir using non-continuity page, 
>  2.6.10 -> mm1 -> this patch -> my patch
> 
> I temporary split pbe function to pbe.h, useful merge. 

I do not know, but introducing new file will not help the merge.

								Pavel

> --- 2.6.10-mm1-one-pbe/kernel/power/pbe.h	1970-01-01 07:00:00.000000000 +0700
> +++ 2.6.10-mm1-one-pbe-hg/kernel/power/pbe.h	2005-01-12 20:42:17.000000000 +0800
> @@ -0,0 +1,380 @@
> +static int mod_progress = 1;
> +
> +static void inline mod_printk_progress(int i)
> +{
> +	if (mod_progress == 0) mod_progress = 1;
> +	if (!(i%100))
> +		printk( "\b\b\b\b%3d%%", i / mod_progress );
> +}

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
