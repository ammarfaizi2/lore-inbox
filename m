Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261310AbVEFWtT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261310AbVEFWtT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 18:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261308AbVEFWtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 18:49:18 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:1206 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261317AbVEFWtI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 18:49:08 -0400
Date: Sat, 7 May 2005 00:48:47 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-pm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] kernel/power/swsusp.c: make a variable static
Message-ID: <20050506224847.GH5620@elf.ucw.cz>
References: <20050506212734.GQ3590@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050506212734.GQ3590@stusta.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Pá 06-05-05 23:27:35, Adrian Bunk wrote:
> This patch makes a needlessly global variable static.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6.12-rc3-mm2-full/kernel/power/swsusp.c.old	2005-05-03 07:48:39.000000000 +0200
> +++ linux-2.6.12-rc3-mm2-full/kernel/power/swsusp.c	2005-05-03 07:48:49.000000000 +0200
> @@ -81,7 +81,7 @@
>  extern char resume_file[];
>  
>  /* Local variables that should not be affected by save */
> -unsigned int nr_copy_pages __nosavedata = 0;
> +static unsigned int nr_copy_pages __nosavedata = 0;
>  
>  /* Suspend pagedir is allocated before final copy, therefore it
>     must be freed after resume

ACK.

-- 
Boycott Kodak -- for their patent abuse against Java.
