Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261927AbULGUlc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261927AbULGUlc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 15:41:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261906AbULGUlb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 15:41:31 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:1552 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261927AbULGUlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 15:41:22 -0500
Date: Tue, 7 Dec 2004 21:41:17 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Chris Wright <chrisw@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] binfmt_script.c: make struct script_format static (fwd)
Message-ID: <20041207204117.GJ7250@stusta.de>
References: <20041207193518.GB7250@stusta.de> <20041207120710.B469@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041207120710.B469@build.pdx.osdl.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2004 at 12:07:10PM -0800, Chris Wright wrote:
> * Adrian Bunk (bunk@stusta.de) wrote:
> > The patch forwarded below still applies and compiles against 
> > 2.6.10-rc2-mm4.
> > 
> > Please apply.
> 
> Yup, also binfmt_em86.c (are there any users of it?).

It's Alpha only.
That's why I didn't find this.

> thanks,
> -chris
> 
> Make em86_format static.
> 
> Signed-off-by: Chris Wright <chrisw@osdl.org>
> 
> ===== fs/binfmt_em86.c 1.8 vs edited =====
> --- 1.8/fs/binfmt_em86.c	2004-05-10 04:25:55 -07:00
> +++ edited/fs/binfmt_em86.c	2004-12-07 12:06:00 -08:00
> @@ -95,7 +95,7 @@ static int load_em86(struct linux_binprm
>  	return search_binary_handler(bprm, regs);
>  }
>  
> -struct linux_binfmt em86_format = {
> +static struct linux_binfmt em86_format = {
>  	.module		= THIS_MODULE,
>  	.load_binary	= load_em86,
>  };

Looks good.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

