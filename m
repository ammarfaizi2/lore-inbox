Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261373AbVALUyY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261373AbVALUyY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 15:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261451AbVALUyV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 15:54:21 -0500
Received: from gprs214-252.eurotel.cz ([160.218.214.252]:12167 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261373AbVALUxC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 15:53:02 -0500
Date: Wed, 12 Jan 2005 21:52:44 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Domen Puncer <domen@coderock.org>
Cc: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: swsusp: more small fixes
Message-ID: <20050112205244.GH1408@elf.ucw.cz>
References: <20050112131010.GA1378@elf.ucw.cz> <20050112200611.GM4978@nd47.coderock.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050112200611.GM4978@nd47.coderock.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > -struct highmem_page *highmem_copy = NULL;
> > +static struct highmem_page *highmem_copy = NULL;
> 
> You could remove explicit initialization (so pointer would go into bss
> instead of data, IIRC).
> 
> > -		pr_debug("suspend: Allocating pagedir failed.\n");
> > +		printk("suspend: Allocating pagedir failed.\n");
> 
> Missing KERN_ constant.

> > -		pr_debug("suspend: Allocating image pages failed.\n");
> > +		printk("suspend: Allocating image pages failed.\n");
> 
> Same here.

Fixed, but I'd prefer to have this applied and fix it with followup
patch.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
