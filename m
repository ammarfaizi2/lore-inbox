Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262498AbTE2Srv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 14:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262513AbTE2Srv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 14:47:51 -0400
Received: from granite.he.net ([216.218.226.66]:51464 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S262498AbTE2Srt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 14:47:49 -0400
Date: Thu, 29 May 2003 12:02:50 -0700
From: Greg KH <greg@kroah.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: rusty@rustcorp.com.au, hannal@us.ibm.com
Subject: Re: [PATCH] sx tty_driver add .owner field remove MOD_INC_DEC_USE_COUNT
Message-ID: <20030529190250.GB24737@kroah.com>
References: <200305270126.h4R1QjA3029554@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305270126.h4R1QjA3029554@hera.kernel.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 27, 2003 at 12:01:08AM +0000, Linux Kernel Mailing List wrote:
> ChangeSet 1.1424, 2003/05/26 17:01:08-07:00, rusty@rustcorp.com.au
> 
> 	[PATCH] sx tty_driver add .owner field remove MOD_INC_DEC_USE_COUNT
> 	
> 	From:  Hanna Linder <hannal@us.ibm.com>
> 
> 
> # This patch includes the following deltas:
> #	           ChangeSet	1.1423  -> 1.1424 
> #	   drivers/char/sx.c	1.29    -> 1.30   
> #
> 
>  sx.c |   42 +-----------------------------------------
>  1 files changed, 1 insertion(+), 41 deletions(-)
> 
> 
> diff -Nru a/drivers/char/sx.c b/drivers/char/sx.c
> --- a/drivers/char/sx.c	Mon May 26 18:26:48 2003
> +++ b/drivers/char/sx.c	Mon May 26 18:26:48 2003
> @@ -305,7 +305,6 @@
>  static int  sx_get_CD (void * ptr); 
>  static void sx_shutdown_port (void * ptr);
>  static int  sx_set_real_termios (void  *ptr);
> -static void sx_hungup (void  *ptr);

Ick, this patch should be reverted, it should not be removing
sx_hungup() for no reason.  I think Hanna agrees with this.

thanks,

greg k-h
