Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932251AbWBYIRB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbWBYIRB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 03:17:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932582AbWBYIRB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 03:17:01 -0500
Received: from smtp.osdl.org ([65.172.181.4]:16107 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932251AbWBYIRA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 03:17:00 -0500
Date: Sat, 25 Feb 2006 00:15:33 -0800
From: Andrew Morton <akpm@osdl.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: ak@suse.de, stsp@aknet.ru, linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] x86: start early_printk at sensible screen row
Message-Id: <20060225001533.3b06bbe0.akpm@osdl.org>
In-Reply-To: <200602250243_MC3-1-B93E-1384@compuserve.com>
References: <200602250243_MC3-1-B93E-1384@compuserve.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert <76306.1226@compuserve.com> wrote:
>
> Use boot info to start early_printk() at the proper row on VGA console.
> 

Define "proper".

> 
> --- 2.6.16-rc4-mm2-64.orig/arch/x86_64/kernel/early_printk.c
> +++ 2.6.16-rc4-mm2-64/arch/x86_64/kernel/early_printk.c
> @@ -244,7 +244,7 @@ int __init setup_early_printk(char *opt)
>  	           && SCREEN_INFO.orig_video_isVGA == 1) {
>  		max_xpos = SCREEN_INFO.orig_video_cols;
>  		max_ypos = SCREEN_INFO.orig_video_lines;
> -		current_ypos = max_ypos;
> +		current_ypos = SCREEN_INFO.orig_y;
>  		early_console = &early_vga_console; 
>   	} else if (!strncmp(buf, "simnow", 6)) {
>   		simnow_init(buf + 6);

Is that the place at which the boot loader left the cursor?

