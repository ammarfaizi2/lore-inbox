Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268193AbUIGU3R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268193AbUIGU3R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 16:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268580AbUIGU1v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 16:27:51 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:58777 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S268193AbUIGUWU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 16:22:20 -0400
Date: Tue, 7 Sep 2004 13:22:18 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] update arch/ppc/defconfig
Message-ID: <20040907202218.GH20951@smtp.west.cox.net>
References: <20040907200013.GA14330@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040907200013.GA14330@suse.de>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2004 at 10:00:13PM +0200, Olaf Hering wrote:

> run make oldconfig, and enable a few useful options.
> 
> Signed-off-by: Olaf Hering <olh@suse.de>
[snip]
> @@ -724,12 +742,12 @@ CONFIG_SERIAL_8250_NR_UARTS=4
>  # Non-8250 serial port support
>  #
>  CONFIG_SERIAL_CORE=y
> +CONFIG_SERIAL_CORE_CONSOLE=y
>  CONFIG_SERIAL_PMACZILOG=y
> -# CONFIG_SERIAL_PMACZILOG_CONSOLE is not set
> +CONFIG_SERIAL_PMACZILOG_CONSOLE=y

Is it all that common for pmacs to be using a serial console?

[snip]
>  # Graphics support
>  #
>  CONFIG_FB=y
> +CONFIG_FB_MODE_HELPERS=y
> +# CONFIG_FB_CIRRUS is not set

If that's working again, we should enable it, Mot PRePs have those
cards.

> @@ -897,9 +929,9 @@ CONFIG_FONT_8x16=y
>  # Logo configuration
>  #
>  CONFIG_LOGO=y
> -CONFIG_LOGO_LINUX_MONO=y
> +# CONFIG_LOGO_LINUX_MONO is not set
>  CONFIG_LOGO_LINUX_VGA16=y
> -CONFIG_LOGO_LINUX_CLUT224=y
> +# CONFIG_LOGO_LINUX_CLUT224 is not set

Er, is there a good reason to have only the 16color one?

> @@ -1176,8 +1215,9 @@ CONFIG_EXT2_FS=y
>  # CD-ROM/DVD Filesystems
>  #
>  CONFIG_ISO9660_FS=y
> -# CONFIG_JOLIET is not set
> -# CONFIG_ZISOFS is not set
> +CONFIG_JOLIET=y
> +CONFIG_ZISOFS=y
> +CONFIG_ZISOFS_FS=y

Ick, please no.

> @@ -1212,7 +1252,7 @@ CONFIG_HFSPLUS_FS=m
>  # CONFIG_BEFS_FS is not set
>  # CONFIG_BFS_FS is not set
>  # CONFIG_EFS_FS is not set
> -# CONFIG_CRAMFS is not set
> +CONFIG_CRAMFS=m

Why?

> +#
>  # Kernel hacking
>  #
> -# CONFIG_DEBUG_KERNEL is not set
> +CONFIG_DEBUG_KERNEL=y

Why?

-- 
Tom Rini
http://gate.crashing.org/~trini/
