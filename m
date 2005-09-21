Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750724AbVIUCPj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbVIUCPj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 22:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbVIUCPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 22:15:39 -0400
Received: from nproxy.gmail.com ([64.233.182.194]:12107 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750724AbVIUCPj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 22:15:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Neg6p6pXTkTAIjm9fo2bwjftwiciSULgGmgKFbQP2e9I4A9P+ZtsWDm0gOr7DG3AyT11Yw4PvEW582maNE4HuvPPMWyqn+Vav9odAsMU/IwAHS/0kt3qM6IM8IzKTlxoE2Gp/9irKw/JeeY+LVu61Wl7gyKc1AGBrrxu/thSGz8=
Message-ID: <2cd57c9005092019154758c826@mail.gmail.com>
Date: Wed, 21 Sep 2005 10:15:35 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: coywolf@gmail.com
To: linux-kernel@vger.kernel.org
Subject: Re: readme-update-from-the-stone-age.patch added to -mm tree
Cc: blaisorblade@yahoo.it, Andrew Morton <akpm@osdl.org>
In-Reply-To: <200509202336.j8KNak00013479@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200509202336.j8KNak00013479@shell0.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/05, akpm@osdl.org <akpm@osdl.org> wrote:
> 
> The patch titled
> 
>      README update from the stone age
> 
> has been added to the -mm tree.  Its filename is
> 
>      readme-update-from-the-stone-age.patch
> 
> 
> From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
> 
> We have no options which the user can set in the Makefile.  Only the
> EXTRAVERSION, which is also useful in place of the "backup modules"
> suggestion.
> 
> We don't have configuration options in the top Makefile.
> 
> Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
> 
>  README |    9 ++++++---
>  1 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff -puN README~readme-update-from-the-stone-age README
> --- 25/README~readme-update-from-the-stone-age  Tue Sep 20 16:36:49 2005
> +++ 25-akpm/README      Tue Sep 20 16:36:49 2005
> @@ -149,6 +149,9 @@ CONFIGURING the kernel:
>         "make gconfig"     X windows (Gtk) based configuration tool.
>         "make oldconfig"   Default all questions based on the contents of
>                            your existing ./.config file.
> +       "make silentoldconfig"
> +                          Like above, but avoids cluttering the screen
> +                          with question already answered.
> 
>         NOTES on "make config":
>         - having unnecessary drivers will make the kernel bigger, and can
> @@ -169,9 +172,6 @@ CONFIGURING the kernel:
>           should probably answer 'n' to the questions for
>            "development", "experimental", or "debugging" features.
> 
> - - Check the top Makefile for further site-dependent configuration
> -   (default SVGA mode etc).
> -
>  COMPILING the kernel:
> 
>   - Make sure you have gcc 2.95.3 available.
> @@ -199,6 +199,9 @@ COMPILING the kernel:
>     are installing a new kernel with the same version number as your
>     working kernel, make a backup of your modules directory before you
>     do a "make modules_install".
> +   In alternative, before compiling, edit your Makefile and change the
> +   "EXTRAVERSION" line - its content is appended to the regular kernel
> +   version.

This is wrong. You expect users to both do menuconfig and edit top
Makefile manually?  What is the local version for then?

> 
>   - In order to boot your new kernel, you'll need to copy the kernel
>     image (e.g. .../linux/arch/i386/boot/bzImage after compilation)
> _


-- 
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
