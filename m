Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965130AbVKGUMe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965130AbVKGUMe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 15:12:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965172AbVKGUMe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 15:12:34 -0500
Received: from mail.kroah.org ([69.55.234.183]:11953 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965130AbVKGUMd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 15:12:33 -0500
Date: Mon, 7 Nov 2005 12:12:01 -0800
From: Greg KH <greg@kroah.com>
To: Ashutosh Naik <ashutosh_naik@adaptec.com>
Cc: pablo@eurodev.net, tgraf@suug.ch, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [stable] [PATCH] lib - Fix broken function declaration in linux/textsearch.h
Message-ID: <20051107201200.GA23160@kroah.com>
References: <1131363741.30115.35.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1131363741.30115.35.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2005 at 05:12:21PM +0530, Ashutosh Naik wrote:
> This PATCH addresses the issue of the init function pointer in
> lib/ts_bm.c, lib/ts_fsm.c and lib/ts_kmp.c using a mismatching
> definition in linux/textsearch.h
> 
> 
> Signed-off-by: Ashutosh Naik <ashutosh.naik@adaptec.com>

Is this upstream?

> --
> diff -Naurp linux-2.6.14-git10/include/linux/textsearch.h
> linux-2.6.14-git10-mod/include/linux/textsearch.h
> --- linux-2.6.14-git10/include/linux/textsearch.h       2005-10-28
> 05:32:08.000000000 +0530
> +++ linux-2.6.14-git10-mod/include/linux/textsearch.h   2005-11-07
> 16:39:05.000000000 +0530
> @@ -40,7 +40,7 @@ struct ts_state
>  struct ts_ops
>  {
>         const char              *name;
> -       struct ts_config *      (*init)(const void *, unsigned int,
> int);
> +       struct ts_config *      (*init)(const void *, unsigned int,
> gfp_t);

Ugh, your patch is line-wrapped, and the tabs are messed up.

Care to retry?

thanks,

greg k-h
