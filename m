Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750726AbVITXxy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbVITXxy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 19:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbVITXxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 19:53:52 -0400
Received: from xenotime.net ([66.160.160.81]:55014 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750726AbVITXxv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 19:53:51 -0400
Date: Tue, 20 Sep 2005 16:53:51 -0700 (PDT)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] README update from the stone age
In-Reply-To: <20050920184544.14557.15273.stgit@zion.home.lan>
Message-ID: <Pine.LNX.4.58.0509201644040.19786@shark.he.net>
References: <20050920184513.14557.8152.stgit@zion.home.lan>
 <20050920184544.14557.15273.stgit@zion.home.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Sep 2005, Paolo 'Blaisorblade' Giarrusso wrote:

> We have no options which the user can set in the Makefile. Only the
> EXTRAVERSION, which is also useful in place of the "backup modules"
> suggestion.
>
> Hey! Can anybody tell me when we last had configuration options in the top
> Makefile? Please?
>
> Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> ---
>
>  README |    9 ++++++---
>  1 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/README b/README
> --- a/README
> +++ b/README
> @@ -149,6 +149,9 @@ CONFIGURING the kernel:
>  	"make gconfig"     X windows (Gtk) based configuration tool.
>  	"make oldconfig"   Default all questions based on the contents of
>  			   your existing ./.config file.
> +	"make silentoldconfig"
> +			   Like above, but avoids cluttering the screen
> +			   with question already answered.
                                questions

>
>  	NOTES on "make config":
>  	- having unnecessary drivers will make the kernel bigger, and can
> @@ -169,9 +172,6 @@ CONFIGURING the kernel:
>  	  should probably answer 'n' to the questions for
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
      Alternatively,

> +   "EXTRAVERSION" line - its content is appended to the regular kernel
> +   version.
      Or consider using CONFIG_LOCALVERSION, which can be set by
      using the "make *config" tools in the "General Setup" menu.

>
>   - In order to boot your new kernel, you'll need to copy the kernel
>     image (e.g. .../linux/arch/i386/boot/bzImage after compilation)

-- 
~Randy
