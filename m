Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750922AbWDIV1L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750922AbWDIV1L (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 17:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750930AbWDIV1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 17:27:11 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:64528 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750922AbWDIV1J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 17:27:09 -0400
Date: Sun, 9 Apr 2006 23:27:04 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 4/19] kconfig: fix typo in change count initialization
Message-ID: <20060409212704.GB30208@mars.ravnborg.org>
References: <Pine.LNX.4.64.0604091727190.23120@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0604091727190.23120@scrub.home>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 09, 2006 at 05:27:28PM +0200, Roman Zippel wrote:
> 
> Signed-off-by: Roman Zippel <zippel@linux-m68k.org>
> 
> ---
> 
>  scripts/kconfig/confdata.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-2.6-git/scripts/kconfig/confdata.c
> ===================================================================
> --- linux-2.6-git.orig/scripts/kconfig/confdata.c
> +++ linux-2.6-git/scripts/kconfig/confdata.c
> @@ -325,7 +325,7 @@ int conf_read(const char *name)
>  				sym->flags |= e->right.sym->flags & SYMBOL_NEW;
>  	}
>  
> -	sym_change_count = conf_warnings && conf_unsaved;
> +	sym_change_count = conf_warnings || conf_unsaved;
>  
>  	return 0;
>  }

Please explain what this actually fixes.
I recall we have touched this area before but I do not recall the
details.

	Sam
