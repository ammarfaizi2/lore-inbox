Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267362AbUJIUR2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267362AbUJIUR2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 16:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267377AbUJIUPL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 16:15:11 -0400
Received: from LPBPRODUCTIONS.COM ([68.98.211.131]:31618 "HELO
	lpbproductions.com") by vger.kernel.org with SMTP id S267362AbUJIUOC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 16:14:02 -0400
From: Matt Heler <lkml@lpbproductions.com>
Reply-To: lkml@lpbproductions.com
To: "Ed Schouten" <ed@il.fontys.nl>
Subject: Re: [Patch 1/5] xbox: add 'CONFIG_X86_XBOX' to kernel configuration
Date: Sat, 9 Oct 2004 13:15:10 -0700
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <64778.217.121.83.210.1097351837.squirrel@217.121.83.210>
In-Reply-To: <64778.217.121.83.210.1097351837.squirrel@217.121.83.210>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410091315.10988.lkml@lpbproductions.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why can't theese patches be maintained outside the kernel tree , as it is 
now ? 

I'm strongly against this because the X-Box is a gaming platform and last I 
heard ( and I could be wrong here ) is that you had to hack your X-Box in 
order to load any other os then the one supplied with it. I just don't see a 
justified reason why theese patches should be included into the kernel. 

matt



On Saturday 09 October 2004 12:57 pm, Ed Schouten wrote:
> In order to support the Microsoft Xbox, we need to add a config option
> 'CONFIG_X86_XBOX'.
>
> You can also download this patch at:
> http://linux.g-rave.nl/patches/patch-xbox-config_option.diff
> ---
>
>  Kconfig |   14 +++++++++++++-
>  1 files changed, 13 insertions(+), 1 deletion(-)
>
> diff -u -r --new-file linux-2.6.9-rc3/arch/i386/Kconfig
> linux-2.6.9-rc3-ed0/arch/i386/Kconfig
> --- linux-2.6.9-rc3/arch/i386/Kconfig	2004-09-30 05:03:56.000000000 +0200
> +++ linux-2.6.9-rc3-ed0/arch/i386/Kconfig	2004-10-09 19:32:33.981610000
> +0200 @@ -55,6 +55,18 @@
>
>  	  If unsure, choose "PC-compatible" instead.
>
> +config X86_XBOX
> +	bool "Microsoft Xbox"
> +	help
> +	  This option is needed to make Linux boot on a Microsoft Xbox.
> +
> +	  If you are not planning on running this kernel on a Microsoft Xbox,
> +	  say N here, otherwise the kernel you build will not be bootable.
> +
> +	  For more information about Xbox Linux, visit:
> +
> +	  http://www.xbox-linux.org/
> +
>  config X86_VOYAGER
>  	bool "Voyager (NCR)"
>  	help
> @@ -1206,7 +1218,7 @@
>
>  config X86_BIOS_REBOOT
>  	bool
> -	depends on !(X86_VISWS || X86_VOYAGER)
> +	depends on !(X86_VISWS || X86_VOYAGER || X86_XBOX)
>  	default y
>
>  config X86_TRAMPOLINE
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
