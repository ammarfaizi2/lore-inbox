Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261741AbVCVTdA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261741AbVCVTdA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 14:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbVCVT3s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 14:29:48 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:60589 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261691AbVCVT2I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 14:28:08 -0500
Date: Tue, 22 Mar 2005 20:27:13 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: blaisorblade@yahoo.it
cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       kbuild-devel@lists.sourceforge.net
Subject: Re: [patch 1/1] kconfig: trivial cleanup
In-Reply-To: <20050322163639.17AD1E7BB6@zion>
Message-ID: <Pine.LNX.4.61.0503222023020.25131@scrub.home>
References: <20050322163639.17AD1E7BB6@zion>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 22 Mar 2005 blaisorblade@yahoo.it wrote:

> Replace a menu_add_prop mimicking menu_add_prompt with the latter.
> 
> Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> ---
> 
>  linux-2.6.11-paolo/scripts/kconfig/zconf.y |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff -puN scripts/kconfig/zconf.y~kbuild-cleanup scripts/kconfig/zconf.y
> --- linux-2.6.11/scripts/kconfig/zconf.y~kbuild-cleanup	2005-03-22 17:34:36.000000000 +0100
> +++ linux-2.6.11-paolo/scripts/kconfig/zconf.y	2005-03-22 17:35:14.000000000 +0100
> @@ -443,7 +443,7 @@ prompt_stmt_opt:
>  	  /* empty */
>  	| prompt if_expr
>  {
> -	menu_add_prop(P_PROMPT, $1, NULL, $2);
> +	menu_add_prompt(P_PROMPT, $1, $2);
>  };
>  

If you change this, then please do it completely. All other remaining 
menu_add_prop in that can be changed to menu_add_prompt too and the same 
change needs to be done to zconf.tab.c_shipped.

bye, Roman
