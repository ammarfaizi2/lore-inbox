Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261609AbVCGAk7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261609AbVCGAk7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 19:40:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbVCGAk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 19:40:59 -0500
Received: from fire.osdl.org ([65.172.181.4]:729 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261613AbVCGAkv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 19:40:51 -0500
Date: Sun, 6 Mar 2005 16:40:47 -0800
From: Andrew Morton <akpm@osdl.org>
To: domen@coderock.org
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, sebek64@post.cz
Subject: Re: [patch 07/12] Re: radio-sf16fmi cleanup
Message-Id: <20050306164047.5cdfcd8b.akpm@osdl.org>
In-Reply-To: <20050305153529.5430B1F203@trashy.coderock.org>
References: <20050305153529.5430B1F203@trashy.coderock.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

domen@coderock.org wrote:
>
> 
> This is small cleanup of radio-sf16fmi driver.

Well, yes, but it is a functional change, no?

Previously the kernel accepted the `sf16fm=' option.  Now the users must
switch over to, umm, `radio-sf16fmi.io=', yes?



> Signed-off-by: Marcel Sebek <sebek64@post.cz>
> Signed-off-by: Domen Puncer <domen@coderock.org>
> ---
> 
> 
>  kj-domen/Documentation/kernel-parameters.txt |    3 ---
>  kj-domen/drivers/media/radio/radio-sf16fmi.c |   10 ----------
>  2 files changed, 13 deletions(-)
> 
> diff -puN Documentation/kernel-parameters.txt~kill_kernel_parameter-sf16fm Documentation/kernel-parameters.txt
> --- kj/Documentation/kernel-parameters.txt~kill_kernel_parameter-sf16fm	2005-03-05 16:11:31.000000000 +0100
> +++ kj-domen/Documentation/kernel-parameters.txt	2005-03-05 16:11:31.000000000 +0100
> @@ -1148,9 +1148,6 @@ running once the system is up.
>  
>  	serialnumber	[BUGS=IA-32]
>  
> -	sf16fm=		[HW] SF16FMI radio driver for Linux
> -			Format: <io>
> -
>  	sg_def_reserved_size=
>  			[SCSI]
>   
> diff -puN drivers/media/radio/radio-sf16fmi.c~kill_kernel_parameter-sf16fm drivers/media/radio/radio-sf16fmi.c
> --- kj/drivers/media/radio/radio-sf16fmi.c~kill_kernel_parameter-sf16fm	2005-03-05 16:11:31.000000000 +0100
> +++ kj-domen/drivers/media/radio/radio-sf16fmi.c	2005-03-05 16:11:31.000000000 +0100
> @@ -326,13 +326,3 @@ static void __exit fmi_cleanup_module(vo
>  
>  module_init(fmi_init);
>  module_exit(fmi_cleanup_module);
> -
> -#ifndef MODULE
> -static int __init fmi_setup_io(char *str)
> -{
> -	get_option(&str, &io);
> -	return 1;
> -}
> -
> -__setup("sf16fm=", fmi_setup_io);
> -#endif
> _
