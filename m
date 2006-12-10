Return-Path: <linux-kernel-owner+w=401wt.eu-S1761854AbWLJQRJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761854AbWLJQRJ (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 11:17:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761856AbWLJQRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 11:17:09 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.15]:23921 "EHLO
	amsfep13-int.chello.nl" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1761854AbWLJQRH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 11:17:07 -0500
Subject: Re: [PATCH] tty: export get_current_tty
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061210142151.GA28442@osiris.ibm.com>
References: <20061210142151.GA28442@osiris.ibm.com>
Content-Type: text/plain
Date: Sun, 10 Dec 2006 17:08:43 +0100
Message-Id: <1165766923.32332.30.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-12-10 at 15:21 +0100, Heiko Carstens wrote:
> From: Heiko Carstens <heiko.carstens@de.ibm.com>
> 
> [PATCH] tty: export get_current_tty
> 
> 24ec839c431eb79bb8f6abc00c4e1eb3b8c4d517 causes this:
> 
> WARNING: "get_current_tty" [drivers/s390/char/fs3270.ko] undefined!

Must be another remnant from OOLing it, sure ACK.

> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
> Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
> ---
>  drivers/char/tty_io.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> Index: linux-2.6/drivers/char/tty_io.c
> ===================================================================
> --- linux-2.6.orig/drivers/char/tty_io.c
> +++ linux-2.6/drivers/char/tty_io.c
> @@ -3821,6 +3821,7 @@ struct tty_struct *get_current_tty(void)
>  	barrier();
>  	return tty;
>  }
> +EXPORT_SYMBOL_GPL(get_current_tty);
>  
>  /*
>   * Initialize the console device. This is called *early*, so
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

